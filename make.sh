#!/bin/bash
#
# Compiles a table from Ohio State University Acarology Collection data
#

set -xe

extract_associations() {
echo -e "collecting_unit_id\twasDerivedFrom\tsourceTaxonId\tsourceTaxonName\tsourceTaxonAuthorship\tinteractionTypeName\ttargetTaxonId\ttargetTaxonName\ttargetTaxonAuthorship\ttargetTaxonStatus"

preston ls\
 --anchor hash://sha256/fb23140e60f4889de35ae174b2570cf294012bff4f2c8c419c292af51c98c25f\
 | grep "hol/collecting_units"\
 | grep hasVersion\
 | preston mbd-stream\
 | jq --raw-output '[.collecting_unit_id,.["http://www.w3.org/ns/prov#wasDerivedFrom"],.sourceTaxonId,.sourceTaxonName,.sourceTaxonAuthorship,.interactionTypeName,.targetTaxonId,.targetTaxonName,.targetTaxonAuthorship,.targetTaxonStatus] | @tsv'
}

extract_specimen() {

PROPERTY_NAMES=$(cat sample.json | jq --raw-output '.records[] | to_entries | .[].key' | grep -v s$ | sort | uniq | tr '\n' ',')

preston ls\
 --anchor hash://sha256/fb23140e60f4889de35ae174b2570cf294012bff4f2c8c419c292af51c98c25f\
 | grep hasVersion\
 | grep -v hol/collecting_unit\
 | preston cat\
 | jq -c '.records[]'\
 | sed  '/^$/d'\
 | mlr --ijsonl --otsvlite cut\
 -f ${PROPERTY_NAMES}\
 | sed 's/null/NA/g'
}

#!/bin/bash
#
#

associations=$(mktemp)
specimen=$(mktemp)

extract_associations\
 | sed '/^$/d'\
 | mlr --tsvlite reorder -f collecting_unit_id\
 | head -n1\
 > ${associations}

extract_associations\
 |  sed '/^$/d'\
 | mlr --tsvlite reorder -f collecting_unit_id\
 | tail -n+2\
 | sed '/^$/d'\
 | sort\
 >> ${associations}

extract_specimen\
 | sed '/^$/d'\
 | mlr --tsvlite reorder -f collecting_unit_id\
 | head -n1\
 > ${specimen}

extract_specimen\
 | sed '/^$/d'\
 | mlr --tsvlite reorder -f collecting_unit_id\
 | tail -n+2\
 | sort >> ${specimen}

join --header -t $'\t'\
 ${specimen}\
 ${associations}

#!/bin/bash
#
#

extract_collecting_unit_id() {
  preston cat $1\
  | xmllint --html --xmlout --xpath 'string(//div/@additional_parameters)' -\
  | jq --raw-output '.["collecting_unit_id"]'
}

extract_association_table() {
  local targetNames=$(preston cat $1\
  | xmllint --html --xmlout --xpath '//div[@id="unvouchered-association"]//tbody/tr/td[position() mod 2 = 1]//text()' -\
  | sed 's+\([^|]*\)[|].*+\1+g'\
  | sed  '/^$/d')

  local interactionTypesWithContext=$(preston cat $1\
  | xmllint --html --xmlout --xpath '//div[@id="unvouchered-association"]//tbody/tr/td[position() mod 2 = 0]//text()' -\
  | sed '/^$/d'\
  | sed "s+^+https://linker.bio/$1\thttps://mbd-db.osu.edu/hol/collecting_units/$2\t+g")

  paste <(echo "$interactionTypesWithContext") <(echo "$targetNames")\
  | sed '/^$/d'
}

extract_host_vouchered_associations() {
  preston cat $1\
  | xmllint --html --xmlout --xpath "//h3[@aria-controls='#collecting_unit-association_parents']" -
}

extract_parasite_vouchered_associations() {
  preston cat $1\
  | xmllint --html --xmlout --xpath "//h3[@aria-controls='#collecting_unit-association_children']" -
}

extract_associations() {
  local contentId=$1
  unit_id=$(extract_collecting_unit_id $contentId)
  extract_association_table $contentId $unit_id
}

echo -e "contentId\tspecimenId\tinteractionTypeName\ttargetTaxonName\n"

for contentId in $(preston ls\
 | grep "hol/collecting_units"\
 | grep hasVersion\
 | grep -oE "hash://sha256/[a-f0-9]{64}")
do
  extract_associations "$contentId"
done


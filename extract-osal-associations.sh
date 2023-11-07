#!/bin/bash
#
#

extract_collecting_unit_id() {
  preston cat $1\
  | xmllint --html --xmlout --xpath 'string(//div/@additional_parameters)' -\
  | jq --raw-output '.["collecting_unit_id"]'
}

extract_association_table() {
  preston cat $1\
  | xmllint --html --xmlout --xpath "//div[@id='unvouchered-association']/table" -\
  | html2text\
  | tail -n+2\
  | sed "s+^+$1\t$2\t+g"\
  | sed "s/|[ ]/\t/g"
}


extract_associations() {
  local contentId=$1
  unit_id=$(extract_collecting_unit_id $contentId)
  extract_association_table $contentId $unit_id
}

for contentId in $(preston ls\
 | grep "hol/collecting_units"\
 | grep hasVersion\
 | grep -oE "hash://sha256/[a-f0-9]{64}")
do
  extract_associations "$contentId"
done


#!/bin/bash
#
# Track Ohio State Acarology Collection
# OSAL
# 

set -xe


track_records() {
  PAGE_COUNT=$(curl https://mbd-db.osu.edu/api/v1/backend_table/hol/taxon_name/collecting_units/records?taxon_name_id=05fbf4bb-f8e1-404e-a27c-759d345aa4d0 | jq --raw-output ".page_count")
  seq 1 "${PAGE_COUNT}"\
  | sed 's+^+https://mbd-db.osu.edu/api/v1/backend_table/hol/taxon_name/collecting_units/records?taxon_name_id=05fbf4bb-f8e1-404e-a27c-759d345aa4d0\&page=+g'\
  | xargs -L25 preston track
}

track_units() {
  preston ls\
   | grep hasVersion\
   | preston cat\
   | jq -c --raw-output '.records[]'\
   | jq --raw-output '.["collecting_unit_id"]'\
   | sed 's+^+https://mbd-db.osu.edu/hol/collecting_units/+g'\
   | xargs -L25 preston track
}

track_records
track_units

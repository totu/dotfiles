#!/bin/bash
SICK_URL="https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/Historic_adm0_v3/FeatureServer/0/query?f=json&where=ADM0_NAME%3D%27Finland%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=OBJECTID%2CNewCase%2Ccum_conf%2CDateOfDataEntry&orderByFields=DateOfDataEntry%20asc&resultOffset=0&resultRecordCount=2000&cacheHint=true"
DEATH_URL="https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/Cases_by_country_pt_V3/FeatureServer/0/query?f=json&where=ADM0_NAME%3D%27Finland%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22%3A%22sum%22%2C%22onStatisticField%22%3A%22cum_death%22%2C%22outStatisticFieldName%22%3A%22value%22%7D%5D&outSR=102100&cacheHint=true"
SICK_FILE="$HOME/.cache/corona"
DEATH_FILE="$HOME/.cache/corona_death"

[[ $(stat -t '%y-%m-%d' $SICK_FILE 2>/dev/null | cut -d' ' -f10 | sed 's/"//g') != $(date -u +"%y-%m-%d") ]] &&
    curl -s $SICK_URL > $SICK_FILE

[[ $(stat -t '%y-%m-%d' $DEATH_FILE 2>/dev/null | cut -d' ' -f10 | sed 's/"//g') != $(date -u +"%y-%m-%d") ]] &&
    curl -s $DEATH_URL > $DEATH_FILE

DATA=$(awk -F'},{' '{ print $NF }' $SICK_FILE | sed 's/:/,/g')
DATE=$(awk -F',' '{ print $9}' <<< $DATA | awk -F'}' '{ print $1 }')

echo $((DATE / 1000))

DEATH_DATA=$(awk -F'"value":' '{ print $2 }' $DEATH_FILE | cut -d'}' -f1)

echo $DATA,$DEATH_DATA| awk -F',' '{ print "😷 " $7 " (" $5 ") 💀 " $NF}'


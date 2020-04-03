#!/bin/bash
URL="https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaData/v2"
FILE="$HOME/.cache/corona"

if [[ $(uname -s) = "Linux" ]]; then
    TODAY=$(date +"%Y-%m-%d")
    STAT=$(stat --format='%y-%m-%d' $FILE | cut -d' ' -f1)
else
    TODAY=$(date -u +"%y-%m-%d")
    STAT=$(stat -t '%y-%m-%d' $FILE 2>/dev/null | cut -d' ' -f10 | sed 's/"//g')
fi

[[ $TODAY != $STAT ]] &&
    curl -s $URL > $FILE &&
    date >> $HOME/.corona_time

corona_parser.py $FILE $1

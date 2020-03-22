#!/bin/bash
URL="https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaData"
FILE="$HOME/.cache/corona"

[[ $(stat -t '%y-%m-%d' $FILE 2>/dev/null | cut -d' ' -f10 | sed 's/"//g') != $(date -u +"%y-%m-%d") ]] &&
    curl -s $URL > $FILE

corona_parser.py $FILE

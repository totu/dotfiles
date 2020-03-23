#!/bin/bash

OUT=output.mp4

if [ ! -z "$1" ]; then
    OUT=$1
fi

ffmpeg -f x11grab -framerate 60 -s 1920x1040 -i $DISPLAY+0,490 "$OUT"

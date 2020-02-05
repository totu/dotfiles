#!/bin/bash
qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus > /dev/null
if [ "$?" -eq 0 ]; then
    STATUS="$(qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)"
    if [ "$STATUS" == "Paused" ]; then
        echo "⏸"
    else
        echo "▶"
    fi
else
    echo ""
fi

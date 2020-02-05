#!/usr/bin/env python3
"""prints Spotify's now playing from dbus"""
import dbus

SESSION_BUS = dbus.SessionBus()
SPOTIFY_BUS = SESSION_BUS.get_object(
    "org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2"
)
SPOTIFY_PROPERTIES = dbus.Interface(SPOTIFY_BUS, "org.freedesktop.DBus.Properties")
METADATA = SPOTIFY_PROPERTIES.Get("org.mpris.MediaPlayer2.Player", "Metadata")
STATUS = SPOTIFY_PROPERTIES.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")

# Just in case we want to also show status when not playing
PRINT_STATUS = "⏸" if STATUS == "Paused" else "▶"

if STATUS != "Paused":
    PRINT_STRING = "%s - %s" % (METADATA["xesam:artist"][0], METADATA["xesam:title"])
    if len(PRINT_STRING) > 60:
        PRINT_STRING = "%s..." % PRINT_STRING[:57]
    print(PRINT_STATUS, PRINT_STRING)

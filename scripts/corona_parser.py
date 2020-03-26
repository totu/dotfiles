#!/usr/bin/env python3
import sys
import json
import datetime

TODAY = datetime.datetime.now().strftime("%Y-%m-%d")


def parse_data(data):
    global TODAY
    YESTERDAY = TODAY.split("-")
    YESTERDAY = "-".join([YESTERDAY[0], YESTERDAY[1], str(int(YESTERDAY[2]) + 1)])
    count = len(data)
    today = len([x for x in data if x["date"].split("T")[0] == TODAY])
    yesterday = len([x for x in data if x["date"].split("T")[0] == YESTERDAY])
    return count, today, yesterday


def main(data, colors):
    # Confirmed cases
    confirmed, confirmed_today, confirmed_yesterday = parse_data(data["confirmed"])

    # Deaths
    deaths = len(data["deaths"])
    mortality = deaths / confirmed

    # Recoveries
    _, recovered_today, recovered_yesterday = parse_data(data["recovered"])

    # Case delta count
    delta = "▼" if confirmed_yesterday - confirmed_today < 0 else "▲"

    # Figure out color for delta
    delta_color = colors.green if confirmed_yesterday - confirmed_today < 0 else colors.red

    out = "😷%s%s%s%s (%s+%s%s/%s-%s%s) 💀%s" % (
        confirmed,
        delta_color,
        delta,
        colors.end,
        colors.red,
        confirmed_today,
        colors.end,
        colors.green,
        recovered_today,
        colors.end,
        deaths,
    )
    if mortality > 0.1:
        out += " (%0.1f%s)" % (mortality, "%")

    print(out)


if __name__ == "__main__":
    data = None

    class colors:
        green = "\033[92m"
        red = "\033[91m"
        end = "\033[0m"

    # If we are in tmux use tmux colors
    if len(sys.argv) == 3 and sys.argv[2] == "--tmux":

        class colors:
            green = "#[fg=colour10]"
            red = "#[fg=colour9]"
            end = "#[fg=brightwhite]"

    with open(sys.argv[1], "r") as data_file:
        data = json.loads(data_file.readlines()[0])

    main(data, colors)

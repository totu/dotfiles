#!/usr/bin/env python3
from os.path import expanduser, join
from subprocess import Popen, PIPE, STDOUT
import argparse
import sqlite3


def parse_args():
    parser = argparse.ArgumentParser(
        description="Experimental time tracking tool.", usage=""
    )
    parser.add_argument("--start", help="Start tracker with name.")
    parser.add_argument("--stop", help="Stop current trakcer.")
    parser.add_argument(
        "--report", action="store_true", help="Print report for current week."
    )
    parser.add_argument(
        "--full-report", action="store_true", help="Print full tracking report."
    )

    args = parser.parse_args()

    # Check if we have any valid arguments, if not print help
    asd = [arg for arg in vars(args) if getattr(args, arg)]
    if not asd:
        parser.print_help()

    return args


def get_window_name():
    cmd = "tmux display-message -p #W"
    command = Popen(cmd.split(" "), stdout=PIPE, stderr=STDOUT)
    out, _ = command.communicate()
    return out.decode("utf-8")


def main():
    args = parse_args()
    window = get_window_name()
    # We don't care about unnamed windows currently
    if window in ["bash"]:
        exit()

    db_name = join(expanduser("~"), ".timetracking.db")
    db_connection = sqlite3.connect(db_name)
    db_cursor = db_connection.cursor()
    # db_cursor.execute()


if __name__ == "__main__":
    main()

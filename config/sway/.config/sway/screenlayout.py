#!/usr/bin/env python3

import argparse
import subprocess
import sys

from dataclasses import dataclass
from enum import Enum
from typing import Tuple

LAPTOP_SCREEN_HOME = "eDP-1"


class Location(Enum):
    HOME = "home"

    def __str__(self):
        return self.value


@dataclass
class Screen:
    name: str
    resolution: str
    position: Tuple[int, int]
    background: Tuple[str, str]
    args: Tuple = ()


_SCREEN_LAYOUTS_VEGA = {
    (None, "default"): [
        Screen(
            LAPTOP_SCREEN_HOME,
            "2560x1440",
            (0, 0),
            ("$config/bg/TorresDelPaine.jpg", "fill"),
            ("scale", "1"),
        )
    ],
    (Location.HOME, "two_external_screens"): [
        Screen(
            "HDMI-A-2",
            "2560x1440",
            (0, 0),
            ("~/.config/bg/TresMarias.jpg", "fill"),
        ),
        Screen(
            "DP-1",
            "2560x1440",
            (2560, 0),
            ("~/.config/bg/TorresDelPaine.jpg", "fill"),
        ),
    ],
}


def get_connected_screens():
    """
    Returns the connected screens.
    """
    # Query available screens
    swaymsg_output = subprocess.run(
        ["swaymsg", "-p", "-t", "get_outputs"],
        check=True,
        capture_output=True,
        text=True,
    ).stdout

    connected_screens = []
    for line in swaymsg_output.split("\n"):
        line = line.strip()
        if line.startswith("Output") and not line.endswith("(disabled)"):
            screen_name = line.split()[1]
            connected_screens.append(screen_name)

    return connected_screens


def configure_screenlayout(config):
    assert config in _SCREEN_LAYOUTS_VEGA

    connected_screens = get_connected_screens()
    for screen in connected_screens:
        subprocess.run(["swaymsg", "output", screen, "power", "off"], check=True)

    # Configure screen layout
    screens = _SCREEN_LAYOUTS_VEGA[config]
    for screen in reversed(screens):
        # Enable screen
        subprocess.run(["swaymsg", "output", screen.name, "power", "on"], check=True)
        # Configure screen
        swaymsg_cmd = [
            "swaymsg",
            "output",
            screen.name,
            "resolution",
            screen.resolution,
            "position",
            str(screen.position[0]),
            str(screen.position[1]),
            "background",
            screen.background[0],
            screen.background[1],
            *screen.args,
        ]
        subprocess.run(swaymsg_cmd, check=True)


def screenlayout_config(s: str):
    if s == "default":
        return (None, s)

    config = s.split(":")
    if len(config) != 2:
        raise argparse.ArgumentTypeError(f"invalid argument: {s}")

    loc_str, screenlayout_str = config
    try:
        return (Location[loc_str.upper()], screenlayout_str)
    except KeyError:
        raise argparse.ArgumentTypeError(
            f"invalid argument: unknown location: {loc_str}"
        )


def build_parser():
    parser = argparse.ArgumentParser(description="Configure screenlayout")
    parser.add_argument(
        "config",
        nargs="?",
        type=screenlayout_config,
        default="default",
        help="Screenlayout configuration: default or hostname:layout",
    )

    return parser


def main(args=None):
    parser = build_parser()
    args = parser.parse_args(args=args)

    configure_screenlayout(args.config)


if __name__ == "__main__":
    sys.exit(main())

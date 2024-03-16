#!/usr/bin/env python3

import argparse
import subprocess

from dataclasses import dataclass
from enum import Enum

LAPTOP_SCREEN_HOME = "eDP-1"
LAPTOP_SCREEN_WORK = "DP-4"


class Location(Enum):
    HOME = 0
    WORK = 1


@dataclass
class Screen:
    name: str
    resolution: str


SCREEN_LAYOUTS = {
    "home": (
        Location.HOME,
        [
            Screen("HDMI-2", "2560x1440"),
            Screen("DP-1", "2560x1440"),
        ],
    ),
    "home_laptop_only": (
        Location.HOME,
        [Screen(LAPTOP_SCREEN_HOME, "auto")],
    ),
    "work": (
        Location.WORK,
        [
            Screen("DP-1.1.6", "2560x1440"),
            Screen("DP-1.1.5", "2560x1440"),
        ],
    ),
    "work_laptop_only": (
        Location.WORK,
        [Screen(LAPTOP_SCREEN_WORK, "auto")],
    ),
    "work_presentation": (
        Location.WORK,
        [
            Screen("HDMI-0", "2560x1440"),
            Screen(LAPTOP_SCREEN_WORK, "2560x1440"),
        ],
    ),
    "work_at_home": (
        Location.HOME,
        [
            Screen("HDMI-0", "2560x1440"),
            Screen("DP-1", "2560x1440"),
        ],
    ),
}


def get_laptop_screen(location):
    """
    Returns the laptop screen's identifier.
    """
    assert isinstance(location, Location)

    if location == Location.HOME:
        return LAPTOP_SCREEN_HOME

    return LAPTOP_SCREEN_WORK


def get_connected_screens():
    """
    Returns the connected screens.
    """
    # Query available screens
    xrandr_output = (
        subprocess.check_output(["xrandr", "--query"])
        .decode()
        .strip()
        .split("\n")
    )
    connected_screens = []
    for line in xrandr_output:
        if " connected " in line:
            screen_info = line.split()
            screen_name = screen_info[0]
            connected_screens.append(screen_name)
    return connected_screens


def is_laptop_screen_on(location):
    """
    Returns whether the laptop screen should be switched on.
    """
    assert isinstance(location, Location)

    return location is Location.WORK


def configure_screenlayout(layout_name):
    assert layout_name in SCREEN_LAYOUTS

    location, screens = SCREEN_LAYOUTS[layout_name]

    connected_screens = get_connected_screens()

    # Depending on the `location` turn off all connected screens except the
    # laptop screen (i.e. in this case the laptop screen always is turned on)
    if is_laptop_screen_on(location):
        connected_screens.pop(
            connected_screens.index(get_laptop_screen(location))
        )

    xrandr_cmd = ["xrandr"]
    for screen in connected_screens:
        xrandr_cmd.extend(["--output", screen, "--off"])
    subprocess.run(xrandr_cmd)

    # Set screen outputs and modes using xrandr
    xrandr_cmd = ["xrandr"]
    for screen in reversed(screens):
        output = screen.name
        mode = screen.resolution

        # Add screen mode
        xrandr_cmd.extend(["--output", output])

        if mode == "auto":
            xrandr_cmd.append("--auto")
        else:
            xrandr_cmd.extend(["--mode", mode])

        # Add screen position
        if screen != screens[-1]:
            left_of = screens[screens.index(screen) + 1].name
            xrandr_cmd.extend(["--left-of", left_of])

        # Set first screen as primary
        if screen == screens[0]:
            xrandr_cmd.append("--primary")

    # print(xrandr_cmd)
    subprocess.run(xrandr_cmd)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Configure screenlayout")
    parser.add_argument(
        "config",
        nargs="?",
        choices=SCREEN_LAYOUTS.keys(),
        help="Screenlayout configuration",
    )
    args = parser.parse_args()

    configure_screenlayout(args.config)

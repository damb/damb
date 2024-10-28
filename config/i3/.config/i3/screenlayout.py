#!/usr/bin/env python3

import argparse
import subprocess
import socket

from dataclasses import dataclass
from enum import Enum

_HOSTNAMES = ("vega", "pluto")
_LOCATIONS = ("home", "work")

_LAPTOP_SCREEN_VEGA = "eDP-1"
_LAPTOP_SCREEN_PLUTO = "eDP-1"


class Location(Enum):
    HOME = 0
    WORK = 1


@dataclass
class Screen:
    name: str
    resolution: str


_SCREEN_LAYOUTS_VEGA = {
    (None, "default"): [Screen(_LAPTOP_SCREEN_VEGA, "auto")],
    (Location.HOME, "two_external_screens"): [
        Screen("HDMI-2", "2560x1440"),
        Screen("DP-1", "2560x1440"),
    ],
}

_SCREEN_LAYOUTS_PLUTO = {
    (None, "default"): [Screen(_LAPTOP_SCREEN_PLUTO, "auto")],
    (Location.WORK, "presentation"): [
        Screen("HDMI-1-0", "3840x2160"),
        Screen(_LAPTOP_SCREEN_PLUTO, "2560x1600"),
    ],
    (Location.WORK, "two_external_screens"): [
        Screen("DP-1-1.1.6", "2560x1440"),
        Screen("DP-1-1.1.5", "2560x1440"),
    ],
    (Location.HOME, "two_external_screens"): [
        Screen("HDMI-1-0", "2560x1440"),
        Screen("DP-1-1", "2560x1440"),
    ],
}


def get_hostname():
    """
    Returns the hostname without domain name
    """
    return socket.gethostname().split(".")[0]


def is_known_hostname(hostname):
    """
    Returns `True` if the hostname is known.
    """
    return hostname in _HOSTNAMES


def get_laptop_screen(hostname):
    """
    Returns the laptop screen's identifier.
    """
    assert is_known_hostname(hostname)

    if hostname == "vega":
        return _LAPTOP_SCREEN_VEGA

    return _LAPTOP_SCREEN_PLUTO


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


def get_location_from_str(s: str):
    assert s in _LOCATIONS

    if s == "home":
        return Location.HOME

    return Location.WORK


def is_laptop_screen_enabled(location):
    """
    Returns whether the laptop screen should be switched on.
    """
    assert isinstance(location, Location)

    return location is Location.WORK


def configure_screenlayout(hostname, config):
    assert is_known_hostname(hostname)

    SCREEN_LAYOUTS = (
        _SCREEN_LAYOUTS_VEGA if hostname == "vega" else _SCREEN_LAYOUTS_PLUTO
    )
    assert config in SCREEN_LAYOUTS

    screens = SCREEN_LAYOUTS[config]
    location, _ = config

    connected_screens = get_connected_screens()

    # Depending on the `location` turn off all connected screens except the
    # laptop screen (i.e. in this case the laptop screen always is turned on)
    if location is not None and is_laptop_screen_enabled(location):
        connected_screens.pop(
            connected_screens.index(get_laptop_screen(hostname))
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


def screenlayout_config(s: str):
    if s == "default":
        return (None, s)

    config = s.split(":")
    if len(config) != 2:
        raise argparse.ArgumentError(f"invalid argument: {s}")

    loc_str, screenlayout = config

    if loc_str not in _LOCATIONS:
        raise argparse.ArgumentError(f"invalid argument: {s}")

    return (get_location_from_str(loc_str), screenlayout)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Configure screenlayout")
    parser.add_argument(
        "config",
        nargs="?",
        type=screenlayout_config,
        default="default",
        help='Screenlayout configuration. "default" or "location:layout"',
    )
    args = parser.parse_args()

    configure_screenlayout(get_hostname(), args.config)

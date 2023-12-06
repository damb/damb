#!/usr/bin/env python3

import argparse
import subprocess

# from collections import namedtuple
from dataclasses import dataclass
from enum import Enum

LAPTOP_SCREEN_HOME = "eDP-1"
LAPTOP_SCREEN_WORK = "DP-4"


class Location(Enum):
    HOME = 0
    WORK = 1


# Screen = namedtuple('Screen', ['name', 'resolution', 'workspaces'])


@dataclass
class Screen:
    name: str
    resolution: str
    workspaces: range


WORKSPACE_LAYOUTS = {
    "home": (
        Location.HOME,
        [
            Screen("HDMI-2", "2560x1440", range(0, 5)),
            Screen("DP-1", "2560x1440", range(5, 9)),
        ],
    ),
    "home_laptop_only": (
        Location.HOME,
        [Screen(LAPTOP_SCREEN_HOME, "auto", range(0, 10))],
    ),
    # "work_presentation": (
    #     Location.WORK,
    #     [
    #         Screen("HDMI-1-0", "1920x1080", range(0, 5)),
    #         Screen(LAPTOP_SCREEN_WORK, "1920x1080", range(5, 10)),
    #     ],
    # ),
    "work": (
        Location.WORK,
        [
            Screen("DP-1.1.6", "2560x1440", range(0, 5)),
            Screen("DP-1.1.5", "2560x1440", range(5, 9)),
        ],
    ),
    "work_laptop_only": (
        Location.WORK,
        [Screen(LAPTOP_SCREEN_WORK, "auto", range(0, 10))],
    ),
    # "hp": [
    #     Screen("VGA-1", 'auto', range(0, 9)),
    #     Screen("LVDS-1", '1920x1080', range(9, 10))
    # ],
}


def get_laptop_screen(location):
    """
    Returns the laptop screen's identifier.
    """
    assert isinstance(location, Location)

    if location == Location.HOME:
        return LAPTOP_SCREEN_HOME

    return LAPTOP_SCREEN_WORK


# def get_connected_screens():
#     # Query available screens
#     xrandr_output = subprocess.check_output(["xrandr", "--listmonitors"]).decode().strip().split("\n")
#     connected_screens = [line.split()[3] for line in xrandr_output[1:]]
#     return connected_screens


def get_connected_screens():
    # Query available screens
    xrandr_output = (
        subprocess.check_output(["xrandr", "--query"]).decode().strip().split("\n")
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
    return location is Location.WORK


def reorder_workspaces(layout_name):
    assert layout_name in WORKSPACE_LAYOUTS
    location, screens = WORKSPACE_LAYOUTS[layout_name]

    connected_screens = get_connected_screens()

    # Depending on the `location` turn off all connected screens except the
    # laptop screen (i.e. in this case the laptop screen always is turned on)
    if is_laptop_screen_on(location):
        connected_screens.pop(connected_screens.index(get_laptop_screen(location)))

    xrandr_cmd = ["xrandr"]
    for screen in connected_screens:
        xrandr_cmd.extend(["--output", screen, "--off"])
    print("Turning off screens with command:")
    print(xrandr_cmd)
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

        print(f"Setting {output} to mode {mode}")

    print("Configuring screens with command:")
    print(xrandr_cmd)
    subprocess.run(xrandr_cmd)

    # Send the i3-msg commands to reorder the workspaces
    for screen in screens:
        for ws in screen.workspaces:
            cmd = [
                "i3-msg",
                f"workspace {ws + 1}, move workspace to output {screen.name} --no-auto-back-and-forth",
            ]
            print(cmd)
            print("But we didn't send the i3 command!")
            # subprocess.run(cmd)

    # i3msg_commands = []
    # for screen in screens:
    #     for ws in screen.workspaces:
    #         cmd = f"workspace {ws + 1}, move workspace to output {screen.name} --no-auto-back-and-forth"
    #         i3msg_commands.append(cmd)
    #
    # i3msg_batch_cmd = ["i3-msg"]
    # i3msg_batch_cmd.extend(i3msg_commands)
    # print(i3msg_batch_cmd)
    # subprocess.run(i3msg_batch_cmd)


if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(
        description="Reorder i3 workspaces based on configuration options"
    )
    parser.add_argument(
        "config",
        nargs="?",
        choices=WORKSPACE_LAYOUTS.keys(),
        help="Layout configuration",
    )
    args = parser.parse_args()

    # Reorder the workspaces
    reorder_workspaces(args.config)

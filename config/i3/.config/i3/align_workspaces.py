#!/usr/bin/env python3

import argparse
import subprocess
# from collections import namedtuple
from dataclasses import dataclass

# Screen = namedtuple('Screen', ['name', 'resolution', 'workspaces'])

@dataclass
class Screen:
    name: str
    resolution: str
    workspaces: range


LAPTOP_SCREEN = 'DP-4'

# TODO(damb): add configuration for `home`
WORKSPACE_LAYOUTS = {
    # "home": [
    #     Screen("HDMI-1-0", 'auto', range(0, 9)),
    #     Screen(LAPTOP_SCREEN, '1920x1080', range(9, 10))
    # ],
    # "presentation": [
    #     Screen("HDMI-1-0", '1920x1080', range(0, 5)),
    #     Screen(LAPTOP_SCREEN, '1920x1080', range(5, 10))
    # ],
    "work": [
        Screen("DP-1.1.6", '2560x1440', range(0, 5)),
        Screen("DP-1.1.5", '2560x1440', range(5, 9)),
    ],
    "laptop_only": [
        Screen(LAPTOP_SCREEN, 'auto', range(0, 10))
    ],
    # "hp": [
    #     Screen("VGA-1", 'auto', range(0, 9)),
    #     Screen("LVDS-1", '1920x1080', range(9, 10))
    # ],
}

# def get_connected_screens():
#     # Query available screens
#     xrandr_output = subprocess.check_output(["xrandr", "--listmonitors"]).decode().strip().split("\n")
#     connected_screens = [line.split()[3] for line in xrandr_output[1:]]
#     return connected_screens

def get_connected_screens():
    # Query available screens
    xrandr_output = subprocess.check_output(["xrandr", "--query"]).decode().strip().split("\n")
    connected_screens = []
    for line in xrandr_output:
        if " connected " in line:
            screen_info = line.split()
            screen_name = screen_info[0]
            connected_screens.append(screen_name)
    return connected_screens

def get_default_layout():
    # Find the matching workspace layout for the available screen names
    default_layout = WORKSPACE_LAYOUTS["laptop_only"]
    connected_screens = get_connected_screens()

    for layout in WORKSPACE_LAYOUTS.values():
        screen_names = [screen.name for screen in layout]
        if set(screen_names).issubset(set(connected_screens)):
            default_layout = layout
            break

    return default_layout

def reorder_workspaces(layout_name):
    # Determine the workspace layout based on the selected configuration or matching layout
    if layout_name in WORKSPACE_LAYOUTS:
        screens = WORKSPACE_LAYOUTS[layout_name]
    else:
        screens = get_default_layout()

    # Turn off all connected screens except the laptop screen
    connected_screens = get_connected_screens()
    connected_screens.pop(connected_screens.index(LAPTOP_SCREEN))
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

        if mode == 'auto':
            xrandr_cmd.append("--auto")
        elif mode == 'off':
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
            cmd = ["i3-msg", f"workspace {ws + 1}, move workspace to output {screen.name} --no-auto-back-and-forth"]
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
    parser = argparse.ArgumentParser(description="Reorder i3 workspaces based on configuration options")
    parser.add_argument("config", nargs="?", choices=WORKSPACE_LAYOUTS.keys(), help="Configuration option")
    args = parser.parse_args()

    # Reorder the workspaces
    reorder_workspaces(args.config)

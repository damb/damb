#! /bin/bash
hostname=$(hostname)

if [[ "${hostname}" = "vega" ]]
then
  screenlayout="home"
else
  screenlayout="work"
fi

i3-msg exec "$HOME/.config/i3/align_workspaces.py $screenlayout"

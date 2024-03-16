#!/usr/bin/env bash
hostname=$(hostname)

if [[ "${hostname}" = "vega" ]]
then
  screenlayout="home_laptop_only"
else
  screenlayout="work_laptop_only"
fi

i3-msg exec "$HOME/.config/i3/screenlayout.py $screenlayout"

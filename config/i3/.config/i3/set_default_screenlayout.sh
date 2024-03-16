#!/usr/bin/env bash
hostname=$(hostname)

if [[ "${hostname}" = "vega" ]]
then
  screenlayout="home"
else
  screenlayout="work"
fi

i3-msg exec "$HOME/.config/i3/screenlayout.py $screenlayout"

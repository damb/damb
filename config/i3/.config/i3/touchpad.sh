#!/usr/bin/env bash

# XXX(damb): the device id doesn't seem to persist over reboots
device_id=$(xinput list | grep Touchpad | grep -o 'id=[0-9]*' | cut -d'=' -f 2)

state=$(xinput list "${device_id}" | grep "disabled")
if [ -n "${state}" ]
then
  xinput enable "${device_id}"
else
  xinput disable "${device_id}"
fi

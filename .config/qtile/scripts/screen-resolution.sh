#!/usr/bin/env bash 


INTERNAL_MONITOR="eDP-2"
EXTERNAL_MONITOR="HDMI-1-0"
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  autorandr -l dual
else
  autorandr -l laptop
fi

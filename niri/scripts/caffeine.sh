#!/usr/bin/env bash

# A universal Wayland caffeine toggle
# Relies on systemd-inhibit which is respected by most idle daemons (like swayidle)

if pgrep -f "systemd-inhibit --what=idle.*caffeine"; then
    pkill -f "systemd-inhibit --what=idle.*caffeine"
    notify-send -t 2000 -u low -i "battery-good-symbolic" "Caffeine Disabled" "Screen will now sleep normally."
else
    # Run in background and disown
    systemd-inhibit --what=idle --who=Caffeine --why="caffeine-toggle" sleep infinity &
    notify-send -t 2000 -u low -i "battery-full-charged-symbolic" "Caffeine Enabled" "Screen sleep is inhibited."
fi

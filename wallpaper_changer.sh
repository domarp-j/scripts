#!/bin/bash

# Select & display a random wallpaper from ~/Dropbox/wallpapers

echo "Changing wallpaper..."

eval "date"

# Properly set the DBUS_SESSION_BUS_ADDRESS environment variable to properly render wallpaper
# Needed to run script as a cron job, since cron jobs work with a different sent of env variables 
# Details: https://askubuntu.com/questions/140305/cron-not-able-to-succesfully-change-background
# Interesting note: works fine if executed from CLI, since env variable is set properly 

# user=$(whoami)

# fl=$(find /proc -maxdepth 2 -user $user -name environ -print -quit)
# for i in {1..5}
# do
#   fl=$(find /proc -maxdepth 2 -user $user -name environ -newer "$fl" -print -quit)
# done

# export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2-)

PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

# Get number of files (minus 1) in wallpapers
COUNT="$(ls -l ~/Dropbox/wallpapers | grep -v ^d | wc -l )"
ACTUAL_COUNT=$(($COUNT+1))
echo "Wallpaper count: ${ACTUAL_COUNT}"

# Select random number from 0 to COUNT
RAND=$(( ( RANDOM % $COUNT ) ))
RAND_PLUS_ONE=$(($RAND+1))
echo "Selecting wallpaper ${RAND_PLUS_ONE}"

# Get file path of random wallpaper
WALLPAPERS=(~/Dropbox/wallpapers/*)
WP_PATH=${WALLPAPERS[$RAND]}
echo "Wallpaper file path: ${WP_PATH}"

# Set wallpaper
echo "Rendering ${WP_PATH}"
eval "gsettings set org.gnome.desktop.background picture-uri 'file:///${WP_PATH}'"

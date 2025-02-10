#!/usr/bin/env sh

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run with root privileges." >&2
  exit 1
fi

# Find the most recently modified monitors.xml in any user's .config directory
MONITORS_CFG_FILE=$(/usr/bin/find /home/*/.config -name monitors.xml -type f -exec /usr/bin/ls -t {} + | /usr/bin/head -n 1)
 
# Check if variable is empty
if [ -z "$MONITORS_CFG_FILE" ]; then
  echo 'No monitors.xml found'
  exit 1
fi
 
# Create the target directory if it doesn't exist
if [ ! -d /var/lib/gdm/.config ]; then
  mkdir -p /var/lib/gdm/.config
fi
 
# Copy the most recent monitors.xml to the target location
cp "$MONITORS_CFG_FILE" /var/lib/gdm/.config/monitors.xml
 
# Check if the copy operation was successful
if ! cp "$MONITORS_CFG_FILE" /var/lib/gdm/.config/monitors.xml; then
  echo 'Failed to copy monitors.xml to /var/lib/gdm/.config/'
  exit 1
fi

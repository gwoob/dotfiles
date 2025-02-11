#!/usr/bin/env sh

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run with root privileges." >&2
  exit 1
fi

# Find the most recently modified monitors.xml in any home directory
FILE=$(/usr/bin/find /home/*/.config -name monitors.xml -type f -exec /usr/bin/ls -t {} + | /usr/bin/head -n 1)

# Identify the user who owns the latest monitors.xml
USER=$(stat -c "%U" "$FILE")

# Identify the monitors.xml owner's mutter experimental features
FEATURES=$(run0 -u "$USER" dbus-launch gsettings get org.gnome.mutter experimental-features)

 # Create the target directory if it doesn't exist
if [ ! -d /var/lib/gdm/.config ]; then
  mkdir -p /var/lib/gdm/.config
fi

# Copy the most recent monitors.xml to the target location
if [ -n "$FILE" ]; then
  cp "$FILE" /var/lib/gdm/.config/monitors.xml
fi
 
# Check if the copy operation was successful
if ! cp "$FILE" /var/lib/gdm/.config/monitors.xml; then
  echo "Error: Failed to copy monitors.xml to /var/lib/gdm/.config/." >&2
  exit 1
fi

# Apply monitors.xml owner's experimental features to GDM if any are set
if [ -n "$FEATURES" ]; then
  run0 -u gdm dbus-launch gsettings set org.gnome.mutter experimental-features "$FEATURES"
fi

# Check if applying the experimental features was succesful
if ! run0 -u gdm dbus-launch gsettings set org.gnome.mutter experimental-features "$FEATURES"; then
  echo "Error: Failed to apply experimental features." >&2
  exit 1
fi

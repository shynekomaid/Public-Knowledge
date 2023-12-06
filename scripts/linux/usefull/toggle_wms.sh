#!/bin/bash

# WARNING! WORK ONLY WITH X ORG!

# You can run this script using hotkey "CapsLock" with xbindkeys.
# Install xbinkeys, create a file .xbindkeysrc in your home directory.
# Insert something like:
#
# "bash /home/scripts/toggle_wms.sh"
#        Caps_Lock
#
# Save and run "xbindkeys -p" to poll rc file.
#
# NOTE:
# If you need toggle CapsLock mode you can use "Shift+CapsLock" to toggle it.


# Check if using Wayland
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
  echo "WARNING: This script is only compatible with X11, not Wayland."
  exit 1
fi

# Turn off Caps Lock
python3 -c 'from ctypes import *; X11 = cdll.LoadLibrary("libX11.so.6"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'

# Check for required packages
required_packages=("python3" "wmctrl")
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! command -v "$package" >/dev/null 2>&1; then
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "The following packages are required but not installed:"
  printf -- "- %s\n" "${missing_packages[@]}"
  exit 1
fi

# Check number of workspaces
num_workspaces=$(wmctrl -d | wc -l)

if [ "$num_workspaces" -lt 2 ]; then
  echo "This script requires at least 2 workspaces."
  exit 1
fi

current_ws=$(wmctrl -d | awk '/\*/ {print $1}')

if [[ $current_ws -eq 1 ]]; then
  wmctrl -s 0
else
  wmctrl -s 1
fi

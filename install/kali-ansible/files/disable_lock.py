#!/usr/bin/env python3
"""
disable_lock.py
Disable automatic screen blank + lock on GNOME or XFCE desktops.
Run it once per user session.
"""

import os
import subprocess
import shutil
import sys

def run(cmd):
    print("->", " ".join(cmd))
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as err:
        print(f"   ! {err}; continuing")

def gnome():
    run(["gsettings", "set",
         "org.gnome.desktop.session", "idle-delay", "0"])
    run(["gsettings", "set",
         "org.gnome.desktop.screensaver", "lock-enabled", "false"])

def xfce():
    if not shutil.which("xfconf-query"):
        print("xfconf-query not found – skipping XFCE tweaks")
        return
    run([
        "xfconf-query", "-c", "xfce4-power-manager",
        "-p", "/xfce4-power-manager/lock-screen-suspend-hibernate",
        "-n", "-t", "bool", "-s", "false"
    ])
    # Make absolutely sure light-locker never runs again
    desktop = "/etc/xdg/autostart/light-locker.desktop"
    if os.path.exists(desktop):
        run(["sudo", "sed", "-i", "s/^Hidden=.*/Hidden=true/", desktop])

def main():
    de = os.environ.get("XDG_CURRENT_DESKTOP", "").lower()
    print(f"Detected DE: {de or 'unknown'}")
    if "gnome" in de:
        gnome()
    elif "xfce" in de:
        xfce()
    else:
        print("Unsupported desktop – nothing changed")
        sys.exit(1)

if __name__ == "__main__":
    main()

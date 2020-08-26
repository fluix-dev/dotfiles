#!/usr/bin/env python3
import os
from subprocess import run, Popen, PIPE
from time import sleep

# Your preferred terminal emulator
TERM = "alacritty"
DMENU = "wofi --dmenu"

# A script that's in your .zshrc or equivalent that the terminal will run
SCRIPT_FILE = os.path.expanduser("~/.config/scripts/startup.sh")

def term(command):
    with open(SCRIPT_FILE, "w") as f:
        f.write(command)
    Popen(TERM)
    sleep(0.3)
    open(SCRIPT_FILE, "w").close()

def select(options, back=exit):
    choice = run("echo -e '%s' | %s" % ('\n'.join(options), DMENU), shell=True, stdout=PIPE).stdout.decode().strip()
    if back and not choice:
        back()
    return choice

"""
    Starts a Django web server and opens two terminals.
"""
def webdev():
    # The location that will be searched for project folders
    PROJECT_DIR = os.path.expanduser("~/Projects")

    PROJECTS = [entry for entry in os.listdir(PROJECT_DIR) if os.path.isdir(os.path.join(PROJECT_DIR, entry))]

    SELECT = select(PROJECTS)

    run(["swaymsg", "workspace", "4a"])
    sleep(0.3)
    term("cd ~/Projects/%s && source env/bin/activate && python manage.py runserver" % SELECT)
    run(["swaymsg", "layout", "stacking"])
    sleep(0.3)
    term("cd ~/Projects/%s && s" % SELECT)
    run(["swaymsg", "splith"])
    sleep(0.3)
    term("cd ~/Projects/%s && s" % SELECT)

LAYOUTS = {
    "webdev": webdev,
}

if __name__ == "__main__":
    LAYOUTS[select(LAYOUTS.keys())]()

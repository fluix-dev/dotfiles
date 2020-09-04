#!/bin/env python3
import i3ipc
import subprocess

ipc = i3ipc.Connection()

TRUNCATE = 38
DMENU = "wofi --dmenu"

windows = []
for window in ipc.get_tree():
    if not window.app_id:
        continue
    if window.app_id == "floating":
        name = "[%s] * (%s)" % (window.workspace().name, window.name)
    elif window.app_id:
        name = "[%s] %s (%s)" % (window.workspace().name, window.app_id, window.name)
    else:
        name = "[%s] %s" % (window.workspace().name, window.name)
    windows.append((window, name[:TRUNCATE]))

options = '\n'.join([w[1] for w in windows])
proc = subprocess.run('echo "%s" | %s' % (options, DMENU), shell=True, stdout=subprocess.PIPE)

# Get dmenu output
selection = proc.stdout.decode().strip()
if selection == "\n":
    exit()

for window in windows:
    if window[1] == selection:
        window[0].command("focus")
        exit()

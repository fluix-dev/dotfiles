import glob
import json
import os
import subprocess
import sys
import time
from datetime import datetime

# Directory of https://github.com/mkropat/dapper-invoice clone
MAKE_DIR = os.path.expanduser("~/Projects/dapper-invoice/")

# Directory to output invoices
INVOICE_DIR = os.path.expanduser("~/Documents/invoices/%d/" % datetime.now().year)

# Create directories upon a new year
if not os.path.exists(INVOICE_DIR):
    os.makedirs(INVOICE_DIR)

# Template file acceptable for python's format() method
TEMPLATE_FILE = os.path.expanduser("~/.config/scripts/template.tex")

# Contains a list of JSON files that overwrite VARS
PROJECTS = glob.glob(os.path.expanduser("~/Documents/invoices/") + "*.json")

# Variables required for the template
VARS = {
    "num": int(time.time() / 100),
    "me": "",
    "business": "",
    "address": "",
    "phone": "",
    "email": "",
    "project": "",
    "client": "",
    "client_address": "",
    "client_name": "",
    "client_phone": "",
    "client_email": "",
    "items": "",
}

# Gets the list of project names from the JSON files
print("-=[ List of Projects ]=-")
for i, project in enumerate(PROJECTS):
    data = {}
    with open(project, "r") as f:
        data = json.loads(f.read())
    print(" %d: %s" % (i, data["project"]))

# Load in project data
with open(PROJECTS[int(input("Select project: "))]) as f:
    VARS = {**VARS, **json.loads(f.read())}

# Get invoice entries
print("-=[ Enter Items ]=-")
print("Enter nothing for the description to quit.")
items = []
total = 0
while True:
    description = input("Description: ")
    if not description:
        break
    amount = float(input("Amount: "))
    items += [{"description": description, "amount": amount,}]
    total += amount
VARS["total"] = total

# Save invoice as JSON
json_invoice = {**VARS, "items": items}
FILENAME = datetime.now().strftime("%Y-%m-%d-num-{num}".format(**VARS))
FILEPATH = os.path.join(INVOICE_DIR, FILENAME)
with open(FILEPATH + ".json", "w") as f:
    f.write(json.dumps(json_invoice, indent=2))

# Convert items into LaTeX
items_tex = ""
for item in items:
    items_tex += "\\lineitem{%s}{%.2f}\n" % (item["description"], item["amount"])
VARS["items"] = items_tex

# Convert total to LaTeX format
VARS["total"] = "%.2f" % total

# Write LaTeX file from template
template = ""
with open(TEMPLATE_FILE, "r") as f:
    template = f.read()
with open(FILEPATH + ".tex", "w") as f:
    f.write(template.format(**VARS))

# Generate pdf
subprocess.run(
    "cd %s && make %s.pdf && mv %s.pdf %s.pdf && rm %s.*"
    % (
        MAKE_DIR,
        FILEPATH,
        FILENAME,
        FILEPATH,
        os.path.join(MAKE_DIR, FILENAME),
    ),
    shell=True,
)

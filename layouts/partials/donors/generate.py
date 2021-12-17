#!/usr/bin/env python3

import csv
import html
import sys

with open(sys.argv[1], "r") as file:
    print("<ul>")
    reader = csv.reader(file, quotechar='"')
    rows=0
    for row in reader:
        if rows >= 1:
            name = html.escape(row[0].strip())
            if len(name) > 0:
                print("<li>" + name + "</li>")
        rows+=1
    print("</ul>")

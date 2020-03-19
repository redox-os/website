#!/usr/bin/env python3

import csv
import sys

with open(sys.argv[1], "r") as file:
    print("<ul>")
    reader = csv.reader(file, quotechar='"')
    rows=0
    for row in reader:
        if rows >= 2:
            print("<li>" + row[0] + "</li>")
        rows+=1
    print("</ul>")

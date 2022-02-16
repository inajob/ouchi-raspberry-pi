#!/usr/bin/env python
# -*- coding: utf-8 -*-

import html
import xml.etree.ElementTree as ET

count = 0

with open("get.txt", encoding="utf8") as f:
    s = f.read()
    x = html.unescape(s)
    #print(x)
    root = ET.fromstring(x)
    print(root) # Envelope
    print(root[0]) # Body
    print(root[0][0]) # BrowseResponse
    print(root[0][0][0]) # Result
    print(root[0][0][0][0]) # DITL-Lite
    for item in root[0][0][0][0]:
        print(count, item[0].text) # title
        count = count + 1
    print("count", count)

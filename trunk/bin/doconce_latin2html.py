#!/usr/bin/env python
"""
Substitute latin characters by their equivalent HTML encoding
in an HTML file. See doconce.html.latin2html for more
documentation.
"""
from doconce.html import latin2html
import os, shutil, sys
for filename in sys.argv[1:]:
    if not os.path.isfile(filename):
        continue
    oldfilename = filename + '.old~'
    shutil.copy(filename, oldfilename)
    print 'transformin latin characters to HTML encoding in', filename
    f = open(oldfilename, 'r')
    try:
        text = f.read()
        newtext = latin2html(text)
        f.close()
        f = open(filename, 'w')
        f.write(newtext)
        f.close()
    except Exception, e:
        print e.__class__.__name__, ':', e, 

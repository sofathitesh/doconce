#!/usr/bin/env python
"""Remove inline comments in a Doconce file."""
import sys, os, shutil

try:
    filename = sys.argv[1]
except IndexError:
    print 'Usage: doconce_remove_inline_comments.py doconcefile'
    sys.exit(1)

shutil.copy(filename, filename + '.old~~')
f = open(filename, 'r')
filestr = f.read()
f.close()
import doconce
filestr = doconce.doconce.subst_away_inline_comments(filestr)
f = open(filename, 'w')
f.write(filestr)
f.close()
print 'inline comments removed in', filename


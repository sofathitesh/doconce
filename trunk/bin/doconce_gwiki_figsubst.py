#!/usr/bin/env python
"""
Find all figures in a Doconce gwiki file and replace the comment with
a true URL made up of the local path to the filename and a URL stem.
"""
import sys, shutil, re
try:
    gwikifile = sys.argv[1]
    URLstem = sys.argv[2]
except IndexError:
    print 'Usage: %s wikifile URL-stem' % sys.argv[0]
    print 'Ex:    %s somefile.gwiki http://code.google.com/p/myproject/trunk/doc/somedir' % sys.argv[0]
    sys.exit(1)

# first grep out all filenames with local path:
shutil.copy(gwikifile, gwikifile + 'old~~')
f = open(gwikifile, 'r')
fstr = f.read()
f.close()

pattern = r'\(the URL of the image file (.+?) must be inserted here\)'
figfiles = re.findall(pattern, fstr)
replacement = r'%s/\g<1>' % URLstem
fstr, n = re.subn(pattern, replacement, fstr)
f = open(gwikifile, 'w')
f.write(fstr)
f.close()
print 'Replaced %d figure references in' % n, gwikifile





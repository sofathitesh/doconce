#!/usr/bin/env python
"""Auto-edit files from old to new Doconce syntax."""

import sys, os, re

def old2new(filename):
    """
    Read file with name filename and make substitutions of
    ___headings___ to === headings ===, etc.
    A backup of the old file is made (filename + '.old').
    """
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    os.rename(filename, filename + '.old')

    # perform substitutions:
    nchanges = 0
    for i in range(len(lines)):
        oldline = lines[i]
        # change from ___headings___ to === headings ===:
        lines[i] = re.sub(r'(^\s*)_{7}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>======= \g<title> =======' + '\n', lines[i])
        lines[i] = re.sub(r'(^\s*)_{5}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>===== \g<title> =====' + '\n', lines[i])
        lines[i] = re.sub(r'(^\s*)_{3}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>=== \g<title> ===' + '\n', lines[i])
        if lines[i].startswith('AUTHOR:'):
            # swith to "name at institution":
            if not ' at ' in lines[i]:
                print 'Warning, file "%s": AUTHOR line needs "name at institution" syntax' % filename

        if oldline != lines[i]:
            nchanges += 1
            print 'Changing\n  ', oldline, 'to\n  ', lines[i]

    print 'Performed %d changes in "%s"' % (nchanges, filename)
    f = open(filename, 'w')
    f.writelines(lines)
    f.close()

if len(sys.argv) == 1:
    print 'Usage: %s file1.do.txt file2.do.txt ...' % sys.argv[0]
    sys.exit(1)
    
for filename in sys.argv[1:]:
    print 'Converting', filename
    old2new(filename)




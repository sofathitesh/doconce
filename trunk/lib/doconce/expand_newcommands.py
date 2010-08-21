#!/usr/bin/env python

# NOTE: all newcommands can only span *one line*!
# (necessary requirement since a findall with re.DOTALL will 
# not catch the final } of a command, real parsing is then neeeded)

import shutil, re, sys

def process_newcommand(line):
    line = line.replace('renewcommand', 'newcommand') # make syntax uniform
    # newcommand without arguments:
    pattern1 = r'\\newcommand\{(.+)\}\s*\{(.+)\}'
    m = re.search(pattern1, line)
    if m:
        pattern = m.group(1) + r'\{?\}?'
        replacement = m.group(2)

    # newcommand with arguments:
    pattern2 = r'\\newcommand\{(.+)\}\[(\d)\]\{(.+)\}'
    m = re.search(pattern2, line)
    if m:
        nargs = int(m.group(2))
        args = r'\{(.+?)\}'*nargs
        pattern = m.group(1) + args
        replacement = m.group(3)
        for i in range(1, nargs+1):
            replacement = replacement.replace('#%d' % i, r'\g<%d>' % i)

    # fix \x, \b, \r... in strings
    for c in 'x', 'b', 'e', 't', 'n':
        pattern = pattern.replace(r'\%s' % c, r'\\%s' % c)
        replacement = replacement.replace(r'\%s' % c, r'\\%s' % c)
    return pattern, replacement

def parse_newcommands(filename):
    f = open('newcommands.tex', 'r')
    lines = f.readlines()
    f.close()
    newcommands = []

    for line in lines:
        line = line.strip()
        if line.startswith('%') or line == '':
            continue
        elif line.startswith(r'\newcommand') or \
             line.startswith(r'\renewcommand'):
            pattern, replacement = process_newcommand(line)
            newcommands.append((pattern, replacement))
        else:
            raise SyntaxError('Illegal line\n  %s\nline' % line + \
                              'must start with %% or ' + r'\newcommand')
    return newcommands

def substitute(source, newcommands):
    """
    Expand all newcommands in the list 'newcommands' of
    (pattern, replacement) pairs. source can be a filename
    or just a string with text. If source is a filename, a backup
    file with extension .old~ is first made and then the original
    file is overwritten by the new text with expanded commands.
    """
    if os.path.isfile(source):
        shutil.copy(source, source + '.old~')
        f = open(source, 'r')
        text = f.read()
        f.close()
    else:
        text = source

    for pattern, replacement in newcommands:
        print 'replacing', pattern, 'with', replacement
        text = re.sub(pattern, replacement, text)

    #print text
    # newcommands can be nested, let's repeat
    depth = 2
    for i in range(depth):
        for pattern, replacement in newcommands:
            text = re.sub(pattern, replacement, text)
        #print 'next subst:\n', fstr
    
    if os.path.isfile(source):
        f = open(source, 'w')
        f.write(text)
        f.close()
    else:
        return source

def expand_newcommands(newcommands_file, source_file):
    newcommands = parse_newcommands(newcommands_file)
    import pprint; pprint.pprint(newcommands)
    substitute(source_file, newcommands)

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print 'Usage: expand_newcommands.py newcommands_file source_file1 source_file2 ...'
        sys.exit(1)
    newcommands_file = sys.argv[1]
    for source_file in sys.argv[2:]:
        print 'expanding newcommands in', source_file
        expand_newcommands(newcommands_file, source_file)

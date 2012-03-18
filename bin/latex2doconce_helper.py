"""
A simple, rough, and very incomplete translation from latex to doconce.
This is a help script, and manual editing is required, yet much
boring editing is automated.
"""

print """
What is not handled:

  - footnotes
  - figures
  - tables

Such elements must be manually edited.
"""

import os, sys, re
filename = sys.argv[1]
f = open(filename, 'r')
filestr = f.read()
f.close()

# cf. doconce.latex.fix_latex_command_regex to see how important
# it is to quote the backslash correctly for matching, substitution
# and output strings when using re.sub for latex text!
subst = dict(
author=(r'\\author\{(?P<subst>.+)\}', r'# AUTHOR: \g<subst>'),
title=(r'\\title\{(?P<subst>.+)\}', r'# TITLE: \g<subst>'),
section=(r'\\section\{(?P<subst>.+)\}', r'======= \g<subst> ======='),
subsection=(r'\\subsection\{(?P<subst>.+)\}', r'===== \g<subst> ====='),
subsubsection=(r'\\subsubsection\{(?P<subst>.+)\}', r'=== \g<subst> ==='),
paragraph=(r'\\paragraph\{(?P<subst>.+?)\}', r'__\g<subst>__'),
para=(r'\\para\{(?P<subst>.+?)\}', r'__\g<subst>__'),
emph=(r'\\emph\{(?P<subst>.+?)\}', r'*\g<subst>*'),
code=(r'\\code\{(?P<subst>[^}]+)\}', r'`\g<subst>`'),
emp=(r'\\emp\{(?P<subst>[^}]+)\}', r'`\g<subst>`'),
codett=(r'\\codett\{(?P<subst>[^}]+)\}', r'`\g<subst>`'),
refeq=(r'\\refeq\{(?P<subst>.+?)\}', r'(ref{\g<subst>})'),
eqref=(r'\\eqref\{(?P<subst>.+?)\}', r'(ref{\g<subst>})'),
label_space=(r'(\S)\\label\{', r'\g<1> \\label{'),
idx_space=(r'(\S)\\idx(.?)\{', r'\g<1> \\idx\g<2>{'),
index_space=(r'(\S)\\index\{', r'\g<1> \\index{'),
label=(r'\\label\{(?P<subst>.+?)\}', r'label{\g<subst>}'),
idx=(r'\\idx\{(?P<subst>.+?)\}', r'idx{`\g<subst>`}'),
idxf=(r'\\idxf\{(?P<subst>.+?)\}', r'idx{`\g<subst>` function}'),
idxs=(r'\\idxs\{(?P<subst>.+?)\}', r'idx{`\g<subst>` script}'),
idxp=(r'\\idxp\{(?P<subst>.+?)\}', r'idx{`\g<subst>` program}'),
idxc=(r'\\idxc\{(?P<subst>.+?)\}', r'idx{`\g<subst>` class}'),
idxm=(r'\\idxm\{(?P<subst>.+?)\}', r'idx{`\g<subst>` module}'),
idxfn=(r'\\idxfn\{(?P<subst>.+?)\}', r'idx{`\g<subst>` (FEniCS)}'),
index=(r'\\index\{(?P<subst>.+?)\}', r'idx{\g<subst>}'),
)

for item in subst:
    pattern, replacement = subst[item]
    cpattern = re.compile(pattern)
    if cpattern.search(filestr):
        print 'substituting', item, subst[item][0]
        filestr = cpattern.sub(replacement, filestr)
    else:
        print 'no occurence of', item, subst[item][0]

replace = [
    # make sure \beqan comes before \beqa and \beq in replacements...
    (r'\beqan', r'\begin{eqnarray*}'),
    (r'\eeqan', r'\end{eqnarray*}'),
    (r'\beqa', r'\begin{eqnarray}'),
    (r'\eeqa', r'\end{eqnarray}'),
    (r'\beq', r'\begin{equation}'),
    (r'\eeq', r'\end{equation}'),
    (r'\[', r'\begin{equation*}'),
    (r'\]', r'\end{equation*}'),
    (r'\ben', r'\begin{enumerate}'),
    (r'\een', r'\end{enumerate}'),
    (r'\bit', r'\begin{itemize}'),
    (r'\eit', r'\end{itemize}'),
    (r'\para{', r'\paragraph{'),
    (r'\refeq', r'\eqref'),
    ("''", '"'),
    ("``", '"'),
    ("Chapter~", "Chapter "),
    ("Section~", "Section "),
    ("Figure~", "Figure "),
    ("Table~", "Table "),
    ("Chapters~", "Chapters "),
    ("Sections~", "Sections "),
    ("Figures~", "Figures "),
    ("Tables~", "Tables "),
    ("Chap.~", "Chap. "),
    ("Sec.~", "Sec. "),
    ("Fig.~", "Fig. "),
    ("Tab.~", "Tab. "),
    ]

replace_wfix = [
    (r'\epsilon', r'\ep', r'\thinspace . '),
    ]

# Pure string replacements:
for from_, to_ in replace:
    if from_ in filestr:
        if filestr != filestr.replace(from_, to_):
            filestr = filestr.replace(from_, to_)
            print '   ....replacing', from_
for trouble, from_, to_ in replace_wfix:
    if from_ in filestr:
        filestr = filestr.replace(trouble, 'XXXXXXY')
        filestr = filestr.replace(from_, to_)
        filestr = filestr.replace('XXXXXXY', trouble)
        print '   ....replacing', from_

if '{eqnarray' in filestr:
    print '\nyou must change begin/end{eqnarray manually to begin/end{align\n'

if '{figure}' in filestr:
    print '\nyou must change figures manually\n'

# problems:
problems = [
    r'\Sindex\{',
    r'\Sidx.?\{',
    r'\Slabel\{',
    ]
for problem in problems:
    p = re.findall(problem, filestr)
    if len(p) > 0:
        print 'PROBLEM:', problem, '\n', p

# \item alone on line: join with next line (indentation is fixed later)
filestr = re.sub(r'\\item\s+(\w)', r'\item \g<1>', filestr)

# process lists and comment lines:
inside_enumerate = False
inside_itemize = False
lines = filestr.splitlines()
for i in range(len(lines)):
    if lines[i].lstrip().startswith('%'):
        lines[i] = '# ' + lines[i].lstrip()[1:]
    if '%' in lines[i]:
        w = lines[i].split('%')
        lines[i] = w[0] + '\n#' + ''.join(w[1:])

    # two types of lists (but not nested lists):
    if r'\begin{enumerate}' in lines[i] or r'\ben' in lines[i]:
        inside_enumerate = True
        lines[i] = ''
    if r'\begin{itemize}' in lines[i] or r'\bit' in lines[i]:
        inside_itemize = True
        lines[i] = ''
    if inside_enumerate or inside_itemize:
        if lines[i].lstrip().startswith(r'\item'):
            l = re.sub(r'\s*\\item\s*', '', lines[i]).strip()
            lines[i] = '  * ' + l
    if r'\end{enumerate}' in lines[i] or r'\een' in lines[i]:
        inside_enumerate = False
        lines[i] = ''
    if r'\end{itemize}' in lines[i] or r'\eit' in lines[i]:
        inside_itemize = False
        lines[i] = ''


# put all newcommands in a file (note: newcommands must occupy only one line!)
newcommands_file = 'newcommands_keep.tex'
nf = open(newcommands_file, 'w')
newlines = []
for line in lines:
    l = line.lstrip()
    if l.startswith('\\newcommand{'):
        nf.write(l)
    else:
        newlines.append(line)

filestr = '\n'.join(newlines)

math_envirs = 'equation', 'eqnarray', 'eqnarray*', 'align', 'align*', 'equation*'
math_starters = [r'\begin{%s}' % envir for envir in math_envirs]
math_starters.append(r'\[')
math_enders = [r'\end{%s}' % envir for envir in math_envirs]
math_enders.append(r'\]')

# add !bt before and !et after math environments:
for e in math_starters:
    filestr = filestr.replace(e, '!bt\n' + e)
for e in math_enders:
    filestr = filestr.replace(e, e + '\n!et')

# ptex2tex code environments:
code_envirs = ['ccq', 'cod', 'ccl', 'cc', 'sys', 'dsni', 'sni', 'slin', 'ipy', 'py', 'plin', 'ver', 'warn', 'rule', 'summ'] # sequence important for replace!
for language in 'py', 'f', 'c', 'cpp', 'sh', 'pl', 'm':
    for tp in 'cod', 'pro':
        code_envirs.append(language + tp)

for e in code_envirs:
    s = r'\b%s' % e
    filestr = filestr.replace(s, '!bc ' + e)
    s = r'\e%s' % e
    filestr = filestr.replace(s, '!ec')

# eqnarray -> align
filestr = filestr.replace(r'{eqnarray', '{align')
filestr = re.sub(r'&(\s*)=(\s*)&', '&\g<1>=\g<2>', filestr)

filestr = filestr.replace(r'\label{', 'label{')
filestr = filestr.replace(r'\ref{', 'ref{')
filestr = filestr.replace(r'\cite{', 'cite{')
ofilestr = filestr.replace(r'~', ' ')
print '\n\n----------------------------------------------------------------\n'
print filestr

# footnotes? cannot be treated - no footnotes in doconce, try to avoid
# them...


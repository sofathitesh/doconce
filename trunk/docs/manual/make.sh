#!/bin/sh -x
# Compile the Doconce manual, manual.do.txt, in a variety of
# formats to exemplify how different formats may look like.
# This is both a test of Doconce and an example.

./clean.sh > /dev/null

# The following packages must be installed for this script to run: 
# doconce, ptex2tex, docutils, preprocess

d2f=doconce2format
# doconce HTML format:
$d2f HTML manual.do.txt

# Sphinx
$d2f sphinx manual.do.txt
rm -rf sphinx-rootdir
mkdir sphinx-rootdir
sphinx-quickstart <<EOF
sphinx-rootdir
n
_
Doconce Documentation
H. P. Langtangen
1.0
1.0
.rst
index
y
n
n
n
n
y
n
n
y
y
EOF
cp manual.rst manual.sphinx.rst
cp manual.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst
cd sphinx-rootdir
make clean
make html
cd ..
#firefox sphinx-rootdir/_build/html/index.html


# rst:
$d2f rst manual.do.txt

rst2html.py manual.rst > manual_rst.html
rst2xml.py manual.rst > manual_rst.xml

rst2latex.py manual.rst > manual_rst.tex
rst2newlatex.py manual.rst > manual_rst_new.tex

# plain text:
$d2f plain manual.do.txt

$d2f epytext manual.do.txt

# doconce LaTeX:
$d2f LaTeX manual.do.txt             # produces ptex2tex: manual.p.tex
ptex2tex manual                      # turn ptex2tex format into plain latex
rm -f manual.p.tex

# latex fix (until ptex2tex handles parameters to \bccq):
perl -pi.old~~ -e 's/  some \(latex\) verbatim code formatting tags can go here, if desired//g;' manual.tex
rm -f manual.tex.old~~

# Google Code wiki:
$d2f gwiki manual.do.txt

perl -pi.old~~ -e "s#\(the Figure address of dinoimpact on the web must be inserted here\)#https://doconce.googlecode.com/hg/trunk/docs/manual/figs/dinoimpact.gif#g;" manual.gwiki




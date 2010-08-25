#!/bin/sh -x
# Compile the Doconce documentation, doconce.do.txt, in a variety of
# formats to exemplify how different formats may look like.
# This is both a test of Doconce and an example.
# Note that this script generates files in various formats - to view
# the files you have to run show.sh.

./clean.sh > /dev/null

# The following packages must be installed for this script to run: 
# doconce, ptex2tex, docutils

# Note that doconce must be installed - the files in the package
# will not be used

d2f=doconce2format
# doconce HTML format:
$d2f HTML doconce.do.txt

# rst:
$d2f rst doconce.do.txt

rst2html.py doconce.rst > doconce_rst.html
rst2xml.py doconce.rst > doconce_rst.xml

rst2latex.py doconce.rst > doconce_rst.tex
rst2newlatex.py doconce.rst > doconce_rst_new.tex

# plain text:
$d2f plain doconce.do.txt

$d2f epytext doconce.do.txt

# doconce LaTeX:
$d2f LaTeX doconce.do.txt             # produces ptex2tex: doconce.p.tex
ptex2tex doconce                      # turn ptex2tex format into plain latex
rm -f doconce.p.tex

# latex fix (until ptex2tex handles parameters to \bccq):
perl -pi.old~~ -e 's/  some \(latex\) verbatim code formatting tags can go here, if desired//g;' doconce.tex
rm -f doconce.tex.old~~
# show resulting files: run ./show.sh

# Sphinx
doconce2format sphinx doconce.do.txt
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
mv doconce.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst
cd sphinx-rootdir
make clean
make html
cd ..
#firefox sphinx-rootdir/_build/html/index.html




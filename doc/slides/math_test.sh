#!/bin/sh
name=math_test

doconce format latex $name
doconce ptex2tex $name
latex $name
latex $name
dvidpf $name
cp $name.pdf ${name}_latex.pdf

doconce format html $name
cp $name.html ${name}_html.html

doconce sphinx_dir $name
python automake_sphinx.py

doconce format pandoc $name
pandoc -f markdown -t html --mathjax -s -o ${name}_pandoc.html $name.md
exit

# This does not work
pandoc -f markdown -t latex -o $name.tex $name.md
latex $name
latex $name
dvipdf $name
cp $name.pdf ${name}_pandoc.pdf

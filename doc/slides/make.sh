#!/bin/sh
name=scientific_writing

# Note: since Doconce syntax is demonstrated inside !bc/!ec
# blocks we need a few fixes

doconce format html $name --pygments-html-style=perldoc --html-solarized
mv -f $name.html ${name}_solarized.html
doconce format html $name --pygments-html-style=default
mv -f $name.html ${name}_plain.html

doconce format html $name --pygments-html-style=native
doconce slides_html $name reveal --html-slide-theme=darkgray
# fix:
doconce replace '\label' label $name.html

doconce format pdflatex $name --minted-latex-style=trac
doconce ptex2tex $name envir=minted
pdflatex -shell-escape $name
mv -f $name.pdf ${name}_minted.pdf

doconce format pdflatex $name
doconce ptex2tex $name envir=ans:nt
pdflatex $name
mv -f $name.pdf ${name}_anslistings.pdf

doconce format sphinx $name
doconce sphinx_dir author="H. P. Langtangen" theme=pyramid $name
python automake_sphinx.py

doconce format pandoc $name  # Markdown (pandoc extended)
doconce format gwiki  $name  # Googlecode wiki

# These don't like slides with code after heading:
#doconce format rst    $name  # reStructuredText
#doconce format plain  $name  # plain, untagged text for email

pygmentize -l text -f html -o ${name}_doconce.html ${name}.do.txt

cp -r ${name}*.pdf *.md *.html reveal.js ../demos/slides/
cp -r sphinx-rootdir/_build/html ../demos/slides/sphinx

doconce format html sw_index.do.txt
cp sw_index.html ../demos/slides/index.html

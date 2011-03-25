#!/bin/sh -x
# Compile the Doconce manual, manual.do.txt, in a variety of
# formats to exemplify how different formats may look like.
# This is both a test of Doconce and an example.

./clean.sh

# The following packages must be installed for this script to run: 
# doconce, ptex2tex, docutils, preprocess, sphinx, scitools

d2f="doconce format"
# doconce HTML format:
$d2f HTML manual.do.txt

# Sphinx
$d2f sphinx manual.do.txt
doconce sphinx_dir manual.do.txt
cp manual.rst manual.sphinx.rst
cp manual.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst
cp -r figs sphinx-rootdir
# run sphinx:
cd sphinx-rootdir
make clean
make html
make latex
scitools subst '\.\*' '.pdf' _build/latex/DoconceDescription.tex  # .* doesn't work
ln -s `pwd`/../figs _build/latex/figs
cd _build/latex
make clean
# encounter some strange error with labels...
make all-pdf <<EOF
r
EOF
cp DoconceDescription.pdf ../../../manual.sphinx.pdf
cd ../../..


# rst:
$d2f rst manual.do.txt

rst2html.py manual.rst > manual.rst.html
rst2xml.py manual.rst > manual.xml

rst2latex.py manual.rst > manual.rst.tex

# fix figure extension:
# lookahead don't work: scitools subst '(?=includegraphics.+)\.gif' '.ps' manual.rst.tex
scitools subst '\.gif' '' manual.rst.tex   # no extension in graphics file
latex manual.rst.tex   # pdflatex works too
latex manual.rst.tex
dvipdf manual.rst.dvi
rst2newlatex.py manual.rst > manual.rst_new.tex


# plain text:
$d2f plain manual.do.txt remove_inline_comments 

$d2f epytext manual.do.txt
$d2f st manual.do.txt

# doconce LaTeX:
$d2f LaTeX manual.do.txt    # produces ptex2tex: manual.p.tex
ptex2tex -DMINTED manual    # turn ptex2tex format into plain latex
rm -f manual.p.tex
latex -shell-escape manual
latex -shell-escape manual
bibtex manual
makeindex manual
latex -shell-escape manual
latex -shell-escape manual
dvipdf manual.dvi

# Google Code wiki:
$d2f gwiki manual.do.txt

# fix figure in wiki: (can also by done by doconce gwiki_figsubst)
scitools subst "\(the URL of the image file figs/dinoimpact.gif must be inserted here\)" "https://doconce.googlecode.com/hg/trunk/doc/manual/figs/dinoimpact.gif" manual.gwiki

rm -f *.ps

rm -rf demo
mkdir demo
cp -r manual.do.txt manual.html figs manual.tex manual.pdf manual.rst manual.sphinx.rst manual.sphinx.pdf manual.xml manual.rst.html manual.rst.tex manual.rst.pdf manual.gwiki manual.txt manual.epytext manual.st sphinx-rootdir/_build/html demo

cd demo
cat > index.html <<EOF
<HTML><BODY>
<TITLE>Demo of Doconce formats</TITLE>
<H3>Doconce demo</H3>

Doconce is a minimum tagged markup language. The file 
<a href="manual.do.txt">manual.do.txt</a> is the source of
a Doconce Description, written in the Doconce format.
Running
<pre>
doconce format HTML manual.do.txt
</pre>
produces the HTML file <a href="manual.html">manual.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce format LaTeX manual.do.txt
</pre>
resulting in the file <a href="manual.tex">manual.tex</a>, which can
be compiled to a PDF file <a href="manual.pdf">manual.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce format rst manual.do.txt
</pre>
The reST file <a href="manual.rst">manual.rst</a> is a starting point
for conversion to many other formats: OpenOffice, 
<a href="manual.xml">XML</a>, <a href="manual.rst.html">HTML</a>,
<a href="manual.rst.tex">LaTeX</a>, 
and from LaTeX to <a href="manual.rst.pdf">PDF</a>.
The <a href="manual.sphinx.rst">Sphinx</a> dialect of reST
can be translated to <a href="manual.sphinx.pdf">PDF</a>
and <a href="html/index.html">HTML</a>.
<p>
Doconce can also be converted to 
<a href="manual.gwiki">a (Google Code) wiki</a>,
<a href="manual.st">Structured Text</a>, 
<a href="manual.epytext">Epytext</a>,
and maybe the most important format of all:
<a href="manual.txt">plain untagged ASCII text</a>.
</BODY>
</HTML>
EOF

cd ..
rm -rf ../demos/manual
cp -r demo ../demos/manual
echo
echo "Go to the demo directory and load index.html into a web browser."




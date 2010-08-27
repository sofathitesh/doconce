#!/bin/sh
./clean.sh

# HTML
doconce2format HTML tutorial.do.txt

# LaTeX
doconce2format LaTeX tutorial.do.txt
ptex2tex tutorial
latex tutorial.tex
dvipdf tutorial.dvi

# Sphinx
doconce2format sphinx tutorial.do.txt
rm -rf sphinx-rootdir
mkdir sphinx-rootdir
sphinx-quickstart <<EOF
sphinx-rootdir
n
_
Doconce Tutorial
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
cp tutorial.rst tutorial.sphinx.rst
mv tutorial.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst
cd sphinx-rootdir
make clean
make html
cd ..
#firefox sphinx-rootdir/_build/html/index.html

# reStructuredText:
doconce2format rst tutorial.do.txt
rst2xml.py tutorial.rst > tutorial.xml
rst2odt.py tutorial.rst > tutorial.odt
rst2html.py tutorial.rst > tutorial.rst.html
rst2latex.py tutorial.rst > tutorial.rst.tex

# Other formats:
doconce2format plain tutorial.do.txt
doconce2format wiki tutorial.do.txt
doconce2format st tutorial.do.txt
doconce2format epytext tutorial.do.txt

# Make PDF of most of the above:
a2ps_plain='a2ps --left-title='\'''\'' --right-title='\'''\'' --left-footer='\'''\'' --right-footer='\'''\'' --footer='\'''\'''
$a2ps_plain -1 -o tutorial.do.ps tutorial.do.txt
ps2pdf tutorial.do.ps
$a2ps_plain -1 -o tutorial.epytext.ps tutorial.epytext
ps2pdf tutorial.epytext.ps
$a2ps_plain -1 -o tutorial.txt.ps tutorial.txt
ps2pdf tutorial.txt.ps
$a2ps_plain -1 -o tutorial.gwiki.ps tutorial.gwiki
ps2pdf tutorial.gwiki.ps
$a2ps_plain -1 -o tutorial.xml.ps tutorial.xml
ps2pdf tutorial.xml.ps

# run sphinx
cd sphinx-rootdir
make clean
make html
make latex
cd _build/latex
make clean
make all-pdf
cp DoconceTutorial.pdf ../../../tutorial.sphinx.pdf
cd ../../..

# rst latex takes time...
#cat > tutorial.rst.error <<EOF
#Running latex on tutorial.rst did not work.
#EOF
#$a2ps_plain -1 -o tutorial.rst.ps tutorial.rst.error
#ps2pdf tutorial.rst.ps
latex tutorial.rst.tex
dvipdf tutorial.rst.dvi

rm -f *.ps

#wkhtmltopdf tutorial.rst.html tutorial.rst.html.pdf
#wkhtmltopdf tutorial.html tutorial.html.pdf

pdftk tutorial.do.pdf tutorial.pdf tutorial.rst.pdf tutorial.sphinx.pdf tutorial.txt.pdf tutorial.epytext.pdf tutorial.gwiki.pdf tutorial.sphinx.pdf tutorial.xml.pdf  cat output collection_of_results.pdf

rm -rf demo
mkdir demo
cp -r tutorial.do.txt tutorial.html tutorial.tex tutorial.pdf tutorial.rst tutorial.sphinx.rst tutorial.sphinx.pdf tutorial.xml tutorial.rst.html tutorial.rst.tex tutorial.rst.pdf tutorial.gwiki tutorial.txt tutorial.epytext tutorial.st collection_of_results.pdf sphinx-rootdir/_build/html demo

cd demo
cat > index.html <<EOF
<HTML><BODY>
<TITLE>Demo of Doconce formats</TITLE>
<H3>Doconce demo</H3>

Doconce is a minimum tagged markup language. The file 
<a href="tutorial.do.txt">tutorial.do.txt</a> is the source of the
Doconce tutorial, written in the Doconce format.
Running
<pre>
doconce2format HTML tutorial.do.txt
</pre>
produces the HTML file <a href="tutorial.html">tutorial.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce2format LaTeX tutorial.do.txt
</pre>
resulting in the file <a href="tutorial.tex">tutorial.tex</a>, which can
be compiled to a PDF file <a href="tutorial.pdf">tutorial.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce2format rst tutorial.do.txt
</pre>
The reST file <a href="tutorial.rst">tutorial.rst</a> is a starting point
for conversion to many other formats: OpenOffice, 
<a href="tutorial.xml">XML</a>, <a href="tutorial.rst.html">HTML</a>,
<a href="tutorial.rst.tex">LaTeX</a>, 
and from LaTeX to <a href="tutorial.rst.pdf">PDF</a>.
The <a href="tutorial.sphinx.rst'>Sphinx</a> dialect of reST
can be translated to <a href="tutorial.sphinx.pdf">PDF</a>,
and <a href="html/index.html">HTML</a>, 
<p>
Doconce can also be converted to 
<a href="tutorial.gwiki">a (Google Code) wiki</a>,
<a href="tutorial.st">Structured Text</a>, 
<a href="tutorial.epytext">Epytext</a>,
and maybe the most important format of all:
<a href="tutorial.txt">plain untagged ASCII text</a>.
</BODY>
</HTML>
EOF

echo
echo "Go to the demo directory and load index.html into a web browser."

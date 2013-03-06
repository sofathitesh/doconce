#!/bin/sh -x
# Compile the Doconce manual, manual.do.txt, in a variety of
# formats to exemplify how different formats may look like.
# This is both a test of Doconce and an example.

# The following packages must be installed for this script to run:
# doconce, docutils, preprocess, sphinx, publish

sh -x ./clean.sh
echo; echo # Make space in output after deleting many files...

# First make the publish database
rm -rf papers.pub  venues.list # clean

publish import refs1.bib <<EOF
1
2
EOF
publish import refs2.bib <<EOF
2
2
EOF
# Simulate that we get new data, which is best put
# in a new file
publish import refs3.bib <<EOF
1
2
EOF

d2f="doconce format"
# doconce html format:
$d2f html manual.do.txt --no-mako --no-pygments-html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Sphinx
$d2f sphinx manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

rm -rf sphinx-rootdir
# We have several examples on AUTHOR: so to avoid multiple
# authors we have to specify
doconce sphinx_dir author=HPL title='Doconce Manual' version=0.6 manual.do.txt
cp manual.rst manual.sphinx.rst
cp manual.rst sphinx-rootdir
cp -r figs sphinx-rootdir
# run sphinx:
cd sphinx-rootdir
make clean
make html
cd ..


# rst:
$d2f rst manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

rst2html.py manual.rst > manual.rst.html

rst2xml.py manual.rst > manual.xml

rst2latex.py manual.rst > manual.rst.tex

# fix figure extension:
# lookahead don't work: doconce subst '(?=includegraphics.+)\.png' '.eps' manual.rst.tex
doconce subst '\.png' '' manual.rst.tex   # no extension in graphics file
latex manual.rst.tex   # pdflatex works too
latex manual.rst.tex
dvipdf manual.rst.dvi

# plain text:
$d2f plain manual.do.txt --skip_inline_comments --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

$d2f epytext manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

$d2f st manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

$d2f pandoc manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# doconce pdflatex:
$d2f pdflatex manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce ptex2tex manual -DMINTED -DHELVETICA envir=Verbatim
pdflatex -shell-escape manual
bibtex manual
makeindex manual
pdflatex -shell-escape manual
pdflatex -shell-escape manual
cp manual.pdf manual_pdflatex.pdf

# doconce latex:
$d2f latex manual.do.txt --no-mako   # produces ptex2tex: manual.p.tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce ptex2tex manual -DMINTED -DHELVETICA envir=Verbatim
latex -shell-escape manual
latex -shell-escape manual
bibtex manual
makeindex manual
latex -shell-escape manual
latex -shell-escape manual
dvipdf manual.dvi

# Google Code wiki:
$d2f gwiki manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# fix figure in wiki: (can also by done by doconce gwiki_figsubst)
doconce subst "\(the URL of the image file figs/streamtubes.png must be inserted here\)" "https://doconce.googlecode.com/hg/doc/manual/figs/streamtubes.png" manual.gwiki

$d2f cwiki manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

$d2f mwiki manual.do.txt --no-mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

rm -f *.ps

rm -rf demo
mkdir demo
cp -r manual.do.txt manual.html figs manual.p.tex manual.tex manual.pdf manual_pdflatex.pdf manual.rst manual.sphinx.rst manual.xml manual.rst.html manual.rst.tex manual.rst.pdf manual.gwiki manual.cwiki manual.mwiki manual.txt manual.epytext manual.st manual.md sphinx-rootdir/_build/html demo

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
doconce format html manual.do.txt
</pre>
produces the HTML file <a href="manual.html">manual.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce format latex manual.do.txt
</pre>
resulting in the file <a href="manual.tex">manual.tex</a>, which can
be compiled to a PDF file <a href="manual.pdf">manual.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce format rst    manual.do.txt  # standard reST
doconce format sphinx manual.do.txt  # Sphinx extension of reST
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
<a href="manual.gwiki">Googlecode wiki</a>,
<a href="manual.cwiki">Creole wiki</a>,
<a href="manual.mwiki">MediaWiki</a>,
<a href="manual.md">Markdown</a> (Pandoc extended version),
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
# update wiki too
cp manual.gwiki ../../../doconce.wiki/Description.wiki
doconce format gwiki install
cp install.gwiki ../../../doconce.wiki/Installation1.wiki
echo
echo "Go to the demo directory and load index.html into a web browser."
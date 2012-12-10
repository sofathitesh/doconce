#!/bin/sh -x
./clean.sh

# html
doconce format html tutorial  --no-pygments-html

# latex
doconce format latex tutorial
ptex2tex -DHELVETICA tutorial
latex tutorial.tex  # no -shell-escape since no -DMINTED to ptex2tex
latex tutorial.tex
dvipdf tutorial.dvi

# Sphinx
doconce format sphinx tutorial
rm -rf sphinx-rootdir
doconce sphinx_dir tutorial
cp tutorial.rst tutorial.sphinx.rst
mv tutorial.rst sphinx-rootdir
cd sphinx-rootdir
make clean
make html
make latex
cd _build/latex
make clean
make all-pdf
cp DoconceDocumentOnceIncludeAnywhere.pdf ../../../tutorial.sphinx.pdf
cd ../../..
#firefox sphinx-rootdir/_build/html/index.html

# reStructuredText:
doconce format rst tutorial
rst2xml.py tutorial.rst > tutorial.xml
rst2odt.py tutorial.rst > tutorial.odt
rst2html.py tutorial.rst > tutorial.rst.html
rst2latex.py tutorial.rst > tutorial.rst.tex
latex tutorial.rst.tex
dvipdf tutorial.rst.dvi

# Other formats:
doconce format plain tutorial.do.txt
doconce format gwiki tutorial.do.txt
doconce format cwiki tutorial.do.txt
doconce format mwiki tutorial.do.txt
doconce format st tutorial.do.txt
doconce format epytext tutorial.do.txt
doconce format pandoc tutorial.do.txt

# Make PDF of most of the above:
a2ps_plain='a2ps --left-title='\'''\'' --right-title='\'''\'' --left-footer='\'''\'' --right-footer='\'''\'' --footer='\'''\'''
$a2ps_plain -1 -o tutorial.do.ps tutorial.do.txt
ps2pdf tutorial.do.ps tutorial.do.pdf
$a2ps_plain -1 -o tutorial.epytext.ps tutorial.epytext
ps2pdf tutorial.epytext.ps
$a2ps_plain -1 -o tutorial.txt.ps tutorial.txt
ps2pdf tutorial.txt.ps
$a2ps_plain -1 -o tutorial.gwiki.ps tutorial.gwiki
ps2pdf tutorial.gwiki.ps
$a2ps_plain -1 -o tutorial.cwiki.ps tutorial.cwiki
ps2pdf tutorial.cwiki.ps
$a2ps_plain -1 -o tutorial.mwiki.ps tutorial.mwiki
ps2pdf tutorial.mwiki.ps
$a2ps_plain -1 -o tutorial.md.ps tutorial.md
ps2pdf tutorial.md.ps
$a2ps_plain -1 -o tutorial.xml.ps tutorial.xml
ps2pdf tutorial.xml.ps

rm -f *.ps

#wkhtmltopdf tutorial.rst.html tutorial.rst.html.pdf
#wkhtmltopdf tutorial.html tutorial.html.pdf

pdftk tutorial.do.pdf tutorial.pdf tutorial.rst.pdf tutorial.sphinx.pdf tutorial.txt.pdf tutorial.epytext.pdf tutorial.gwiki.pdf tutorial.md.pdf tutorial.sphinx.pdf tutorial.xml.pdf  cat output collection_of_results.pdf

rm -rf demo
mkdir demo
cp -r tutorial.do.txt tutorial.html tutorial.p.tex tutorial.tex tutorial.pdf tutorial.rst tutorial.sphinx.rst tutorial.sphinx.pdf tutorial.xml tutorial.rst.html tutorial.rst.tex tutorial.rst.pdf tutorial.gwiki tutorial.mwiki tutorial.cwiki tutorial.txt tutorial.epytext tutorial.st tutorial.md collection_of_results.pdf sphinx-rootdir/_build/html demo

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
doconce format html tutorial.do.txt
</pre>
produces the HTML file <a href="tutorial.html">tutorial.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce format latex tutorial.do.txt
</pre>
resulting in the file <a href="tutorial.tex">tutorial.tex</a>, which can
be compiled to a PDF file <a href="tutorial.pdf">tutorial.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce format rst    tutorial.do.txt  # standard reST
doconce format sphinx tutorial.do.txt  # Sphinx extension of reST
</pre>
The reST file <a href="tutorial.rst">tutorial.rst</a> is a starting point
for conversion to many other formats: OpenOffice,
<a href="tutorial.xml">XML</a>, <a href="tutorial.rst.html">HTML</a>,
<a href="tutorial.rst.tex">LaTeX</a>,
and from LaTeX to <a href="tutorial.rst.pdf">PDF</a>.
The <a href="tutorial.sphinx.rst">Sphinx</a> dialect of reST
can be translated to <a href="tutorial.sphinx.pdf">PDF</a>
and <a href="html/index.html">HTML</a>.
<p>
Doconce can also be converted to
<a href="tutorial.gwiki">Googlecode wiki</a>,
<a href="tutorial.cwiki">Creole wiki</a>,
<a href="tutorial.mwiki">MediaWiki wiki</a>,
<a href="tutorial.md">Markdown</a> (Pandoc extension),
<a href="tutorial.st">Structured Text</a>,
<a href="tutorial.epytext">Epytext</a>,
and maybe the most important format of all:
<a href="tutorial.txt">plain untagged ASCII text</a>.
</BODY>
</HTML>
EOF

echo
echo "Go to the demo directory and load index.html into a web browser."

# update demo (recall that there is no .hg dir except in the top dir
# so we can just take an rm and cp)
cd ..
rm -rf ../demos/tutorial
cp -r demo ../demos/tutorial
# update wiki too
cp tutorial.gwiki ../../../doconce.wiki/Tutorial.wiki
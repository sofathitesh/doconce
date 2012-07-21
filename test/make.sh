#!/bin/sh -x
doconce format html testdoc.do.txt

doconce format latex testdoc.do.txt
doconce format pdflatex testdoc.do.txt
ptex2tex -DMINTED -DBOOK -DLATEX_HEADING=titlepage testdoc
cp testdoc.tex testdoc.tex_ptex2tex
doconce ptex2tex testdoc -DBOOK -DPALATINO sys=\begin{quote}\begin{Verbatim}@\end{Verbatim}\end{quote} pypro=ans:nt envir=minted
cp testdoc.tex testdoc.tex_doconce_ptex2tex

doconce format plain testdoc.do.txt
doconce format st testdoc.do.txt
doconce format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
# Note: the chapter heading must be removed
# for successful compilation of the sphinx document.
doconce format rst testdoc.do.txt
doconce format epytext testdoc.do.txt
doconce format pandoc testdoc.do.txt
doconce format mwiki testdoc.do.txt
doconce format cwiki testdoc.do.txt

# Test mako variables too
doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string'

# Test pandoc: from latex to markdown, from markdown to html
doconce format latex testdoc.do.txt
doconce ptex2tex testdoc -DBOOK -DLATEX_HEADING=traditional
#doconce subst -s 'And here is a system of equations with labels.+?\\section' '\\section' testdoc.tex
pandoc -f latex -t markdown -o testdoc.mkd testdoc.tex
pandoc -f markdown -t html -o testdoc_pnd_l2h.html --mathjax -s testdoc.mkd

doconce format pandoc testdoc.do.txt
pandoc -t html -o testdoc_pnd_d2h.html --mathjax -s testdoc.mkd

# Test grab
doconce grab --from- '={9}' --to 'subroutine@' testdoc.do.txt > testdoc.tmp
doconce grab --from 'Compute a Probability' --to- 'drawing uniformly' testdoc.do.txt >> testdoc.tmp
doconce grab --from- '\*\s+\$.+normally' testdoc.do.txt >> testdoc.tmp

# Test encoding
doconce guess_encoding encoding1.do.txt > tmp_encodings.txt
cp encoding1.do.txt tmp1.do.txt
doconce change_encoding utf-8 latin1 tmp1.do.txt
doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
doconce change_encoding latin1 utf-8 tmp1.do.txt
doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt

doconce guess_encoding encoding2.do.txt >> tmp_encodings.txt
cp encoding1.do.txt tmp2.do.txt
doconce change_encoding utf-8 latin1 tmp2.do.txt
doconce guess_encoding tmp2.do.txt >> tmp_encodings.txt

# Test error detection
doconce format plain failures
cp failures.do.txt tmp2.do.txt
doconce subst 'failure\}\n\n!bc' 'failure}\n\nHello\n!bc' tmp2.do.txt
doconce format rst tmp2
doconce replace '\label' 'label' tmp2.do.txt
doconce replace '\idx' 'idx' tmp2.do.txt
doconce replace '\cite' 'cite' tmp2.do.txt
doconce format rst tmp2
doconce subst -s '__Paragraph before.+!bc' '!bc' tmp2.do.txt
doconce format rst tmp2
doconce replace 'streamtubes width' 'streamtubes,  width' tmp2.do.txt
doconce format rst tmp2
doconce replace '# Comment before math' '' tmp2.do.txt
doconce format rst tmp2
doconce replace '# Comment before list' '' tmp2.do.txt
doconce format rst tmp2



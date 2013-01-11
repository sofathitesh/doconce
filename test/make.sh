#!/bin/sh -x
rm -rf html_images reveal.js downloaded_figures

doconce format html testdoc.do.txt --pygments-html-linenos --html-solarized --pygments-html-style=emacs
doconce remove_exercise_answers testdoc.html
doconce html_colorbullets testdoc.html
doconce split_html testdoc.html

doconce format latex testdoc.do.txt
doconce format pdflatex testdoc.do.txt --latex-printed
doconce latex_exercise_toc testdoc
doconce replace 'vspace{1cm} % after toc' 'clearpage % after toc' testdoc.p.tex

thpack='\\usepackage{theorem}\n\\newtheorem{theorem}{Theorem}[section]'
doconce subst '% insert custom LaTeX commands\.\.\.' $thpack testdoc.p.tex
doconce subst '\\paragraph\{Theorem \d+\.\}' '' testdoc.p.tex
doconce replace '% begin theorem' '\begin{theorem}' testdoc.p.tex
doconce replace '% end theorem' '\end{theorem}' testdoc.p.tex

ptex2tex -DMINTED -DMOVIE15 -DLATEX_HEADING=titlepage testdoc

# test that pdflatex works
pdflatex -shell-escape testdoc
cp testdoc.tex testdoc.tex_ptex2tex

# -DBOOK will not work for latex/pdflatex since we have an abstract,
# but here we just use the translated text for testing, not latex compiling
doconce ptex2tex testdoc -DBOOK -DPALATINO sys=\begin{quote}\begin{Verbatim}@\end{Verbatim}\end{quote} pypro=ans:nt envir=minted > testdoc.tex_doconce_ptex2tex
echo "----------- end of doconce ptex2tex output ----------------" >> testdoc.tex_doconce_ptex2tex
cat testdoc.tex >> testdoc.tex_doconce_ptex2tex

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
doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string' --no-preprocess

# Test pandoc: from latex to markdown, from markdown to html
doconce format latex testdoc.do.txt
doconce ptex2tex testdoc -DBOOK -DLATEX_HEADING=traditional
#doconce subst -s 'And here is a system of equations with labels.+?\\section' '\\section' testdoc.tex
# pandoc cannot work well with \Verb, needs \verb
doconce replace '\Verb!' '\verb!' testdoc.tex
pandoc -f latex -t markdown -o testdoc.md testdoc.tex
pandoc -f markdown -t html -o testdoc_pnd_l2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_l2h.html

doconce format pandoc testdoc.do.txt
pandoc -t html -o testdoc_pnd_d2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_d2h.html

# Test slides
doconce format html slides --pygments-html-style=emacs
doconce slides_html slides reveal --html-slide-type=beigesmall
mv -f slides.html slides_reveal.html
/bin/ls -R reveal.js >> slides_reveal.html
doconce slides_html slides all

# Test grab
doconce grab --from- '={9}' --to 'subroutine@' testdoc.do.txt > testdoc.tmp
doconce grab --from 'Compute a Probability' --to- 'drawing uniformly' testdoc.do.txt >> testdoc.tmp
doconce grab --from- '\*\s+\$.+normally' testdoc.do.txt >> testdoc.tmp

# Test html templates
doconce format html html_template --html-template=template1.html --no-pygments-html
cp html_template.html html_template1.html
doconce format html html_template --html-template=template_inf1100.html  --pygments-html-style=emacs

# Test author special case and generalized references
doconce format html author1
doconce format latex author1
doconce format sphinx author1
doconce format plain author1

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



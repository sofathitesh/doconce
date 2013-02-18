#!/bin/sh -x
rm -rf html_images reveal.js downloaded_figures

# Note:  --examples-as-exercises is required to avoid abortion

doconce format html testdoc --wordpress  --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.html testdoc_wordpress.html

doconce format html testdoc --without-answers --without-solutions --examples-as-exercises -DSOMEVAR
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.html testdoc_no_solutions.html

doconce format latex testdoc --without-answers --without-solutions --examples-as-exercises -DSOMEVAR
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.p.tex testdoc_no_solutions.p.tex

doconce format html testdoc.do.txt --pygments-html-linenos --html-style=solarized --pygments-html-style=emacs --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce remove_exercise_answers testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce html_colorbullets testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce split_html testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format latex testdoc.do.txt --examples-as-exercises SOMEVAR=True
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format pdflatex testdoc.do.txt --latex-printed --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce latex_exercise_toc testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce replace 'vspace{1cm} % after toc' 'clearpage % after toc' testdoc.p.tex

thpack='\\usepackage{theorem}\n\\newtheorem{theorem}{Theorem}[section]'
doconce subst '% insert custom LaTeX commands\.\.\.' $thpack testdoc.p.tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce subst '\\paragraph\{Theorem \d+\.\}' '' testdoc.p.tex
doconce replace '% begin theorem' '\begin{theorem}' testdoc.p.tex
doconce replace '% end theorem' '\end{theorem}' testdoc.p.tex

ptex2tex -DMINTED -DMOVIE15 -DLATEX_HEADING=titlepage testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# test that pdflatex works
pdflatex -shell-escape testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.tex testdoc.tex_ptex2tex

# -DBOOK will not work for latex/pdflatex since we have an abstract,
# but here we just use the translated text for testing, not latex compiling
doconce ptex2tex testdoc -DBOOK -DPALATINO sys=\begin{quote}\begin{Verbatim}@\end{Verbatim}\end{quote} pypro=ans:nt envir=minted > testdoc.tex_doconce_ptex2tex
echo "----------- end of doconce ptex2tex output ----------------" >> testdoc.tex_doconce_ptex2tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cat testdoc.tex >> testdoc.tex_doconce_ptex2tex

doconce format plain testdoc.do.txt --examples-as-exercises -DSOMEVAR=1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format st testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format sphinx testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

mv -f testdoc.rst testdoc.sphinx.rst

# Note: the chapter heading must be removed
# for successful compilation of the sphinx document.
doconce format rst testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format epytext testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format pandoc testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format mwiki testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format cwiki testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test mako variables too
doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string' --no-preprocess --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test pandoc: from latex to markdown, from markdown to html
doconce format latex testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce ptex2tex testdoc -DBOOK -DLATEX_HEADING=traditional
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

#doconce subst -s 'And here is a system of equations with labels.+?\\section' '\\section' testdoc.tex
# pandoc cannot work well with \Verb, needs \verb
doconce replace '\Verb!' '\verb!' testdoc.tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

pandoc -f latex -t markdown -o testdoc.md testdoc.tex
pandoc -f markdown -t html -o testdoc_pnd_l2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_l2h.html

doconce format pandoc testdoc.do.txt --examples-as-exercises
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
pandoc -t html -o testdoc_pnd_d2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_d2h.html

# Test slides
doconce format html slides --pygments-html-style=emacs
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce slides_html slides reveal --html-slide-type=beigesmall
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

mv -f slides.html slides_reveal.html
/bin/ls -R reveal.js >> slides_reveal.html

doconce format html slides --pygments-html-style=emacs
doconce slides_html slides all
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test grab
doconce grab --from- '={9}' --to 'subroutine@' testdoc.do.txt > testdoc.tmp
doconce grab --from 'Compute a Probability' --to- 'drawing uniformly' testdoc.do.txt >> testdoc.tmp
doconce grab --from- '\*\s+\$.+normally' testdoc.do.txt >> testdoc.tmp

# Test html templates
doconce format html html_template --html-template=template1.html --no-pygments-html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp html_template.html html_template1.html

doconce format html html_template --html-template=template_inf1100.html  --pygments-html-style=emacs
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test author special case and generalized references
doconce format html author1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format latex author1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format sphinx author1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format plain author1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test encoding
doconce guess_encoding encoding1.do.txt > tmp_encodings.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp encoding1.do.txt tmp1.do.txt

doconce change_encoding utf-8 latin1 tmp1.do.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce change_encoding latin1 utf-8 tmp1.do.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce guess_encoding encoding2.do.txt >> tmp_encodings.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp encoding1.do.txt tmp2.do.txt

doconce change_encoding utf-8 latin1 tmp2.do.txt
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce guess_encoding tmp2.do.txt >> tmp_encodings.txt

# Test mako problems
doconce format html mako_test1 --no-pygments-html  # mako variable only, no % lines
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test2 --no-pygments-html  # % lines inside code, but need for mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test3 --no-pygments-html  # % lines inside code
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp mako_test3.html mako_test3b.html

doconce format html mako_test3 --no-mako --no-pygments-html # no problem message
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test4 --no-pygments-html  # works fine, lines start with %%
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

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



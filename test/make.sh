#!/bin/sh -x
rm -rf html_images reveal.js downloaded_figures

# Note:  --examples_as_exercises is required to avoid abortion

# Make publish database
rm -rf papers.pub  venues.list # clean

publish import refs1.bib <<EOF
1
2
EOF
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

publish import refs2.bib <<EOF
2
2
EOF
# Simulate that we get new data, which is best put
# in a new file
publish import refs3.bib <<EOF
1
2
y
1
EOF

ex="--examples_as_exercises"
#ex=

doconce format html testdoc --wordpress  $ex --html_exercise_icon=question_blue_on_white1.png --html_exercise_icon_width=80
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.html testdoc_wordpress.html

doconce format html testdoc --without_answers --without_solutions $ex -DSOMEVAR --html_exercise_icon=default
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.html testdoc_no_solutions.html

doconce format latex testdoc --without_answers --without_solutions $ex -DSOMEVAR
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp testdoc.p.tex testdoc_no_solutions.p.tex

cp -r ../bundled/html_styles/style_vagrant .
doconce replace 'css/' 'style_vagrant/css/' style_vagrant/template_vagrant.html
doconce format html testdoc.do.txt $ex --html_style=vagrant --html_template=style_vagrant/template_vagrant.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp testdoc.html testdoc_vagrant.html
# Test that a split of testdoc_vagrant.html becomes correct
doconce split_html testdoc_vagrant.html

doconce format html testdoc.do.txt --pygments_html_linenos --html_style=solarized --pygments_html_style=emacs $ex --html_exercise_icon=exercise1.svg
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce remove_exercise_answers testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce html_colorbullets testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce split_html testdoc.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi


doconce format latex testdoc.do.txt $ex SOMEVAR=True --skip_inline_comments
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format pdflatex testdoc.do.txt --device=paper $ex --latex_double_hyphen
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce latex_exercise_toc testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce replace 'vspace{1cm} % after toc' 'clearpage % after toc' testdoc.p.tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

thpack='\\usepackage{theorem}\n\\newtheorem{theorem}{Theorem}[section]'
doconce subst '% insert custom LaTeX commands\.\.\.' $thpack testdoc.p.tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce subst '\\paragraph\{Theorem \d+\.\}' '' testdoc.p.tex
doconce replace '% begin theorem' '\begin{theorem}' testdoc.p.tex
doconce replace '% end theorem' '\end{theorem}' testdoc.p.tex
# because of --latex-double-hyphen:
doconce replace Newton--Cotes Newton-Cotes testdoc.p.tex
doconce replace --examples_as__exercises $ex testdoc.p.tex

# A4PAPER trigger summary environment to be smaller paragraph
# within the text (fine for proposals or articles).
ptex2tex -DMINTED -DMOVIE=movie15 -DLATEX_HEADING=titlepage -DA4PAPER -DTODONOTES -DLINENUMBERS -DCOLORED_TABLE_ROWS=blue -DBLUE_SECTION_HEADINGS testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# test that pdflatex works
pdflatex -shell-escape testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
pdflatex -shell-escape testdoc
makeindex testdoc
bibtex testdoc
pdflatex -shell-escape testdoc
pdflatex -shell-escape testdoc

cp testdoc.tex testdoc.tex_ptex2tex
# testdoc.tex_ptex2tex corresponds to testdoc.pdf

# -DBOOK will not work for latex/pdflatex since we have an abstract,
# but here we just use the translated text for testing, not latex compiling
doconce ptex2tex testdoc -DBOOK -DPALATINO sys=\begin{quote}\begin{Verbatim}@\end{Verbatim}\end{quote} pypro=ans:nt envir=minted > testdoc.tex_doconce_ptex2tex
echo "----------- end of doconce ptex2tex output ----------------" >> testdoc.tex_doconce_ptex2tex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cat testdoc.tex >> testdoc.tex_doconce_ptex2tex

doconce format plain testdoc.do.txt $ex -DSOMEVAR=1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format st testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format sphinx testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

mv -f testdoc.rst testdoc.sphinx.rst

doconce format sphinx testdoc $ex
doconce split_rst testdoc
doconce sphinx_dir author=HPL title='Just a test' version=0.1 theme=agni testdoc
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp automake_sphinx.py automake_sphinx_testdoc.py

doconce format rst testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format epytext testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format pandoc testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format mwiki testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format cwiki testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format ipynb testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test mako variables too
doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string' $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test pandoc: from latex to markdown, from markdown to html
doconce format latex testdoc.do.txt $ex
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

doconce format pandoc testdoc.do.txt $ex
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
pandoc -t html -o testdoc_pnd_d2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_d2h.html

# Test slides
# slides1: rough small test
# slides2: much of scientific_writing.do.txt
# slides3: equal to slides/demo.do.txt
doconce format html slides1 --pygments_html_style=emacs
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp slides1.html slides1_1st.html  # before running slides_html

doconce slides_html slides1 reveal --html_slide_type=beigesmall
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp slides1.html slides1_reveal.html
/bin/ls -R reveal.js >> slides1_reveal.html

doconce slides_html slides1 deck --html_slide_type=sandstone.firefox
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp slides1.html slides1_deck.html
/bin/ls -R deck.js >> slides1_deck.html

doconce format pdflatex slides1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce ptex2tex slides1 -DLATEX_HEADING=beamer
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce slides_beamer slides1
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html slides2 --pygments_html_style=emacs
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce slides_html slides2 reveal --html_slide_type=beigesmall
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp slides2.html slides2_reveal.html

doconce format pdflatex slides2
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce ptex2tex slides2 -DLATEX_HEADING=beamer envir=minted
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce slides_beamer slides2
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html slides3 --pygments_html_style=emacs SLIDE_TYPE=reveal SLIDE_THEME=beigesmall
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce slides_html slides3 reveal --html_slide_type=beigesmall
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp slides3.html slides3_reveal.html

theme=red3
doconce format pdflatex slides3 SLIDE_TYPE=beamer SLIDE_THEME=$theme
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce ptex2tex slides3 -DLATEX_HEADING=beamer envir=minted
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce slides_beamer slides3 --beamer_slide_theme=$theme
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html slides1 --pygments_html_style=emacs
doconce slides_html slides1 all
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

# Test grab
doconce grab --from- '={5} Subsection 1' --to 'subroutine@' _testdoc.do.txt > testdoc.tmp
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
doconce grab --from 'Compute a Probability' --to- 'drawing uniformly' _testdoc.do.txt >> testdoc.tmp
doconce grab --from- '\*\s+\$.+normally' _testdoc.do.txt >> testdoc.tmp

# Test html templates
doconce format html html_template --html_template=template1.html --no_pygments_html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp html_template.html html_template1.html

doconce format html html_template --html_template=template_inf1100.html  --pygments_html_style=emacs
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

# Test math
name=math_test
doconce format pdflatex $name
doconce ptex2tex $name
pdflatex $name
doconce format html $name
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp $name.html ${name}_html.html
doconce format sphinx $name
doconce sphinx_dir dirname=sphinx-rootdir-math $name
cp automake_sphinx.py automake_sphinx_math_test.py
python automake_sphinx.py
doconce format pandoc $name
# Do not use pandoc directly because it does not support MathJax enough
doconce md2html $name.md
cp $name.html ${name}_pandoc.html
doconce format pandoc $name
doconce md2latex $name

# Test admonitions
doconce format pdflatex admon
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
admon_tps="colors1 graybox1 paragraph graybox2 yellowbox graybox3 colors2"
for admon_tp in $admon_tps; do
doconce ptex2tex admon envir=minted -DADMON=$admon_tp
cp admon.tex admon_${admon_tp}.tex
pdflatex -shell-escape admon_${admon_tp}
done

doconce format html admon
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_default.html

doconce format html admon --html_admon=colors
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_colors.html

doconce format html admon --html_admon=gray --html_style=blueish2
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_gray.html

doconce format html admon --html_admon=yellow
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_yellow.html

doconce format html admon --html_admon=apricot --html_style=solarized
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_apricot.html

doconce format html admon --html_style=vagrant --pygments_html_style=default --html_template=style_vagrant/template_vagrant.html
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp admon.html admon_vagrant.html

doconce sphinx_dir dirname=tmp_admon admon
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
python automake_sphinx.py
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi
cp tmp_admon/_build/html/admon.html admon_sphinx.html

#google-chrome admon_*.html

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
doconce format html mako_test1 --no_pygments_html  # mako variable only, no % lines
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test2 --no_pygments_html  # % lines inside code, but need for mako
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test3 --no_pygments_html  # % lines inside code
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

cp mako_test3.html mako_test3b.html

doconce format html mako_test3 --no_pygments_html # no problem message
if [ $? -ne 0 ]; then echo "make.sh: abort"; exit 1; fi

doconce format html mako_test4 --no_pygments_html  # works fine, lines start with %%
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
doconce replace '`Google`' '`Google` site' tmp2.do.txt
doconce format rst tmp2
echo
echo "Successful run of test/make.sh !"


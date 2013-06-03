#!/bin/bash -x

function system {
  $@
  if [ $? -ne 0 ]; then
    echo "make.sh: unsuccessful command $@"
    echo "abort!"
    exit 1
  fi
}

rm -rf html_images reveal.js downloaded_figures latex_styles

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

system doconce format html testdoc --wordpress  $ex --html_exercise_icon=question_blue_on_white1.png --html_exercise_icon_width=80
cp testdoc.html testdoc_wordpress.html

system doconce format html testdoc --without_answers --without_solutions $ex -DSOMEVAR --html_exercise_icon=default
cp testdoc.html testdoc_no_solutions.html

system doconce format latex testdoc --without_answers --without_solutions $ex -DSOMEVAR
cp testdoc.p.tex testdoc_no_solutions.p.tex

cp -r ../bundled/html_styles/style_vagrant .
doconce replace 'css/' 'style_vagrant/css/' style_vagrant/template_vagrant.html
system doconce format html testdoc.do.txt $ex --html_style=vagrant --html_template=style_vagrant/template_vagrant.html
cp testdoc.html testdoc_vagrant.html
# Test that a split of testdoc_vagrant.html becomes correct
doconce split_html testdoc_vagrant.html

system doconce format html testdoc.do.txt --pygments_html_linenos --html_style=solarized --pygments_html_style=emacs $ex --html_exercise_icon=exercise1.svg --tables2csv

system doconce remove_exercise_answers testdoc.html
system doconce html_colorbullets testdoc.html
system doconce split_html testdoc.html

system doconce format latex testdoc.do.txt $ex SOMEVAR=True --skip_inline_comments
system doconce format pdflatex testdoc.do.txt --device=paper $ex --latex_double_hyphen
system doconce latex_exercise_toc testdoc

# doconce replace does not work well with system without quotes
doconce replace 'vspace{1cm} % after toc' 'clearpage % after toc' testdoc.p.tex
thpack='\\usepackage{theorem}\n\\newtheorem{theorem}{Theorem}[section]'
doconce subst '% insert custom LaTeX commands\.\.\.' $thpack testdoc.p.tex

doconce subst '\\paragraph\{Theorem \d+\.\}' '' testdoc.p.tex
doconce replace '% begin theorem' '\begin{theorem}' testdoc.p.tex
doconce replace '% end theorem' '\end{theorem}' testdoc.p.tex
# because of --latex-double-hyphen:
doconce replace Newton--Cotes Newton-Cotes testdoc.p.tex
doconce replace --examples_as__exercises $ex testdoc.p.tex

# A4PAPER trigger summary environment to be smaller paragraph
# within the text (fine for proposals or articles).
system ptex2tex -DMINTED -DMOVIE=movie15 -DLATEX_HEADING=titlepage -DA4PAPER -DTODONOTES -DLINENUMBERS -DCOLORED_TABLE_ROWS=blue -DBLUE_SECTION_HEADINGS testdoc

# test that pdflatex works
system pdflatex -shell-escape testdoc
pdflatex -shell-escape testdoc
makeindex testdoc
bibtex testdoc
pdflatex -shell-escape testdoc
pdflatex -shell-escape testdoc

cp testdoc.tex testdoc.tex_ptex2tex
# testdoc.tex_ptex2tex corresponds to testdoc.pdf

# -DBOOK will not work for latex/pdflatex since we have an abstract,
# but here we just use the translated text for testing, not latex compiling
system doconce ptex2tex testdoc -DBOOK -DPALATINO sys=\begin{quote}\begin{Verbatim}@\end{Verbatim}\end{quote} pypro=ans:nt envir=minted > testdoc.tex_doconce_ptex2tex
echo "----------- end of doconce ptex2tex output ----------------" >> testdoc.tex_doconce_ptex2tex
cat testdoc.tex >> testdoc.tex_doconce_ptex2tex

system doconce format plain testdoc.do.txt $ex -DSOMEVAR=1
system doconce format st testdoc.do.txt $ex
system doconce format sphinx testdoc.do.txt $ex
mv -f testdoc.rst testdoc.sphinx.rst

doconce format sphinx testdoc $ex
doconce split_rst testdoc
system doconce sphinx_dir author=HPL title='Just a test' version=0.1 theme=agni testdoc
cp automake_sphinx.py automake_sphinx_testdoc.py

system doconce format rst testdoc.do.txt $ex

system doconce format epytext testdoc.do.txt $ex
system doconce format pandoc testdoc.do.txt $ex
system doconce format mwiki testdoc.do.txt $ex
system doconce format cwiki testdoc.do.txt $ex
system doconce format ipynb testdoc.do.txt $ex

# Test mako variables too
system doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string' $ex

# Test pandoc: from latex to markdown, from markdown to html
system doconce format latex testdoc.do.txt $ex
system doconce ptex2tex testdoc -DBOOK -DLATEX_HEADING=traditional

#doconce subst -s 'And here is a system of equations with labels.+?\\section' '\\section' testdoc.tex
# pandoc cannot work well with \Verb, needs \verb
system doconce replace '\Verb!' '\verb!' testdoc.tex
# pandoc v 10 does not handle a couple of the URLs
doconce replace '%E2%80%93' '' testdoc.tex
doconce replace '+%26+' '' testdoc.tex

system pandoc -f latex -t markdown -o testdoc.md testdoc.tex
system pandoc -f markdown -t html -o testdoc_pnd_l2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_l2h.html

system doconce format pandoc testdoc.do.txt $ex
system pandoc -t html -o testdoc_pnd_d2h.html --mathjax -s testdoc.md
pandoc -v >> testdoc_pnd_d2h.html

# Test slides
# slides1: rough small test
# slides2: much of scientific_writing.do.txt
# slides3: equal to slides/demo.do.txt
system doconce format html slides1 --pygments_html_style=emacs --keep_pygments_html_bg
cp slides1.html slides1_1st.html  # before running slides_html

system doconce slides_html slides1 reveal --html_slide_type=beigesmall

cp slides1.html slides1_reveal.html
/bin/ls -R reveal.js >> slides1_reveal.html

system doconce format html slides1 --pygments_html_style=emacs --keep_pygments_html_bg
system doconce slides_html slides1 deck --html_slide_type=sandstone.firefox

cp slides1.html slides1_deck.html
/bin/ls -R deck.js >> slides1_deck.html

system doconce format pdflatex slides1
system doconce ptex2tex slides1 -DLATEX_HEADING=beamer
system doconce slides_beamer slides1

system doconce format html slides2 --pygments_html_style=emacs
system doconce slides_html slides2 reveal --html_slide_type=beigesmall
cp slides2.html slides2_reveal.html

system doconce format pdflatex slides2
system doconce ptex2tex slides2 -DLATEX_HEADING=beamer envir=minted
system doconce slides_beamer slides2

system doconce format html slides3 --pygments_html_style=emacs SLIDE_TYPE=reveal SLIDE_THEME=beigesmall
system doconce slides_html slides3 reveal --html_slide_type=beigesmall
cp slides3.html slides3_reveal.html

theme=red3
system doconce format pdflatex slides3 SLIDE_TYPE=beamer SLIDE_THEME=$theme
system doconce ptex2tex slides3 -DLATEX_HEADING=beamer envir=minted
system doconce slides_beamer slides3 --beamer_slide_theme=$theme

system doconce format html slides1 --pygments_html_style=emacs
system doconce slides_html slides1 all

# Test grab
system doconce grab --from- '={5} Subsection 1' --to 'subroutine@' _testdoc.do.txt > testdoc.tmp
doconce grab --from 'Compute a Probability' --to- 'drawing uniformly' _testdoc.do.txt >> testdoc.tmp
doconce grab --from- '\*\s+\$.+normally' _testdoc.do.txt >> testdoc.tmp

# Test html templates
system doconce format html html_template --html_template=template1.html --no_pygments_html
cp html_template.html html_template1.html

system doconce format html html_template --html_template=template_inf1100.html  --pygments_html_style=emacs

# Test author special case and generalized references
system doconce format html author1
system doconce format latex author1
system doconce format sphinx author1
system doconce format plain author1

# Test math
name=math_test
doconce format pdflatex $name
doconce ptex2tex $name
pdflatex $name
system doconce format html $name
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
admon_tps="colors1 graybox1 paragraph graybox2 yellowbox graybox3 colors2"
for admon_tp in $admon_tps; do
system doconce format pdflatex admon --latex_admon=$admon_tp
doconce ptex2tex admon envir=minted
cp admon.tex admon_${admon_tp}.tex
pdflatex -shell-escape admon_${admon_tp}
done

system doconce format html admon --html_admon=lyx --html_style=blueish2
cp admon.html admon_lyx.html

system doconce format html admon --html_admon=paragraph --html_style=blueish2
cp admon.html admon_paragraph.html

system doconce format html admon --html_admon=colors
cp admon.html admon_colors.html

system doconce format html admon --html_admon=gray --html_style=blueish2
cp admon.html admon_gray.html

system doconce format html admon --html_admon=yellow
cp admon.html admon_yellow.html

system doconce format html admon --html_admon=apricot --html_style=solarized
cp admon.html admon_apricot.html

system doconce format html admon --html_style=vagrant --pygments_html_style=default --html_template=style_vagrant/template_vagrant.html
cp admon.html admon_vagrant.html

system doconce sphinx_dir dirname=tmp_admon admon
system python automake_sphinx.py
cp tmp_admon/_build/html/admon.html admon_sphinx.html

system doconce format mwiki admon

#google-chrome admon_*.html
#for pdf in admon_*.pdf; do evince $pdf; done

# Test encoding
system doconce guess_encoding encoding1.do.txt > tmp_encodings.txt
cp encoding1.do.txt tmp1.do.txt
system doconce change_encoding utf-8 latin1 tmp1.do.txt
system doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
system doconce change_encoding latin1 utf-8 tmp1.do.txt
system doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
system doconce guess_encoding encoding2.do.txt >> tmp_encodings.txt
cp encoding1.do.txt tmp2.do.txt
system doconce change_encoding utf-8 latin1 tmp2.do.txt
doconce guess_encoding tmp2.do.txt >> tmp_encodings.txt

# Test mako problems
system doconce format html mako_test1 --no_pygments_html  # mako variable only, no % lines
system doconce format html mako_test2 --no_pygments_html  # % lines inside code, but need for mako
system doconce format html mako_test3 --no_pygments_html  # % lines inside code
cp mako_test3.html mako_test3b.html
system doconce format html mako_test3 --no_pygments_html # no problem message
system doconce format html mako_test4 --no_pygments_html  # works fine, lines start with %%

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
echo "When we reach this point in the script,"
echo "it is clearly a successful run of all tests!"


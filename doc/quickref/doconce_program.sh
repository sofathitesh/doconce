Usage: doconce command [optional arguments]
commands: format help sphinx_dir subst replace replace_from_file clean spellcheck ptex2tex expand_commands combine_images guess_encoding change_encoding gwiki_figsubst md2html remove_inline_comments grab remove remove_exercise_answers split_rst split_html slides_html slides_beamer latin2html latex_header latex_footer bbl2rst html_colorbullets list_labels teamod sphinxfix_localURLs make_figure_code_links latex_exercise_toc insertdocstr old2new_format latex2doconce latex_dislikes pygmentize makefile diff gitdiff fix_bibtex4publish


# transform doconce file to another format
doconce format html|latex|pdflatex|rst|sphinx|plain|gwiki|mwiki|cwiki|pandoc|st|epytext file.do.txt

# substitute a phrase by another using regular expressions
doconce subst [-s -m -x --restore] regex-pattern regex-replacement file1 file2 ...
(-s is the re.DOTALL modifier, -m is the re.MULTILINE modifier,
 -x is the re.VERBOSE modifier, --restore copies backup files back again)

# replace a phrase by another literally
doconce replace from-text to-text file1 file2 ...
(exact text substutition)

# doconce replace using from and to phrases from file
doconce replace_from_file file-with-from-to file1 file2 ...
(exact text substitution, but a set of from-to relations)

# gwiki format requires substitution of figure file names by URLs
doconce gwiki_figsubst file.gwiki URL-of-fig-dir

# remove all inline comments in a doconce file
doconce remove_inline_comments file.do.txt

# create a directory for the sphinx format
doconce sphinx_dir author='John Doe' title='Long title' \
    short_title="Short title" version=0.1 \
    dirname=sphinx-rootdir theme=default logo=mylogo.png \
    do_file [do_file2 do_file3 ...]
(requires sphinx version >= 1.1)

# replace latex-1 (non-ascii) characters by html codes
doconce latin2html file.html

# walk through a directory tree and insert doconce files as
# docstrings in *.p.py files
doconce insertdocstr rootdir

# remove all files that the doconce format can regenerate
doconce clean

# print the header (preamble) for latex file
doconce latex_header

# print the footer for latex files
doconce latex_footer

# change encoding
doconce change_encoding utf-8 latin1 filename

# guess the encoding in a text
doconce guess_encoding filename

# transform a .bbl file to a .rst file with reST bibliography format
doconce bbl2rst file.bbl

# split a sphinx/rst file into parts
doconce format sphinx complete_file
doconce split_rst complete_file        # !split delimiters
doconce sphinx_dir complete_file
python automake_sphinx.py

# edit URLs to local files and place them in _static
doconce sphinxfix_local_URLs file.rst

# split an html file into parts according to !split commands
doconce split_html complete_file.html

# create HTML slides from a (doconce) html file
doconce slides_html slide_type complete_file.html

# create LaTeX Beamer slides from a (doconce) latex/pdflatex file
doconce slides_beamer complete_file.tex

# replace bullets in lists by colored bullets
doconce html_colorbullets file1.html file2.html ...

# grab selected text from a file
doconce grab   --from[-] from-text [--to[-] to-text] somefile

# remove selected text from a file
doconce remove --from[-] from-text [--to[-] to-text] somefile

# run spellcheck on a set of files
doconce spellcheck [-d .mydict.txt] *.do.txt

# transform ptex2tex files (.p.tex) to ordinary latex file
# and manage the code environments
doconce ptex2tex mydoc -DMINTED pycod=minted sys=Verbatim \
        dat=\begin{quote}\begin{verbatim};\end{verbatim}\end{quote}

# make HTML file via pandoc from Markdown (.md) file
doconce md2html file

# make LaTeX file via pandoc from Markdown (.md) file
doconce md2latex file

# expand short cut commands to full form in files
doconce expand_commands file1 file2 ...

# combine several images into one
doconce combine_images image1 image2 ... output_file

# insert a table of exercises in a latex file myfile.p.tex
doconce latex_exercise_toc myfile

# list all labels in a document (for purposes of cleaning them up)
doconce list_labels myfile

# translate a latex document to doconce (requires usually manual fixing)
doconce latex2doconce latexfile

# check if there are problems with translating latex to doconce
doconce latex_dislikes latexfile

# typeset a doconce document with pygments (for pretty print of doconce itself)
doconce pygmentize myfile [pygments-style]

# generate a make.sh script for translating a doconce file to various formats
doconce makefile docname doconcefile [html sphinx pdflatex ...]

# fix common problems in bibtex files for publish import
doconce fix_bibtex4publish file1.bib file2.bib ...

# find differences between two files
doconce diff file1.do.txt file2.do.txt [diffprog]
(diffprog can be difflib, diff, pdiff, latexdiff, kdiff3, diffuse, ...)

# find differences between the last two Git versions of several files
doconce gitdiff file1 file2 file3 ...


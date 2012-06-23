Usage: doconce command [optional arguments]
commands: format insertdocstr old2new_format gwiki_figsubst remove_inline_comments latin2html sphinx_dir subst replace replace_from_file clean help latex_header latex_footer guess_encoding change_encoding bbl2rst split_rst list_labels teamod sphinxfix_localURLs make_figure_code_links grab spellcheck ptex2tex

doconce format html|latex|pdflatex|rst|sphinx|plain|gwiki|mwiki|cwiki|pandoc|st|epytext file.do.txt

doconce subst [-s -m -x --restore] regex-pattern regex-replacement file1 file2 ...
(-s is the re.DOTALL modifier, -m is the re.MULTILINE modifier,
 -x is the re.VERBOSE modifier, --restore copies backup files back again)

doconce replace from-text to-text file1 file2 ...
(exact text substutition)

doconce replace_from_file file-with-from-to file1 file2 ...
(exact text substitution, but a set of from-to relations)

doconce gwiki_figsubst file.gwiki URL-of-fig-dir

doconce remove_inline_comments file.do.txt

doconce sphinx_dir author='Me and you' title='Quick title' \
    version=0.1 dirname=sphinx-rootdir theme=default \
    file1 file2 file3
(requires sphinx version >= 1.1)

doconce latin2html file.html

doconce insertdocstr rootdir

doconce clean
(remove all files that the doconce format can regenerate)

doconce latex_header
doconce latex_footer

doconce change_encoding utf-8 latin1 filename
doconce guess_encoding filename

doconce bbl2rst file.bbl
doconce split_rst complete_file.rst
doconce sphinxfix_local_URLs file.rst

doconce grab --from[-] from-text [--to[-] to-text] somefile
doconce spellcheck -d .dict4spell.txt *.do.txt
doconce ptex2tex mydoc -DMINTED pycod=minted sys=Verbatim \
        dat=\begin{quote}\begin{verbatim};\end{verbatim}\end{quote}

doconce list_labels doconcefile.do.txt | latexfile.tex
doconce teamod name
doconce assemble name master.do.txt


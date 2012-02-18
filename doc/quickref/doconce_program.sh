doconce format html|latex|rst|sphinx|st|epytext|plain|gwiki|pandoc file.do.txt

doconce subst [-s -m -x --restore] \  
        regex-pattern regex-replacement file1 file2 ...
(-s is the re.DOTALL modifier, -m is the re.MULTILINE modifier,
 -x is the re.VERBOSE modifier, --restore copies backup files back again)

doconce replace from-text to-text file1 file2 ...
doconce replace_from_file file-with-from-to file1 file2 ...

doconce gwiki_figsubst file.gwiki URL-of-fig-dir

doconce remove_inline_comments file.do.txt

doconce sphinx_dir author='Me and you' \  
        title='Quick title' version=0.1 \  
        dirname=sphinx-rootdir theme=default file1 file2 file3
(requires sphinx version >= 1.1)

doconce latin2html file.html

doconce insertdocstr rootdir

doconce clean
(remove all files that the doconce format can regenerate)

doconce latex_header
doconce latex_footer
doconce change_encoding utf-8 latin-1 filename
doconce guess_encoding filename
doconce bbl2rst file.bbl
doconce split_rst complete_file.rst
doconce list_labels doconcefile.do.txt | latexfile.tex


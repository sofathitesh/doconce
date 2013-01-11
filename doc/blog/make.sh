#!/bin/sh
doconce format html demo
pygmentize -l html -f html -O full,style=default -o demo.html.html demo.html
pygmentize -l text -f html -O full,style=default -o demo.do.txt.html demo.do.txt

doconce format mwiki demo

# need to update doconce.blogspot.no with new text
# and http://doconcedemo.jumpwiki.com/wiki/First_demo
# and test in http://en.wikibooks.org/wiki/Sandbox

doconce sphinx_dir author=hpl title=demo demo
python automake_sphinx.py
# check out sphinx-rootdir/_build/html/demo.html

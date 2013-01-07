#!/bin/sh
doconce format html demo
pygmentize -l html -f html -O full,style=default -o demo.html.html demo.html
pygmentize -l text -f html -O full,style=default -o demo.do.txt.html demo.do.txt

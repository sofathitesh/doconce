doconce format html mydoc.do.txt
pygmentize -f html -O full,style=emacs -o mydoc_plain_pygmentized.html -l html mydoc.html
mv mydoc.html mydoc_plain.html

doconce format html mydoc.do.txt --html-template=github_minimal/template_github_minimal.html
pygmentize -f html -O full,style=emacs -o mydoc_github_pygmentized.html -l html mydoc.html
mv mydoc.html mydoc_github.html

doconce format html mydoc.do.txt --html-template=uio/template_5620.html
mv mydoc.html mydoc_uio.html

# Report
doconce format html wrapper_tech
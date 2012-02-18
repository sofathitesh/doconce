#!/bin/sh -x
# Test multiple authors
doconce format html testdoc.do.txt
doconce format latex testdoc.do.txt
doconce format plain testdoc.do.txt
doconce format st testdoc.do.txt
doconce format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
doconce format rst testdoc.do.txt
doconce format epytext testdoc.do.txt
doconce format pandoc testdoc.do.txt
# Test mako variables too
doconce format gwiki testdoc.do.txt --skip_inline_comments MYVAR1=3 MYVAR2='a string'

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



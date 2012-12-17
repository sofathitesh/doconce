#!/bin/sh
# Make html page with all .png files in this directory

rm -f display.html
touch display.html
for f in *.png; do
  echo "<img src=\"$f\" align=\"bottom\">$f\n<hr>\n" >> display.html
done
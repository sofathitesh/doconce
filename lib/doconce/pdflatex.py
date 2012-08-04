# -*- coding: iso-8859-15 -*-
from latex import *

def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           EXERCISE,
           FIGURE_EXT,
           CROSS_REFS,
           INDEX_BIB,
           INTRO,
           OUTRO):

    if not 'latex' in BLANKLINE:
        # latex.define is not yet ran on these dictionaries, do it:
        import latex
        latex.define(FILENAME_EXTENSION,
                     BLANKLINE,
                     INLINE_TAGS_SUBST,
                     CODE,
                     LIST,
                     ARGLIST,
                     TABLE,
                     FIGURE_EXT,
                     INTRO,
                     OUTRO)

    # The BIG difference between pdflatex and latex
    FIGURE_EXT['pdflatex'] = ('.pdf', '.jpg', '.jpeg', '.png')

    # The rest is copy
    FILENAME_EXTENSION['pdflatex'] = FILENAME_EXTENSION['latex']
    BLANKLINE['pdflatex'] = BLANKLINE['latex']
    CODE['pdflatex'] = CODE['latex']
    LIST['pdflatex'] = LIST['latex']
    CROSS_REFS['pdflatex'] = CROSS_REFS['latex']
    INDEX_BIB['pdflatex'] = INDEX_BIB['latex']
    TABLE['pdflatex'] = TABLE['latex']
    EXERCISE['pdflatex'] = EXERCISE['latex']
    INTRO['pdflatex'] = INTRO['latex']
    OUTRO['pdflatex'] = OUTRO['latex']
    ARGLIST['pdflatex'] = ARGLIST['latex']

    # make true copy of INLINE_TAGS_SUBST:
    INLINE_TAGS_SUBST['pdflatex'] = {}
    for tag in INLINE_TAGS_SUBST['latex']:
        INLINE_TAGS_SUBST['pdflatex'][tag] = INLINE_TAGS_SUBST['latex'][tag]

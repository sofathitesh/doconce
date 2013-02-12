;;http://stackoverflow.com/questions/1063115/a-hello-world-example-for-a-major-mode-in-emacs
;;http://ergoemacs.org/emacs/elisp_syntax_coloring.html

;; Key bindings, see http://ergoemacs.org/emacs/keyboard_shortcuts.html

;; THis does not work, might something with text-mode-hook and
;; the fact that we now define the doconce-mode differently from what
;; we do in the original .doconce-mode.el file



;; Key bindings, see http://ergoemacs.org/emacs/keyboard_shortcuts.html
(add-hook 'doconce-hook
 (lambda ()
 (local-set-key (kbd "\C-chelp") "
|--------------------------------------------------------|
| Emacs key      | Action                                |
|----l-------------------------l-------------------------|
|  Ctrl+c f      | figure                                |
|  Ctrl+c v      | movie/video                           |
|  Ctrl+c h1     | heading level 1 (section/h1)          |
|  Ctrl+c h2     | heading level 2 (subsection/h2)       |
|  Ctrl+c h3     | heading level 2 (subsection/h3)       |
|  Ctrl+c hp     | heading for paragraph                 |
|  Ctrl+c me     | math environment: !bt equation !et    |
|  Ctrl+c ma     | math environment: !bt align !et       |
|  Ctrl+c ce     | code environment: !bc !ec             |
|  Ctrl+c cf     | code from file: @@@CODE               |
|  Ctrl+c table  | table                                 |
|  Ctrl+c exer   | exercise outline                      |
|  Ctrl+c slide  | slide outline                         |
|--------------------------------------------------------|
")
 (local-set-key (kbd "\C-cf") "FIGURE: [path, width=400 frac=1.0] caption on one line. label{}")
 (local-set-key "\C-ch1" "======= Section heading (h1) =======")
 (local-set-key "\C-ch2" "===== Subsection heading (h2) =====")
 (local-set-key "\C-ch3" "=== Subsubsection heading (h3) ===")
 (local-set-key "\C-chp" "__Paragraph heading.__ ")
 (local-set-key "\C-cv" "MOVIE: [path] caption on one line.")
 (local-set-key (kbd "\C-cslide") "
!split
===== Slide heading =====

!bslidecell 00

!bpop
 * bullet 1
 * bullet 2
!epop

!eslidecell

!bslidecell 01
FIGURE: [path, width=400]
!eslidecell

")
 (local-set-key (kbd "\C-ctable") "
|------------------------|
| heading1 | heading2    |
|----l-----------r-------|
|  1.0     | 2.0         |
|------------------------|
")
 (local-set-key (kbd "\C-cme") "!bt
\\begin{equation}
...
label{}
\\end{equation}
!et")
 (local-set-key (kbd "\C-cma") "!bt
\\begin{align}
... &=
label{} \\\\
... &=
label{}
\\end{align}
!et")
 (local-set-key (kbd "\C-cce") "!bc
!ec")
 (local-set-key (kbd "\C-ccf") "@@@CODE path fromto: start_regex@to_regex")
 (local-set-key (kbd "\C-cexer") "===== Exercise: ... =====
label{}
file=solution.pdf

text...

# !bsol
# !esol

# !bsubex
# subexercise...

# !bsol
# !esol
# !esubex
")
)
)


;; Syntax highlighting

(make-face 'do-code-face)
(set-face-attribute 'do-code-face nil :family "courier")
(set-face-attribute 'do-code-face nil :slant 'normal)
;;(set-face-attribute 'do-code-face nil :background "red")

(make-face 'do-math-face)
(set-face-attribute 'do-math-face nil :family "courier")
(set-face-attribute 'do-math-face nil :slant 'normal)
(set-face-attribute 'do-math-face nil :height '170)

(make-face 'do-figmov-face)
;;(set-face-attribute 'do-figmov-face nil :background "gray")
(set-face-attribute 'do-figmov-face nil :slant 'italic)
(set-face-attribute 'do-figmov-face nil :underline t)

(make-face 'do-heading-face)
(set-face-attribute 'do-heading-face nil :background "gray")
(set-face-attribute 'do-heading-face nil :slant 'normal)

(make-face 'do-emph-face)
(set-face-attribute 'do-emph-face nil :slant 'italic)

(make-face 'do-bold-face)
(set-face-attribute 'do-bold-face nil :weight 'bold)

(make-face 'do-filecode-face)
(set-face-attribute 'do-filecode-face nil :slant 'italic)

(make-face 'do-comment-face)
(set-face-attribute 'do-comment-face nil :slant 'italic)
(set-face-attribute 'do-comment-face nil :foreground "red")



;;;###autoload
(define-generic-mode doconce
  '(("%<doc>" . "%</doc>"))              ; (mako) comment characters
  '("bwarning" "ewarning" "bsol" "esol") ; keywords (!bt used below does not work well)
  '(("\\(!bc[^§]+?!ec\\)" (1 'do-code-face))
    ("\\(\\(FIGURE\\|MOVIE\\|AUTHOR\\|TITLE\\):.+$\\)" (1 'do-figmov-face))
    ("\\(!bt[^§]+?!et\\)" (1 'do-math-face))
    ("\\(\\*.+?\\*\\)" (1 'do-emph-face))
    ("\\(_.+?_\\)" (1 'do-bold-face))
    ("\\(==+ *.+ *==+\\)" (1 'do-heading-face))
    ("\\(^__.+?[.:?]__\\)" (1 'do-heading-face))
    ("\\(@@@CODE .+$\\)" (1 'do-filecode-face))
    ("\\(^#.+$\\)" (1 'do-comment-face))
   )                ; font lock
  '("\\.do\\.txt$")                     ; auto-mode-alist
  '(hello-world-special-setup)          ; function-list
  "An example major mode.
We have comments, keywords, a special face for dates, and recognize .hello files.")

(defun hello-world-special-setup ()
  "Some custom setup stuff done here by mode writer."
  (message "You've just enabled the most amazing mode ever."))


;;
;; File: init.el
;; Created Date: Sunday, April 29th 2018, 10:23:53 am
;; Author: Chirag Raman
;;
;; Copyright (c) 2018 Chirag Raman

;; The following parses an org file and evaluates its emacs-lisp code blocks.
;; This has three main advantages to using org-babel-load-file.
;;   1. Explicit control over what blocks get evaluated.
;;   2. Messaging the exact heading containing a block causing an error.
;;   3. Not dependent on org-mode.

;; Inspired by [[http://endlessparentheses.com/init-org-Without-org-mode.html]
;;              ["init.org Without org-mode"]]

;; Like Adam, I've named my "init.org" file "README.org" so it gets displayed
;; by GitHub.

(defvar init.org-message-depth 3
  "What depth of init.org headings to message at startup.")

(with-temp-buffer
  (insert-file-contents (expand-file-name "README.org" user-emacs-directory))
  (goto-char (point-min))

  ;; Skip straight to the first elisp code block.
  (re-search-forward "^[\s-]*#\\+BEGIN_SRC +emacs-lisp$")
  ;; Set point to previous heading
  (re-search-backward (format "\\*\\{1,%s\\} +.*$"
                              init.org-message-depth))
  ;; Alternatively, you can have all elisp code blocks under a single parent heading.
  ;; (search-forward "\n* init.el")

  ;; Begin parsing org file.
  (while (not (eobp))
    (forward-line 1)
    (cond
     ;; Report headings
     ((looking-at
       (format "\\*\\{1,%s\\} +.*$"
               init.org-message-depth))
      (message "%s" (match-string 0)))  ;; Messages where currently parsing.
     ;; Evaluate code blocks
     ((looking-at "^[\s-]*#\\+BEGIN_SRC +emacs-lisp$")
      (let ((l (match-end 0)))
        (search-forward "\n#+END_SRC")
        ;; Write evaluated elisp source blocks to a single file.
        ;;(append-to-file l (match-beginning 0) "initorg.el")
        (eval-region l (match-beginning 0))))
     ;; Finish on the next level-1 heading
     ((looking-at "^\\* ")
      (goto-char (point-max)))))
  ;; Startup message.
  (message "Don't Panic."))
(defvar-keymap minibuffer-local-replace-map
  :doc "Keymap for editing Replace strings in the minibuffer."
  :parent minibuffer-local-map
;;  "C-j"     #'electric-indent-just-newline
)
;;(define-key minibuffer-local-isearch-map (kbd "C-j") 'electric-indent-just-newline)
;;(define-key minibuffer-local-replace-map (kbd "C-j") 'electric-indent-just-newline)

(defun query-replace (from-string to-string &optional delimited start end backward region-noncontiguous-p)
  "Replace some occurrences of FROM-STRING with TO-STRING.
As each match is found, the user must type a character saying
what to do with it.  Type SPC or `y' to replace the match,
DEL or `n' to skip and go to the next match.  For more directions,
type \\[help-command] at that time.

In Transient Mark mode, if the mark is active, operate on the contents
of the region.  Otherwise, operate from point to the end of the buffer's
accessible portion.

In interactive use, the prefix arg (non-nil DELIMITED in
non-interactive use), means replace only matches surrounded by
word boundaries.  A negative prefix arg means replace backward.

Use \\<minibuffer-local-map>\\[next-history-element] \
to pull the last incremental search string to the minibuffer
that reads FROM-STRING, or invoke replacements from
incremental search with a key sequence like \\`C-s C-s M-%'
to use its current search string as the string to replace.

Matching is independent of case if both `case-fold-search'
and `search-upper-case' are non-nil and FROM-STRING has no
uppercase letters; if `search-upper-case' is nil, then
whether matching ignores case depends on `case-fold-search'
regardless of whether there are uppercase letters in FROM-STRING.
Replacement transfers the case pattern of the old text to the
new text, if both `case-fold-search' and `case-replace' are
non-nil and FROM-STRING has no uppercase letters.
\(Transferring the case pattern means that if the old text
matched is all caps, or all of its words are capitalized, then its
replacement is respectively upcased or capitalized.  For more
details about this, see `replace-match'.)

Ignore read-only matches if `query-replace-skip-read-only' is non-nil,
ignore hidden matches if `search-invisible' is nil, and ignore more
matches using `isearch-filter-predicate'.

If `replace-lax-whitespace' is non-nil, a space or spaces in the string
to be replaced will match a sequence of whitespace chars defined by the
regexp in `search-whitespace-regexp'.

If `replace-char-fold' is non-nil, matching uses character folding,
i.e. it ignores diacritics and other differences between equivalent
character strings.

Fourth and fifth arg START and END specify the region to operate on.

Arguments FROM-STRING, TO-STRING, DELIMITED, START, END, BACKWARD, and
REGION-NONCONTIGUOUS-P are passed to `perform-replace' (which see).
\(TO-STRING is passed to `perform-replace' as REPLACEMENTS and
DELIMITED is passed as DELIMITED-FLAG.)

To customize possible responses, change the bindings in `query-replace-map'."
  (declare (interactive-args
	    (start (use-region-beginning))
	    (end (use-region-end))
	    (region-noncontiguous-p (use-region-noncontiguous-p))))
  (interactive
   (let ((common
	  (query-replace-read-args
	   (concat "Query replace"
		   (if current-prefix-arg
		       (if (eq current-prefix-arg '-) " backward" " word")
		     "")
		   (if (use-region-p) " in region" ""))
	   nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
	   ;; These are done separately here
	   ;; so that command-history will record these expressions
	   ;; rather than the values they had this time.
	   (use-region-beginning) (use-region-end)
	   (nth 3 common)
	   (use-region-noncontiguous-p))))
  (perform-replace from-string to-string t nil delimited nil nil start end backward region-noncontiguous-p))

(defun query-replace-read-args (prompt regexp-flag &optional noerror)
  (unless noerror
    (barf-if-buffer-read-only))
  (save-mark-and-excursion
    (let* ((delimited-flag (and current-prefix-arg
                                (not (eq current-prefix-arg '-))))
           (from (minibuffer-with-setup-hook
                     (minibuffer-lazy-highlight-setup
                      :case-fold case-fold-search
                      :filter (when (use-region-p)
                                (replace--region-filter
                                 (funcall region-extract-function 'bounds)))
                      :highlight query-replace-lazy-highlight
                      :regexp regexp-flag
                      :regexp-function (or replace-regexp-function
                                           delimited-flag
                                           (and replace-char-fold
	                                        (not regexp-flag)
	                                        #'char-fold-to-regexp))
                      :transform (lambda (string)
                                   (let* ((split (query-replace--split-string string))
                                          (from-string (if (consp split) (car split) split)))
                                     (when (and case-fold-search search-upper-case)
	                               (setq isearch-case-fold-search
                                             (isearch-no-upper-case-p from-string regexp-flag)))
                                     from-string)))
                   (query-replace-read-from prompt regexp-flag)))

           (to (if (consp from) (prog1 (cdr from) (setq from (car from)))
                 (query-replace-read-to from prompt regexp-flag))))

      (list from to
            (or delimited-flag
                (and (plist-member (text-properties-at 0 from) 'isearch-regexp-function)
                     (get-text-property 0 'isearch-regexp-function from)))
            (and current-prefix-arg (eq current-prefix-arg '-))))))

(defun query-replace-read-from (prompt regexp-flag)
  "Query and return the `from' argument of a `query-replace' operation.
Prompt with PROMPT.  REGEXP-FLAG non-nil means the response should be a regexp.
The return value can also be a pair (FROM . TO) indicating that the user
wants to replace FROM with TO."
  (let* ((history-add-new-input nil)
         (separator-string
          (when query-replace-from-to-separator
            ;; Check if the first non-whitespace char is displayable
            (if (char-displayable-p
                 (string-to-char (string-replace
                                  " " "" query-replace-from-to-separator)))
                query-replace-from-to-separator
              " -> ")))
         (separator
          (when separator-string
            (propertize separator-string
                        'display separator-string
                        'face 'minibuffer-prompt
                        'separator t)))
         (minibuffer-history
          (append
           (when separator
             (mapcar (lambda (from-to)
                       (concat (query-replace-descr (car from-to))
                               separator
                               (query-replace-descr (cdr from-to))))
                     query-replace-defaults))
           (symbol-value query-replace-from-history-variable)))
         (minibuffer-allow-text-properties t) ; separator uses text-properties
         (default (when (and query-replace-read-from-default (not regexp-flag))
                    (funcall query-replace-read-from-default)))
         (prompt
          (cond ((and query-replace-read-from-regexp-default regexp-flag) prompt)
                (default (format-prompt prompt default))
                ((and query-replace-defaults separator)
                 (format-prompt prompt (car minibuffer-history)))
                (query-replace-defaults
                 (format-prompt
                  prompt (format "%s -> %s"
                                 (query-replace-descr
                                  (caar query-replace-defaults))
                                 (query-replace-descr
                                  (cdar query-replace-defaults)))))
                (t (format-prompt prompt nil))))
         (from
          ;; The save-excursion here is in case the user marks and copies
          ;; a region in order to specify the minibuffer input.
          ;; That should not clobber the region for the query-replace itself.
          (save-excursion
            (minibuffer-with-setup-hook
                (lambda ()
                  (setq-local text-property-default-nonsticky
                              (append '((separator . t) (face . t))
                                      text-property-default-nonsticky)))
              (if regexp-flag
                  (read-regexp
                   (if query-replace-read-from-regexp-default
                       (string-remove-suffix ": " prompt)
                     prompt)
                   query-replace-read-from-regexp-default
                   'minibuffer-history)
		;;else
                (read-from-minibuffer
                 ;;prompt nil nil nil nil
                 prompt nil minibuffer-local-replace-map nil nil
                 (if default
                     (delete-dups
                      (cons default (query-replace-read-from-suggestions)))
                   (query-replace-read-from-suggestions))
                 t)))))
         (to))

    (if (and (zerop (length from)) query-replace-defaults (not default))
        (cons (caar query-replace-defaults)
              (query-replace-compile-replacement
               (cdar query-replace-defaults) regexp-flag))
      ;;else
      (setq from (or (and (zerop (length from)) default)
                     (query-replace--split-string from)))
      (when (consp from) (setq to (cdr from) from (car from)))
      (add-to-history query-replace-from-history-variable from nil t)

      ;; Warn if user types \n or \t, but don't reject the input.
      (and regexp-flag
           (string-match "\\(\\`\\|[^\\]\\)\\(\\\\\\\\\\)*\\(\\\\[nt]\\)" from)
           (let ((match (match-string 3 from)))
             (cond
              ((string= match "\\n")
               (message "Note: `\\n' here doesn't match a newline; to do that, type C-q C-j instead"))
              ((string= match "\\t")
               (message "Note: `\\t' here doesn't match a tab; to do that, just type TAB")))
             (sit-for 2)))

      (if (not to)
          from
	;;else
        (add-to-history query-replace-to-history-variable to nil t)
        (add-to-history 'query-replace-defaults (cons from to) nil t)
        (cons from (query-replace-compile-replacement to regexp-flag)))

      )
    )
  )

(defun query-replace-read-to (from prompt regexp-flag)
  "Query and return the `to' argument of a `query-replace' operation.
Prompt with PROMPT.  REGEXP-FLAG non-nil means the response
should a regexp."
  (query-replace-compile-replacement
   (save-excursion
     (let* ((history-add-new-input nil)
	    (to (read-from-minibuffer
		 (format "%s %s with: " prompt (query-replace-descr from))
		 ;;nil nil nil
		 nil minibuffer-local-replace-map nil
		 query-replace-to-history-variable from t)))
       (add-to-history query-replace-to-history-variable to nil t)
       (add-to-history 'query-replace-defaults (cons from to) nil t)
       to))
   regexp-flag))

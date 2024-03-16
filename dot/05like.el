


;; ------ 05like.el ------

;;====================================
;;;; function keys
;;====================================
;;was                 help-command
(global-set-key [f1] 'help-for-help)
(global-set-key [S-f1] 'other-window)

;;        C-x 6 2		2C-two-columns
;;        C-x 6 b		2C-associate-buffer
;;        C-x 6 s		2C-split
;;was                 2C-command
(global-set-key [f2] 'ak-divide-screen-toggle)
;;(global-set-key [S-f2] 'ak-divide-screen-or-other)
(global-set-key [S-f2] 'ak-divide-screen3-or-other)

;;was                 kmacro-start-macro-or-insert-counter
(global-set-key [f3] 'isearch-repeat-forward)
(global-set-key [S-f3] 'isearch-repeat-backward)

(defun ak-kill-buffer() (interactive) (kill-buffer))  ;; redefined later
(global-set-key "\C-xk" 'ak-kill-buffer)
;;was                    kmacro-end-or-call-macro
(global-set-key [f4]    'ak-kill-buffer)
(global-set-key [S-f4] 'delete-window)

(global-set-key [f5]  'recenter)
(global-set-key [S-f5]  #'(lambda()(interactive)(dired ".")))

(global-set-key [f6]   'universal-coding-system-argument)       ;;   C-x RET-c
(global-set-key [S-f6]   'electric-indent-mode)
;;test macro
(global-set-key (kbd "ESC <f6>")  'kmacro-start-macro-or-insert-counter)  ;; <f3>
(global-set-key [C-f6]  'kmacro-end-or-call-macro)  ;; <f4>

(global-set-key [f7]   'shrink-window)
(global-set-key [S-f7] 'shrink-window-horizontally)
(global-set-key [f8]   'enlarge-window)
(global-set-key [S-f8] 'enlarge-window-horizontally)

(global-set-key [f9]  'describe-key-briefly)
(global-set-key [S-f9] #'(lambda()(interactive)
                          (if case-fold-search
                              (progn (setq-default case-fold-search nil)(message "case sensitive Search mode"))
                            (progn (setq-default case-fold-search t)(message "ignore case Search mode")))
                          ))

;;was  menu-bar-open
(global-set-key [f10] 'window-swap-division)
(global-set-key [S-f10] 'window-toggle-division-reverse)
;;               M-f10   toggle-frame-maximized  =  "ESC <f10>"

(global-set-key (kbd "M-<f11>")   'toggle-frame-fullscreen)  ;; <f11>
(global-set-key (kbd "ESC <f11>") 'toggle-frame-fullscreen)  ;; <f11>

;;was                 'toggle-frame-fullscreen  ==> "ESC <f11>"
(global-set-key [f11] 'toggle-truncate-lines)  ;; Show Desktop (MAC OSX)
(global-set-key [f12] 'global-linum-mode)
(global-set-key [S-f11] 'scroll-right)
(global-set-key [S-f12] 'scroll-left)


;;====================================
;;;; press left at top of window then kill buffer and show dired
;;====================================
;;(global-set-key (kbd "C-b") 'ak-backward-char)

;; ;; Cursor L, R move always logical order, backward and forward,
;; ;; even at R2L text and visual-order-cursor-movement is t
;; (global-set-key [left] 'ak-backward-char)
;; (global-set-key [right] 'forward-char)

;; cursor move L R naturally at R2L text.
(global-set-key [left] 'ak-left-char)
(global-set-key [right] 'ak-right-char)
(if (boundp 'cua--rectangle-keymap)
    (progn
      (define-key cua--rectangle-keymap [remap ak-right-char]          #'cua-resize-rectangle-right)
      (define-key cua--rectangle-keymap [remap ak-left-char]           #'cua-resize-rectangle-left)
      (define-key cua--rectangle-keymap [remap ak-backward-char]       #'cua-resize-rectangle-left)
      ))

(setq visual-order-cursor-movement t)

(defun ak-backward-char (&optional arg)
  "press left arrow at the top  then kill buffer."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (if (not(equal (point) (point-min)))
        (backward-char arg)
      ;else
      (kill-buffer-and-dired)
      )
    )
  )
(defun ak-left-char (&optional arg)
  "press left arrow at the top  then kill buffer."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (left-char arg)
    ;;else
    (if (and(equal (point) (point-min))
	(equal (current-bidi-paragraph-direction) 'left-to-right))
	(kill-buffer-and-dired)
      ;;else
      (left-char arg))
    )
  )
(defun ak-right-char (&optional arg)
  "press right arrow at the top  then kill buffer at R2L text."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (right-char arg)
    ;;else
    (if (and(equal (point) (point-min))
	(equal (current-bidi-paragraph-direction) 'right-to-left))
	(kill-buffer-and-dired)
      ;;else
      (right-char arg))
    )
  )
(defun kill-buffer-and-dired()
  "kill this buffer and show current directory."
  ;;(interactive)
  (if (string= major-mode "dired-mode")
      (kill-buffer nil)
    (find-alternate-file "."))
  )

;;=============================A<>B=====
;;; swap 2 screen  A<-|->B    ------
;;=============================B<>A=====
(defun window-swap-division ()
  "toggle window ver-hor divide"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (after-minx)
        (after-miny)
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-right)
          (if (not (= before-minx (nth 0 (window-edges))))
	      ;;(progn
	      (other-window 1) ;;(message "AAAAAAAA"))
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-below)
        (if (not (= before-miny (nth 1 (window-edges))))
	    ;;(progn
            (other-window 1) ;;(message "BBBBBBBBB"))
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
;;========================A=========B===
;;; rotate 2 screen  A|B ---  B|A  ---
;;========================B=========A===
(defun org-xor (a b)
  "Exclusive or."
  (if a (not b) b))
(defun window-toggle-division (&optional reverse)
  "toggle window ver-hor divide"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (after-minx)
        (after-miny)
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
          ;;(split-window-vertically)            ;; ---------------
          (split-window-below)
          (if (org-xor reverse (= before-minx (nth 0 (window-edges))))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
        ;;(split-window-horizontally)            ;;     A | B
        (split-window-right)
        (if (org-xor reverse (not (= before-miny (nth 1 (window-edges)))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
(defun window-toggle-division-reverse ()
  "toggle window ver-hor divide"
  (interactive)
  (window-toggle-division t)
  )

;;====================================
;;;; jump matching paren (<--->)
;;====================================
(global-set-key "\C-]" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis"
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        )
  )

;;====================================
;;;;divide/one screen
;;====================================
(defun ak-divide-screen-toggle()
  "Divide one window or Close next window."
  (interactive)
        (if (one-window-p)
                (split-window-below)
          (delete-other-windows)))

;;====================================
;;;;divide L|R /one screen
;;====================================
(defun ak-divide-screen3-toggle()
  "Divide one window or Close next window."
  (interactive)
        (if (one-window-p)
                (split-window-right)
          (delete-other-windows)))

;;====================================
;;;;divide/other screen (reverse)
;;====================================
(defun ak-divide-screen-or-other()
  "Divide one window or move to next window."
  (interactive)
        (if (one-window-p)
                (split-window-below)
          (other-window -1)))

;;====================================
;;;;divide L|R /other screen (reverse)
;;====================================
(defun ak-divide-screen3-or-other()
  "Divide one window or move to next window."
  (interactive)
        (if (one-window-p)
                (split-window-right)
          (other-window -1)))

;;====================================
;;;;add region mark
;;====================================
;;  "リージョンに引用マークをつける"  M-x cite-region
(defvar quoting-marker "//")
;;;(defun cite-region ()        tex で消える
(defun ciregion ()
  "insert // to region"
  (interactive)
  (setq quoting-marker
                (read-string "Quoting marker: " quoting-marker)
                )
  
  (save-excursion
    (let 
                (
                  (e (max (region-end) (region-beginning)))
                   (b (min (region-end) (region-beginning)))
                    (len (length quoting-marker))
                         )
      (goto-char b)
      (while (<= (+ (point) 1) e)
        ;;xx (insert-string quoting-marker)
        (insert quoting-marker)
        (setq e (+ e len))
        (forward-line 1)))))
;;;end cite-region

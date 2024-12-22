


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

;;was                    kmacro-end-or-call-macro
(global-set-key [f4]    'kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key [S-f4] 'delete-window)

(global-set-key [f5]  'recenter)
(global-set-key [S-f5] 'ak-dired-current-dir)
(defun ak-dired-current-dir()
  "dired current directory" (interactive)
  (dired "."))

(global-set-key [f6]   'universal-coding-system-argument)       ;;   C-x RET-c
(global-set-key [S-f6]   'electric-indent-mode)
;;test macro
(global-set-key (kbd "ESC <f6>")  'kmacro-start-macro-or-insert-counter)  ;; <f3>
(global-set-key [C-f6]  'kmacro-end-or-call-macro)  ;; <f4>

(global-set-key [f7]   'ak-shrink-window)
(global-set-key [S-f7] 'ak-shrink-window2)
(global-set-key [f8]   'ak-enlarge-window)
(global-set-key [S-f8] 'ak-enlarge-window2)

(global-set-key [f9]  'describe-key-briefly)
(global-set-key [S-f9] 'ak-toggle-case-fold-search)
(defun ak-toggle-case-fold-search()
  "Toggle search case." (interactive)
  (if case-fold-search
      (progn (setq-default case-fold-search nil)
	     (message "case sensitive Search mode"))
    (setq-default case-fold-search t)
    (message "ignore case Search mode")))

;;was  menu-bar-open
(global-set-key [f10] 'ak-window-swap-split)
;; (global-set-key [S-f10] 'ak-window-vh-split)
;; (global-set-key [f10] 'ak-window-rotate-split)
(global-set-key [S-f10] 'ak-window-rotate-split-reverse)
;;               M-f10   toggle-frame-maximized  =  "ESC <f10>"

(global-set-key (kbd "M-<f11>")   'toggle-frame-fullscreen)  ;; <f11>
(global-set-key (kbd "ESC <f11>") 'toggle-frame-fullscreen)  ;; <f11>

;;was                 'toggle-frame-fullscreen  ==> "ESC <f11>"
(global-set-key [f11] 'toggle-truncate-lines)  ;; Show Desktop (MAC OSX)
;; (require 'linum)                            ;; obsolete (emacs29)
;; (global-set-key [f12] 'global-linum-mode)
(global-set-key [f12] 'global-display-line-numbers-mode)
;;(global-set-key [f12] 'display-line-numbers-mode)
(global-set-key [S-f11] 'scroll-right)
(global-set-key [S-f12] 'scroll-left)


;;======================================
;;; shrink / enlarge window automatic_|_
;;======================================
(defun ak-shrink-window (&optional vh)
  "shrink window to possible direction"
  (interactive)
  (if (window-full-height-p)
      (shrink-window 1 t)
    (if (window-full-width-p)
        (shrink-window 1 nil)
      ;;else
      (if vh
	  (shrink-window 1 t) ;;<-|
	(shrink-window 1 nil)) ;;_A_ (default)
      ))
  )
(defun ak-shrink-window2 ()
  "for small window, shrink <-|"
  (interactive)
  (ak-shrink-window t))
(defun ak-enlarge-window (&optional vh)
  "enlarge window to possible direction"
  (interactive)
  (if (window-full-height-p)
      (enlarge-window 1 t)
    (if (window-full-width-p)
        (enlarge-window 1 nil)
      ;;else
      (if vh
	  (enlarge-window 1 t) ;;->|
	(enlarge-window 1 nil)) ;;_V_ (default)
      ))
  )
(defun ak-enlarge-window2 ()
  "for small window, enlarge ->|"
  (interactive)
  (ak-enlarge-window t))
;;=============================A<>B=====
;;; swap 2 screen  A<-|->B    ------
;;=============================B<>A=====
(defun ak-window-swap-split ()
  "swap 2 window of U-D or L-R"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-right)
          (if (not (= before-minx (nth 0 (window-edges))))
	      (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-below)
        (if (not (= before-miny (nth 1 (window-edges))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
;;================================A=====
;;; VerHor swap 2  A|B  <-->   ------
;;================================B=====
(defun ak-window-vh-split ()
  "toggle window split ver-hor"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-below)
          (if (= before-minx (nth 0 (window-edges)))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-right)
        (if (= before-miny (nth 1 (window-edges)))
            (other-window 1)
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
(defun ak-xor (a b)
  "Exclusive or."
  (if a (not b) b))
(defun ak-window-rotate-split (&optional reverse)
  "rotate window split clockwise"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-below)
          (if (ak-xor reverse (= before-minx (nth 0 (window-edges))))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-right)
        (if (ak-xor reverse (not (= before-miny (nth 1 (window-edges)))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
(defun ak-window-rotate-split-reverse ()
  "rotate window split unti-clockwise"
  (interactive)
  (ak-window-rotate-split t)
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




;; ------ 04dired.el ------

;;====================================
;;;;  dired bindings
;;====================================

(setq dired-clean-up-buffers-too nil)
;; Save Z directory
;;(setq dired-default-directory default-directory)
;;;;Warning: assignment to free variable ‘dired-default-directory’
(defvar dired-default-directory default-directory)

;; Extra keybinds for dired mode

(with-eval-after-load 'dired
  (require 'dired-x)
  ;;(require 'wdired)
  (define-key dired-mode-map [right]   'ak-dired-find-file)          ;; -> f
  (define-key dired-mode-map [left]    'ak-dired-up-directory)       ;; <- ^
  (define-key dired-mode-map [home]    'ak-dired-beginning-of-buffer)
  (define-key dired-mode-map [end]     'ak-dired-end-of-buffer)
  (define-key dired-mode-map [prior]   'ak-dired-scroll-down)
  (define-key dired-mode-map [next]    'ak-dired-scroll-up)
  (define-key dired-mode-map [f5]      'revert-buffer)               ;; g
  (define-key dired-mode-map "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
  ;; S            dired-do-symlink
  ;; Y            dired-do-relsymlink  dired-x.el
  ;; edit filename in wdired mode      autoload wdired.el
  (define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)

  (define-key dired-mode-map "h" #'(lambda()(interactive)(dired "~")))
  (define-key dired-mode-map "r" #'(lambda()(interactive)(dired "/")))
  (define-key dired-mode-map "z" #'(lambda()(interactive)(dired dired-default-directory)))
  (and (getenv "A_DIRECTORY") (define-key dired-mode-map "a" #'(lambda()(interactive)(dired (getenv "A_DIRECTORY")))))
  (and (getenv "B_DIRECTORY") (define-key dired-mode-map "b" #'(lambda()(interactive)(dired (getenv "B_DIRECTORY")))))
  (and (getenv "C_DIRECTORY") (define-key dired-mode-map "c" #'(lambda()(interactive)(dired (getenv "C_DIRECTORY")))))
  (and (getenv "E_DIRECTORY") (define-key dired-mode-map "e" #'(lambda()(interactive)(dired (getenv "E_DIRECTORY")))))

  ;; avoid remapping to dired-next(previous)-line
  (defalias 'ak-dired-next-line 'next-line)
  (defalias 'ak-dired-previous-line 'previous-line)
  (define-key dired-mode-map "\C-n" 'ak-dired-next-line)
  (define-key dired-mode-map "\C-p" 'ak-dired-previous-line)

  ;; line scroll and keep cursor on file name
  (define-key dired-mode-map [C-up]   'ak-dired-line-up       )
  (define-key dired-mode-map [C-down] 'ak-dired-line-down     )
  (define-key dired-mode-map [s-up]   'ak-dired-line-up-fast  )
  (define-key dired-mode-map [s-down] 'ak-dired-line-down-fast)
  (define-key dired-mode-map (kbd "C-M-p") 'ak-dired-line-up  ) ;;was dired-prev-subdir
  (define-key dired-mode-map (kbd "C-M-n") 'ak-dired-line-down) ;;was dired-next-subdir

  ;; skip files
  (define-key dired-mode-map "N" 'dired-next-dirline)     ;;was dired-do-man    ">"
  (define-key dired-mode-map "P" 'dired-prev-dirline)     ;;was dired-do-print  "<"
  ;;(message "eval-after-load 'dired done.")
  )

(add-hook 'dired-mode-hook
	  (lambda ()
            ;;(dired-omit-mode 1)
            (setq truncate-lines 1)
            ))

(defun ak-dired-find-file (&optional arg)
  "find file or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (forward-char arg)
    ;else
    (dired-find-file)
    )
  )
(defun ak-dired-up-directory (&optional arg)
  "up directory or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (dired-up-directory)
    )
  )

;;(defvar dired-first-lines 4)
(defvar dired-first-lines 3)
(defun ak-dired-beginning-of-buffer()
  "in dired set cursor at first file"
  (interactive "^")
  (if this-command-keys-shift-translated
      (beginning-of-line)
    ;(setq mark-active nil)
    (goto-char (point-min))
    (dired-next-line dired-first-lines))
  )
(defun ak-dired-end-of-buffer()
  "in dired set cursor at last file"
  (interactive "^")
  (if this-command-keys-shift-translated
      (end-of-line)
    ;(setq mark-active nil)
    (goto-char (point-max))
    (dired-previous-line 1))
  )

(defun ak-dired-scroll-down ()
  "Page up and set cursor at file"
  (interactive "^")
  (if (ak-first-page-p)
      (progn
        (move-to-window-line 0)
        (dired-next-line dired-first-lines))
    (scroll-down)
    (dired-previous-line 1))
  )
(defun ak-dired-scroll-up ()
  "Page down and set cursor at file"
  (interactive "^")
  (if (ak-last-page-p)
      (progn
        (move-to-window-line -1)
        (dired-previous-line 1))
    (scroll-up)
    (dired-next-line 1))
  )

(defun ak-dired-line-up()        (interactive "^")
       (let ( (pos0 (current-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line -1)
	   (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down()      (interactive "^")
       (let ( (pos0 (current-line)) )
	 (scroll-up   1)(move-to-window-line pos0)(dired-next-line 0)))
(defun ak-dired-line-up-fast()   (interactive "^")
       (let ( (pos0 (current-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line -4)
	   (scroll-down 4)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down-fast() (interactive "^")
       (let ( (pos0 (current-line)) )
	 (scroll-up   4)(move-to-window-line pos0)(dired-next-line 0)))

(defun ak-dired-find-file-hexl ()
  "In dired, visit the Binary file in hexl-mode named on this line."
  (interactive)
  (hexl-find-file (dired-get-filename)))


;;====================================
;;;; press left at top of window then kill buffer and show dired
;;====================================
(global-set-key (kbd "C-b") 'ak-backward-char)

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

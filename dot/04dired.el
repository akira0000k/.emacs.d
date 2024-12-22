


;; ------ 04dired.el ------

;;====================================
;;;;  dired bindings
;;====================================

(setq dired-clean-up-buffers-too nil)
;; Save Z directory
(defvar dired-default-directory default-directory)
;; t = Open like Vi by [right]
(defcustom ak-dired-view-on-right-arrow nil
  "Non-nil means open in view mode by right arrow in dired."
  :type 'boolean
  :group 'dired
  )

;; Extra keybinds for dired mode

(with-eval-after-load 'dired
  (require 'dired-x)
  ;;(require 'wdired)
  (define-key dired-mode-map [right]   'ak-dired-right-char)      ;; -> f, v
  (define-key dired-mode-map [left]    'ak-dired-left-char)       ;; <- ^
  (define-key dired-mode-map [home]    'ak-dired-home)
  (define-key dired-mode-map [end]     'ak-dired-end)
  (define-key dired-mode-map [prior]   'ak-dired-scroll-down)
  (define-key dired-mode-map [next]    'ak-dired-scroll-up)
  (define-key dired-mode-map [f5]      'revert-buffer)               ;; g
  (define-key dired-mode-map "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
  ;; S            dired-do-symlink
  ;; Y            dired-do-relsymlink  dired-x.el
  ;; edit filename in wdired mode      autoload wdired.el
  (define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)

  (define-key dired-mode-map "h" 'ak-dired-home-dir)
  (define-key dired-mode-map "r" 'ak-dired-root-dir)
  (define-key dired-mode-map "z" 'ak-dired-defo-dir)
  (and (getenv "A_DIRECTORY") (define-key dired-mode-map "a" 'ak-dired-a-dir))
  (and (getenv "B_DIRECTORY") (define-key dired-mode-map "b" 'ak-dired-b-dir))
  (and (getenv "C_DIRECTORY") (define-key dired-mode-map "c" 'ak-dired-c-dir))
  (and (getenv "E_DIRECTORY") (define-key dired-mode-map "e" 'ak-dired-e-dir))
  (define-key dired-mode-map (kbd "C-b") 'dired-up-directory)

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
  (define-key dired-mode-map (kbd "C-,") 'ak-dired-beginning-of-buffer)
  (define-key dired-mode-map (kbd "C-.") 'ak-dired-end-of-buffer)
  (define-key dired-mode-map (kbd ",") 'ak-dired-beginning-of-buffer)
  (define-key dired-mode-map (kbd ".") 'ak-dired-end-of-buffer)  ;;was dired-clean-directory
  (define-key dired-mode-map (kbd "M-.") 'dired-clean-directory) ;;was xref-find-definitions
  (define-key dired-mode-map (kbd "C-h") 'dired-unmark-backward) ;;like backspace

  ;; Vi-like
  (define-key dired-mode-map "j" 'next-line)
  (define-key dired-mode-map "k" 'previous-line)
  (define-key dired-mode-map "J" 'ak-dired-line-down)
  (define-key dired-mode-map "K" 'ak-dired-line-up)
  ;;(message "eval-after-load 'dired done.")
  )

(defun ak-dired-home-dir()(interactive)(dired "~"))
(defun ak-dired-root-dir()(interactive)(dired "/"))
(defun ak-dired-defo-dir()(interactive)(dired dired-default-directory))
(defun ak-dired-a-dir()(interactive)(dired (getenv "A_DIRECTORY")))
(defun ak-dired-b-dir()(interactive)(dired (getenv "B_DIRECTORY")))
(defun ak-dired-c-dir()(interactive)(dired (getenv "C_DIRECTORY")))
(defun ak-dired-e-dir()(interactive)(dired (getenv "E_DIRECTORY")))

(add-hook 'dired-mode-hook
	  (lambda ()
            ;;(dired-omit-mode 1)
            (setq truncate-lines 1)
            ))

(defun ak-dired-right-char (&optional arg)
  "find file or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (forward-char arg)
    ;;else
    (if ak-dired-view-on-right-arrow
	(dired-view-file)
      (dired-find-file))
    )
  )
(defun ak-dired-left-char (&optional arg)
  "up directory or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (dired-up-directory)
    )
  )

(defun ak-dired-home()
  "go to first file or select to col1"
  (interactive "^")
  (if this-command-keys-shift-translated
      (beginning-of-line)
    (ak-dired-beginning-of-buffer))
  )
(defun ak-dired-beginning-of-buffer()
  "in dired set cursor at first file"
  (interactive "^")
  (goto-char (point-min))
  (dired-goto-next-nontrivial-file)
  ;; no valid file, first line.
  (when (equal (point) (point-max))
    (goto-char (point-min))
    (dired-next-line 1))
  )
(defun ak-dired-end()
  "go to last file or select to end of line"
  (interactive "^")
  (if this-command-keys-shift-translated
      (end-of-line)
    (ak-dired-end-of-buffer))
  )
(defun ak-dired-end-of-buffer()
  "in dired set cursor at last file"
  (interactive "^")
  (goto-char (point-max))
  (dired-previous-line 1)
  )

(defun ak-dired-scroll-down ()
  "Page up and set cursor at file"
  (interactive "^")
  (if (ak-first-page-p)
      (ak-dired-beginning-of-buffer)
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
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line -1)
	   (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down()      (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (scroll-up   1)(move-to-window-line pos0)(dired-next-line 0)))
(defun ak-dired-line-up-fast()   (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line (- ak-fast-scroll-lines))
	   (scroll-down ak-fast-scroll-lines)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down-fast() (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (if (ak-last-page-p)
	     (dired-next-line ak-fast-scroll-lines)
	 (scroll-up ak-fast-scroll-lines)(move-to-window-line pos0)(dired-next-line 0))))

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

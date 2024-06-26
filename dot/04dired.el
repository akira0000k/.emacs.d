


;; ------ 04dired.el ------

;;====================================
;;;;  dired bindings
;;====================================
;; edit filename in dired mode
(require 'wdired)
(require 'dired-x)
(setq dired-clean-up-buffers-too nil)
;; S            dired-do-symlink
;; Y            dired-do-relsymlink
(define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)
(define-key dired-mode-map "h" #'(lambda()(interactive)(dired "~")))
(define-key dired-mode-map "r" #'(lambda()(interactive)(dired "/")))
(define-key dired-mode-map "z" #'(lambda()(interactive)(dired dired-default-directory)))
;; avoid remapping to dired-next(previous)-line
(defalias 'ak-dired-next-line 'next-line)
(defalias 'ak-dired-previous-line 'previous-line)
(define-key dired-mode-map "\C-n" 'ak-dired-next-line)
(define-key dired-mode-map "\C-p" 'ak-dired-previous-line)
;; keep cursor on file name
(define-key dired-mode-map [C-up] #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [C-down] #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-up 1)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [C-S-up] #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-down 4)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [C-S-down] #'(lambda()(interactive "^")
			       (let ( (pos0 (current-line)) )
				 (scroll-up 4)(move-to-window-line pos0)(dired-next-line 0))))
(and (setq a-directory (getenv "A_DIRECTORY")) (define-key dired-mode-map "a" #'(lambda()(interactive)(dired a-directory))))
(and (setq b-directory (getenv "B_DIRECTORY")) (define-key dired-mode-map "b" #'(lambda()(interactive)(dired b-directory))))
(and (setq c-directory (getenv "C_DIRECTORY")) (define-key dired-mode-map "c" #'(lambda()(interactive)(dired c-directory))))
(and (setq e-directory (getenv "E_DIRECTORY")) (define-key dired-mode-map "e" #'(lambda()(interactive)(dired e-directory))))
;;                         ">" 'dired-next-dirline
;;                         "<" 'dired-previous-dirline
(setq dired-default-directory default-directory)

;; Auto revert files when they change
(global-auto-revert-mode t)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;;(setq auto-revert-interval 5) ;;default

(setq dired-mode-hook
      '(lambda ()
         ;;(dired-omit-mode 1)
         (setq truncate-lines 1)
         (local-set-key [right]   'ak-dired-find-file)          ;; -> f
         (local-set-key [left]    'ak-dired-up-directory)       ;; <- ^
         (local-set-key [home]    'ak-dired-beginning-of-buffer)
         (local-set-key [end]     'ak-dired-end-of-buffer)
         (local-set-key [prior]   'ak-dired-scroll-down)
         (local-set-key [next]    'ak-dired-scroll-up)
         (local-set-key [f5]      'revert-buffer)               ;; g
         ;; (local-set-key "\M-s" 'shell)                          ;;emacs23  override M-s prefix
         (local-set-key "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
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

(defun ak-dired-beginning-of-buffer(&optional arg)
  "in dired set cursor at first file"
  (interactive "^p")
  (if this-command-keys-shift-translated
      (move-beginning-of-line arg)
    ;(setq mark-active nil)
    (goto-char (point-min))
    (dired-next-line 4))
  )
(defun ak-dired-end-of-buffer(&optional arg)
  "in dired set cursor at last file"
  (interactive "^p")
  (if this-command-keys-shift-translated
      (move-end-of-line arg)
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
        (dired-next-line 4))
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

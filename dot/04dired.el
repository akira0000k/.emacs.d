


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
(define-key dired-mode-map "h" '(lambda()(interactive)(dired "~")))
(define-key dired-mode-map "r" '(lambda()(interactive)(dired "/")))
(define-key dired-mode-map "z" '(lambda()(interactive)(dired dired-default-directory)))
(and (setq a-directory (getenv "A_DIRECTORY")) (define-key dired-mode-map "a" '(lambda()(interactive)(dired a-directory))))
(and (setq b-directory (getenv "B_DIRECTORY")) (define-key dired-mode-map "b" '(lambda()(interactive)(dired b-directory))))
(and (setq c-directory (getenv "C_DIRECTORY")) (define-key dired-mode-map "c" '(lambda()(interactive)(dired c-directory))))
(and (setq e-directory (getenv "E_DIRECTORY")) (define-key dired-mode-map "e" '(lambda()(interactive)(dired e-directory))))
;;                         ">" 'dired-next-dirline
;;                         "<" 'dired-previous-dirline
(setq dired-default-directory default-directory)

;; Auto revert files when they change
(global-auto-revert-mode t)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

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
         (local-set-key "\M-s" 'shell)                          ;;emacs23  override M-s prefix
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
  (if (first-page-p)
      (progn
        (move-to-window-line 0)
        (dired-next-line 4))
    (scroll-down)
    (dired-previous-line 1))
  )
(defun ak-dired-scroll-up ()
  "Page down and set cursor at file"
  (interactive "^")
  (if (last-page-p)
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

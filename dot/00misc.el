;; ------ 00misc.el ------

;; Erase Menu bar
(menu-bar-mode -1)
;;(menu-bar-mode 1)
;;;; M-x tmm-menubar
;;;; ESC `

(display-time)
(line-number-mode t)
(column-number-mode t)
(setq kill-whole-line t)
(delete-selection-mode 1)
(setq dired-dnd-protocol-alist nil)

;;(setq visible-bell t)
(setq ring-bell-function 'ignore)

(setq default-input-method "japanese")
(setq split-width-threshold nil)
(setq use-dialog-box nil)

;;====================================
;;;; keybinding while Isearch.  ex. C-s C-w ..yank word
;;====================================
(define-key isearch-mode-map "\C-k" 'isearch-edit-string)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;;   frequently used
;;   C-k                isearch-edit-string       ex. C-s C-k
;;   M-e                isearch-edit-string
;;   C-r                isearch-repeat-backward   ex. C-s C-r
;;   C-s                isearch-repeat-forward    ex. C-s C-s
;;   C-w                isearch-yank-word-or-char ex. C-s C-w
;;
;;   toggle
;;   M-c                isearch-toggle-case-fold       ex. C-s M-c
;;   M-r                isearch-toggle-regexp          ex. C-s M-r
;;   M-s SPC            isearch-toggle-lax-whitespace  ex. C-s M-s SPC
;;   toggle default
(setq isearch-lax-whitespace nil)  ;;off
;;(setq isearch-lax-whitespace t)  ;;on (default)

;;   M-%                isearch-query-replace  ex. C-s aaa M-% bbb
(global-set-key (kbd "C-r") 'query-replace) ;; M-% aaa bbb

;; no cua-mode  cut/copy/paste=C-w C-S-w C-y
(global-set-key (kbd "C-S-w") 'kill-ring-save) ;; M-w
(global-set-key (kbd "C-x r W") 'copy-rectangle-as-kill)  ;; C-x r M-w

;; for MAC OSX
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

;; overwridden by cua-mode
;; no cua-mode  cut/paste=C-w C-v  copy/paste=M-w M-v
(global-set-key (kbd "M-v") 'yank) ;; C-y
(global-set-key (kbd "C-v") 'yank) ;; C-y
(global-set-key (kbd "C-z") 'undo) ;; C-x C-z  ^Z ..fg

;;                    M-f10       'toggle-frame-maximized
;;                    f11         'toggle-frame-fullscreen  ;; -> M-f11
;;                    C-x C-c     'save-buffers-kill-terminal
;;                    C-x C-z     'suspend-frame            ;; <- C-z
;;                    C-x 5 2     'make-frame-command

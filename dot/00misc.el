;; ------ 00misc.el ------ ;;; -*- lexical-binding: t; -*-

;; Erase Menu bar
(unless (display-graphic-p) (menu-bar-mode -1))
;;(menu-bar-mode 1) ;;default
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
;;;; 削除はゴミ箱にいれる
;;====================================
(setq delete-by-moving-to-trash t)

;;====================================
;;;; grep case insensitive
;;====================================
(setq grep-command "grep --color=auto -nH --null -i -e ")
;;(setq grep-command "grep --color=auto -nH -i -e ")

;;====================================
;;;; keybinding while Isearch.  ex. C-s C-w ..yank word
;;====================================
(keymap-set isearch-mode-map "C-k" 'isearch-edit-string)
(keymap-set isearch-mode-map "C-h" 'isearch-delete-char)
;; ;; incremental search 中に C-j を改行にマッチさせる。(default動作)
;; (keymap-set isearch-mode-map "C-j" 'isearch-printing-char) ;;default
;; isearch-edit-string と replace の minibuffer内で C-j を単純改行挿入にする
(keymap-set minibuffer-local-isearch-map "C-j" 'electric-indent-just-newline)
(when (fboundp 'defvar-keymap)
  (load (_emacs_d/ "site-lisp/replace-patch"))
  (keymap-set minibuffer-local-replace-map "C-j" 'electric-indent-just-newline)
  )
;;                                                  C-h を単純バックスペースにする
(keymap-set minibuffer-local-isearch-map "C-h" 'delete-backward-char)
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
;;   M-%                isearch-query-replace          ex. C-s aaa M-% bbb
;;   C-M-%              isearch-query-replace-regexp   ex. C-s ^aaa C-M-% bbb

;;   toggle default
(setq isearch-lax-whitespace nil)  ;;off
;;(setq isearch-lax-whitespace t)  ;;on (default)

(keymap-global-set "C-r" 'query-replace) ;; M-% aaa bbb
(keymap-global-set "C-M-r" 'query-replace-regexp) ;; C-M-% aaa bbb

;; Insert key .. toggle overwrite-mode
(keymap-global-set "M-o" 'overwrite-mode)

;; no cua-mode  cut/copy/paste=C-w C-S-w C-y
(keymap-global-set "C-S-w" 'kill-ring-save) ;; M-w
(keymap-global-set "C-x r W" 'copy-rectangle-as-kill)  ;; C-x r M-w

;; for MAC OSX
(keymap-global-set "C-h" 'backward-delete-char-untabify)
;;(keymap-global-set "C-h" 'delete-backward-char)


;; overwridden by cua-mode
;;;;  ;; no cua-mode  cut/paste=C-w C-v  copy/paste=M-w M-v
;;;;  (keymap-global-set "M-v" 'yank) ;; C-y
;;;;  (keymap-global-set "C-v" 'yank) ;; C-y
(keymap-global-set "C-z" 'undo) ;; C-x C-z  ^Z ..fg

;;                    C-x C-c     'save-buffers-kill-terminal
;;                    C-x C-z     'suspend-frame            ;; <- C-z

;; alternate keybind for pos<--ex-->mark (was C-x C-x)
(keymap-global-set "M-s M-j" 'exchange-point-and-mark)

;; like C-S-<backspace>
(keymap-global-set "C-S-<delete>" 'kill-whole-line)

;;====================================
;;;; kill region or kill line. (MAC OSX style)
;;====================================
(keymap-global-set "C-k" 'ak-kill-line)
;;  copy
(keymap-global-set "C-S-k" 'ak-copy-line)
;; kill active region or kill line
;; active region may have length 0
(defun ak-kill-line (&optional arg)
  (interactive "P")
  (if (region-active-p)
      (kill-region 0 0 t)
    (kill-line arg)))
(defun ak-copy-line (&optional arg)
  (interactive "P")
  (if (region-active-p)
      (kill-ring-save 0 0 t)
    (kill-line arg)
    (yank)))




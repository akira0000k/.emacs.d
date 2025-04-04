


;; ------ 03cua.el ------

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)   ;;defalt  region selected->C-x:cut C-c:copy
;(setq cua-enable-cua-keys nil)
(cua-mode t)

;; ;; <C-return>  start cua set rectangle mark
;; (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; Alternate keybind of cua-rect for org-mode. 
(global-set-key (kbd "C-c C-SPC") 'cua-set-rectangle-mark)

;; C-x SPC     start emacs24 rectangle mark mode

;; s-j  (command-j)  cua-exchange-point-and-mark
;; 上から選択したか、下から選択したかを切り替え。
;; 矩形選択時は、文字挿入が矩形の前/後に変わる。

;;====================================
;;;; Page Down/Page Up  =  M-v M-u
;;====================================
(if (boundp 'cua--cua-keys-keymap)
    (progn
      (define-key cua--cua-keys-keymap (kbd "M-v") 'ak-cua-scroll-up)
      (define-key cua--cua-keys-keymap (kbd "M-V") 'cua-scroll-down)
      ;;(define-key cua--cua-keys-keymap (kbd "M-u") 'cua-scroll-down) ;;was upcase-word
      ))
(defun ak-cua-scroll-up (&optional arg)
  (interactive "^P")
  (cua-scroll-up arg)
  (forward-line 1))

;;;; org-mode 
;; see org-mode-hook

(defun cua-set-rectangle-mark2 (&optional reopen)
  "Set mark and start in CUA rectangle mode.
With prefix argument, activate previous rectangle if possible."
  (interactive "P")
  (if (string= major-mode "org-mode")
      (org-insert-heading-respect-content)
    ;; else
    (cua-set-rectangle-mark reopen)))

(if (boundp 'cua-global-keymap)
    (define-key cua-global-keymap (kbd "C-<return>") 'cua-set-rectangle-mark2))

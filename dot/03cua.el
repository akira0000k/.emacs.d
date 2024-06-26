


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

;; cut/paste=C-w C-v  copy/paste=M-w M-v   possible
(if (boundp 'cua--cua-keys-keymap)
    (define-key cua--cua-keys-keymap (kbd "M-v") 'yank))
;;was     M-v runs the command delete-selection-repeat-replace-region


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

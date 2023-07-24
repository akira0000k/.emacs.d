


;; ------ 03cua.el ------

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)   ;;defalt  region selected->C-x:cut C-c:copy
;(setq cua-enable-cua-keys nil)
(cua-mode t)

;; ;; <C-return>  start cua set rectangle mark
;; (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)
;; shift select mode
;; C-x SPC     start emacs24 rectangle mark mode

;; cut/paste=C-w C-v  copy/paste=M-w M-v   possible
(if (boundp 'cua--cua-keys-keymap)
    (define-key cua--cua-keys-keymap (kbd "M-v") 'yank))
;;was     M-v runs the command delete-selection-repeat-replace-region


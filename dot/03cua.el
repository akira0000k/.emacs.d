


;; ------ 03cua.el ------

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)
;(setq cua-enable-cua-keys nil)
(cua-mode t)

;; ;; <C-return>  start cua set rectangle mark
;; (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)
;; shift select mode
;; C-x SPC     start emacs24 rectangle mark mode

;;;;(global-set-key (kbd "C-v") 'yank) ;; C-y
(global-set-key (kbd "C-z") 'undo) ;; C-x C-z  ^Z ..fg

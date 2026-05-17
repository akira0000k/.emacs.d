


;; ------ 03cua.el ------

;;;; Toggle hilighting area after mark(C-SPC) + move(<left>)
;;(transient-mark-mode 'toggle) ;; nil)* -1)

;;;; start shift-selection set mark. cancel(C-g)
;;(setq shift-select-mode 'permanent) ;; t)* nil)

;;;; toggle deleting select area with C-d, or overwriting.
;;(delete-selection-mode 'toggle) ;; nil) -1)*

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)   ;;defalt  region selected->C-x:cut C-c:copy
(cua-mode t)

;; <C-return>  start cua set rectangle mark
;; C-c C-SPC   start cua set rectangle mark

;; C-x SPC     start emacs24 rectangle mark mode

;; s-j  (command-j)  cua-exchange-point-and-mark
;; 上から選択したか、下から選択したかを切り替え。
;; 矩形選択時は、文字挿入が矩形の前/後に変わる。

(when (boundp 'cua-global-keymap)
  ;; Alternate keybind of cua-rect for org-mode. 
  (keymap-set cua-global-keymap "C-c C-SPC" 'cua-set-rectangle-mark)
  (keymap-set cua-global-keymap "C-<return>" 'cua-set-rectangle-mark2)
  (defun cua-set-rectangle-mark2 (&optional reopen)
    "Set mark and start in CUA rectangle mode.
With prefix argument, activate previous rectangle if possible."
    (interactive "P")
    (if (string= major-mode "org-mode")
	(org-insert-heading-respect-content)
      ;; else
      (cua-set-rectangle-mark reopen)))
  )

(when (boundp 'cua--cua-keys-keymap)
  ;; Page Down/Page Up  =  M-v M-u
  (keymap-set cua--cua-keys-keymap "M-v" 'ak-cua-scroll-up) ;;was delete-selection-repeat-replace-region.
  (keymap-set cua--cua-keys-keymap "M-V" 'cua-scroll-down)
  ;;(keymap-set cua--cua-keys-keymap "M-u" 'cua-scroll-down) ;;was upcase-word
  (defun ak-cua-scroll-up (&optional arg)
    (interactive "^P")
    (cua-scroll-up arg)
    (forward-line 1))
  )

;; cua-mode の on/off をするなら、キーバインド設定後にoffにする。
;;(cua-mode 'toggle) ;; nil)* -1)
;;(cua-mode -1)

;;  X C V initial choice here.
;; t    : default  region selected->C-x:cut C-c:copy, C-v:paste
;; nil  : thankyou       use legacy C-w:cut M-w:copy, C-y:paste
;;'shift: bug?
;;(setq cua-enable-cua-keys 'shift) ;; t)* nil)
;;(setq cua-enable-cua-keys nil)

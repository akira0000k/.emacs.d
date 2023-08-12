


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


;;;; org-mode 
;; org-mode-hook desables cua-mode
;; C-<return> (global-map)        will enable  cua-mode in non org-mode
;; C-<return> (cua-global-keymap) will desable cua-mode in org-mode

(defun cua-set-rectangle-mark2 (&optional reopen)
  "Set mark and start in CUA rectangle mode.
With prefix argument, activate previous rectangle if possible."
  (interactive "P")
  (if (and(not ak-cua-org-p)(string= major-mode "org-mode"))
      (progn
	(message "cua-mode disabled")
	(cua-mode -1))
    ;; else
    (cua-set-rectangle-mark)))
(if (boundp 'cua-global-keymap)
    (define-key cua-global-keymap (kbd "C-<return>") 'cua-set-rectangle-mark2))

(defun ak-c-return ()
  "Enables cua-mode again."
  (interactive)
  (setq ak-cua-org-p nil)  
  (setq cua-enable-cua-keys t)
  (cua-mode t)
  (define-key cua-global-keymap (kbd "C-<return>") 'cua-set-rectangle-mark2)
  (message "cua-mode enabled"))
(global-set-key (kbd "C-<return>") 'ak-c-return)

;;
;; use rectangle in org-mode
;;
(defvar ak-cua-org-p nil)

(defun cua-rect ()
  "Enable to use cua-rectangle.  Without C-x cut."
  (interactive)
  (if (default-value 'cua-mode)
      (progn  (setq ak-cua-org-p nil)
	      (cua-mode -1)
	      (message "cua rectangle desabled"))
    ;;else
    (setq ak-cua-org-p t)
    (setq cua-enable-cua-keys nil)
    (cua-mode t)
    (message "cua rectangle enabled")
  ))

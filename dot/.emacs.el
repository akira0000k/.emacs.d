;;;; comment out with ;; if some function not necessary.
;;;; like
;;;; ;;(load "~/.emacs.d/dot/03cua.el")
;;;;
(load "~/.emacs.d/dot/00misc.el")
(load "~/.emacs.d/dot/01keys.el")
(load "~/.emacs.d/dot/02cursor.el")
(load "~/.emacs.d/dot/03cua.el")
(load "~/.emacs.d/dot/04dired.el")
(load "~/.emacs.d/dot/05like.el")
(load "~/.emacs.d/dot/06shell.el")
(load "~/.emacs.d/dot/07buffer.el")
(load "~/.emacs.d/dot/08mode.el")
(load "~/.emacs.d/dot/09org.el")



;; -------------------------

;;====================================
;;  common functions
;;====================================

(defun ak-first-page-p ()
  (if (= (point-min) (window-start))
          t
        nil))
(defun ak-last-page-p ()
  (if (= (point-max) (window-end))
          t
        nil))

(defun ak-prev-window ()
  (interactive)
  (other-window -1))
(defun ak-prev-frame ()
  (interactive)
  (other-frame -1))

;;====================================
;;  auto revert setting dired/buffer
;;====================================

;; Auto revert files when they change
(global-auto-revert-mode t) ;; comment this line if you dont need.
 
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t) ;;default: nil
(setq auto-revert-verbose nil) ;;default: t
(setq auto-revert-interval 5) ;;default: 5

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

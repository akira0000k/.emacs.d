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
;; query position
(defun ak-first-page-p ()
  (if (= (point-min) (window-start))
          t
        nil))
(defun ak-last-page-p ()
  (if (= (point-max) (window-end))
          t
        nil))

;; reverse window move
(defun ak-prev-window ()
  (interactive) (other-window -1))
(defun ak-prev-frame ()
  (interactive) (other-frame -1))

;; Line scroll
(defun ak-line-up() (interactive "^")
  (or (ak-first-page-p)(scroll-down 1))
  (forward-line -1))
(defun ak-line-down() (interactive "^")
  (scroll-up   1)
  (forward-line  1))
(defun ak-line-up-fast() (interactive "^")
  (or (ak-first-page-p)(scroll-down 4))
  (forward-line -4))
(defun ak-line-down-fast() (interactive "^")
  (scroll-up   4)
  (forward-line  4))

;; Home Toggle like Visual Studio
(defun ak-home-toggle ()
  "go and back between beginning of line and first char."
  (interactive "^")
  (if (not (bolp))
      (beginning-of-line)
    (beginning-of-line)
    (while (and (not (eolp))
                    (or (= (following-char) ?\t)
                        (= (following-char) ?\ )))
      (forward-char))
    (if (eolp)
        (beginning-of-line)))
  )

;; H M L of vi
(defun ak-goto-top-screen () "goto cursor top of screen"
  (interactive "^") (move-to-window-line 0))
(defun ak-goto-mid-screen () "goto cursor mid of screen"
  (interactive "^") (move-to-window-line nil))
(defun ak-goto-bottom-screen () "goto cursor bottom of screen"
  (interactive "^") (move-to-window-line -1))

;; scroll half screen でらうま倶楽部
(defun half-page-down()
  "カーソルは画面内固定で半画面 scroll-down。"
  (interactive "^")
  (if(= (window-start) 1)
      (progn
        (beginning-of-line)
        (forward-line (/ (window-body-height) -2))
        )
    (let ( (a (current-line)) )
      (scroll-down (/ (window-body-height) 2))
      (move-to-window-line a)
      )))
(defun half-page-up()
  "カーソルは画面内固定で半画面 scroll-up。"
  (interactive "^")
  (if(= (window-end) (point-max))
      (forward-line (/ (window-body-height) 2))
    (let ( (a (current-line)) )
      (if(< a 1) (setq a 1))
      (scroll-up (/ (window-body-height) 2))
      (move-to-window-line a)
      )))
(defun current-line()
  "Return the vertical position of point..."
  (cdr (nth 6 (posn-at-point))))

;; basic scroll-down
(defun ak-scroll-page-backward ()
  "scroll down = Page Up"
  (interactive "^")
  (if (= (point-min) (point))
      (message "Beginning of buffer.")
    (if (ak-first-page-p)
        (goto-char (point-min))
      (scroll-down )
      )
    )
  )
;; basic scroll-up
(defun ak-scroll-page-forward ()
  "scroll up = Page Down"
  (interactive "^")
  (if (= (point-max) (point))
      (message "End of buffer.")
    ;;else
    (if (ak-last-page-p)
        (goto-char (point-max))
      ;;else
      (scroll-up )
      (forward-line 1)
      )
    )
  )

;;====================================
;;  auto revert setting dired/buffer
;;====================================

;; Auto revert files when they change
(global-auto-revert-mode t) ;; comment this line if you dont need.
 
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t) ;;default: nil
(setq auto-revert-verbose nil) ;;default: t
(setq auto-revert-interval 5) ;;default: 5

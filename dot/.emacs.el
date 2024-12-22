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
  "other-window -1"
  (interactive) (other-window -1))
(defun ak-prev-frame ()
  "other-frame -1"
  (interactive) (other-frame -1))

;; Line scroll
(defun ak-scroll-down1() (interactive) (scroll-down 1))
(defun ak-scroll-down2() (interactive) (scroll-down 2))
(defun ak-scroll-up1() (interactive) (scroll-up 1))
(defun ak-scroll-up2() (interactive) (scroll-up 2))

(defcustom ak-fast-scroll-lines 4
  "Number of lines when scroll up/down was boosted."
  :type 'integer
  :group 'display)
(defun ak-line-up()
  "1 line scroll down, keeping cursor position."
  (interactive "^")
  (if (equal (current-window-line) 0)
      (progn
	(or (ak-first-page-p)(scroll-down 1))
	(call-interactively 'previous-line))
    ;;else
    (call-interactively 'previous-line)
    (or (ak-first-page-p)(scroll-down 1))
    ))
(defun ak-line-down()
  "1 line scroll up, keeping cursor position."
  (interactive "^")
  (if (equal (current-window-line) 0)
      (progn
	(call-interactively 'next-line)
	;;(scroll-up   1)
	)
    ;;else
    (scroll-up   1)
    (call-interactively 'next-line)
    ))
(defun ak-line-up-fast()
  "Boosted line scroll down. customize \\='ak-fast-scroll-lines'"
  (interactive "^")
  (let ( (line0 (current-window-line)) )
    (if (ak-first-page-p)
	(forward-line (- ak-fast-scroll-lines))
      (scroll-down ak-fast-scroll-lines)
      (move-to-window-line line0)
      )))
(defun ak-line-down-fast()
  "Boosted line scroll up. customize \\='ak-fast-scroll-lines'"
  (interactive "^")
  (let ( (line0 (current-window-line))
	 (wst (window-start))
	 (mov ak-fast-scroll-lines) )
    (when (equal line0 0)
      (setq line0 (1+ line0))
      (setq mov (1- mov)))
    (ignore-errors (scroll-up mov))
    (if (equal wst (window-start))
	(goto-char (point-max))
      (move-to-window-line line0))
    ))

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
    (let ( (a (current-window-line)) )
      (scroll-down (/ (window-body-height) 2))
      (move-to-window-line a)
      )))
(defun half-page-up()
  "カーソルは画面内固定で半画面 scroll-up。"
  (interactive "^")
  (if(= (window-end) (point-max))
      (forward-line (/ (window-body-height) 2))
    (let ( (a (current-window-line)) )
      (if(< a 1) (setq a 1))
      (scroll-up (/ (window-body-height) 2))
      (move-to-window-line a)
      )))
(defun current-window-line()
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

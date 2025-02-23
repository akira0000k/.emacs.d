


;; ------ 02cursor.el ------

;;====================================
;;;; control keys
;;====================================

;;              [C-up]                    ;; Start Mission Control @ MAC OSX
;;              [C-down]                  ;; Application Window (Mission Control @ MAC OSX)
(global-set-key [C-up]   'ak-line-up)
(global-set-key [C-down] 'ak-line-down)
(global-set-key [s-up]   'ak-line-up-fast)
(global-set-key [s-down] 'ak-line-down-fast)
(global-set-key (kbd "C-M-p") 'ak-line-up)       ;;was backward-list
(global-set-key (kbd "C-M-n") 'ak-line-down)     ;;was forward-list
(global-set-key (kbd "C-s-p") 'ak-line-up-fast)
(global-set-key (kbd "C-s-n") 'ak-line-down-fast)
(global-set-key [C-M-prior] 'backward-list)
(global-set-key [C-M-next]  'forward-list)
(global-set-key (kbd "ESC C-<prior>") 'backward-list)
(global-set-key (kbd "ESC C-<next>")  'forward-list)


(global-set-key (kbd "<wheel-up>")   'ak-scroll-down2)
(global-set-key (kbd "<wheel-down>") 'ak-scroll-up2)
(global-set-key (kbd "C-<wheel-up>")   'ak-line-up-fast)
(global-set-key (kbd "C-<wheel-down>") 'ak-line-down-fast)


;;;; iTerm2 use move tab function by C-tab
;;(global-set-key [C-tab] 'other-window)
;;(global-set-key [C-S-tab] 'ak-prev-window)
(global-set-key [C-tab] 'next-window-any-frame)
(global-set-key [C-S-tab] 'previous-window-any-frame)

;; Control-Comma,   go to filetop
;; Control-Period.  go to fileend
(global-set-key (kbd "C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'end-of-buffer)
;; Shift-Control-Comma,   select to filetop
;; Shift-Control-Period.  select to fileend
(define-key key-translation-map (kbd "C-<") (kbd "C-S-,"))
(define-key key-translation-map (kbd "C->") (kbd "C-S-."))


;; ;; MAC OSX option key + up down left right
;; ;;;; [M-right]   ;; previous word
;; ;;;; [M-left]    ;; next word
;; (global-set-key (kbd "<M-down>") #'(lambda()(interactive "^")
;;                             (if (eolp) (forward-line))
;;                             (end-of-line)))
;; (global-set-key (kbd "<M-up>")   #'(lambda()(interactive "^")
;;                             (if (bolp) (forward-line -1))
;;                             (beginning-of-line)))

;; scroll other window
;;   'beginning-of-buffer-other-window  M-<home>
;;   'end-of-buffer-other-window        M-<end>
;;   'scroll-other-window-down  M-<prior>
;;   'scroll-other-window       M-<next>
(global-set-key (kbd "M-<down>")     'ak-scroll-other-window1)
(global-set-key (kbd "ESC <down>")   'ak-scroll-other-window1)
(global-set-key (kbd "M-<up>")       'ak-scroll-other-window-1)
(global-set-key (kbd "ESC <up>")     'ak-scroll-other-window-1)
(global-set-key (kbd "M-S-<down>")   'ak-scroll-other-windowN)
(global-set-key (kbd "ESC S-<down>") 'ak-scroll-other-windowN)
(global-set-key (kbd "M-S-<up>")     'ak-scroll-other-window-N)
(global-set-key (kbd "ESC S-<up>")   'ak-scroll-other-window-N)
(defun ak-scroll-other-window1()
  "1 line scroll other window."
  (interactive)(scroll-other-window  1))
(defun ak-scroll-other-window-1()
  "1 line reverse scroll other window."
  (interactive)(scroll-other-window -1))
(defun ak-scroll-other-windowN()
  "Boosted line scroll other window. customize \\='ak-fast-scroll-lines'"
  (interactive)(scroll-other-window  ak-fast-scroll-lines))
(defun ak-scroll-other-window-N()
  "Boosted line reverse scroll other window. customize \\='ak-fast-scroll-lines'"
  (interactive)(scroll-other-window (- ak-fast-scroll-lines)))

;;====================================
;;;; go to top or end by page down/up
;;====================================
(global-set-key (kbd "<next>")  'ak-scroll-up)   ;;PageDown
(global-set-key (kbd "<prior>") 'ak-scroll-down) ;;PageUp
(defun ak-scroll-down ()
  "scroll down = Page Up"
  (interactive "^")
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (ak-first-page-p)
        (goto-char (point-min))
      (if (not this-command-keys-shift-translated)
          (scroll-down )
        ;;else
        (if (= (window-start) (point))
            (scroll-down ))
        
        (goto-char (window-start))
        )
      )
    )
  )
(defun ak-scroll-up ()
  "scroll up = Page Down"
  (interactive "^")
  (if (= (point-max) (point))
      (message "End of buffer@")
    ;;else
    (if (ak-last-page-p)
        (goto-char (point-max))
      ;;else
      (if (not this-command-keys-shift-translated)
	  (progn (scroll-up )
		 (forward-line 1))
        ;;else
        (let ((po (point)))
          (move-to-window-line -1)      ;move cursor to window end
          (if (= po (point))            ;cursor really moved?
              (progn
                (scroll-up )        ;try again
                (move-to-window-line -1)
		))
          )
        )
      )
    )
  )


;;====================================
;;;; goto top, mid, bottom
;;====================================
(global-set-key (kbd "s-<left>")  'ak-cursor-top)
(global-set-key (kbd "s-<right>") 'ak-cursor-bottom)
(global-set-key (kbd "M-<left>")  'ak-cursor-top)
(global-set-key (kbd "M-<right>") 'ak-cursor-bottom)
(defun ak-cursor-top ()
  "move cursor to middle or top of screen or scroll down(Page Up)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-window-line))
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (= (window-start) (point))
        (progn
          (message "scroll down")
          (scroll-down)
          )
      (let ( (pos0 (current-window-line)) )
        (move-to-window-line nil)
        (if (>= (current-window-line) pos0)
            (move-to-window-line 0)
          )
        )
      )
    )
  )
(defun ak-cursor-bottom ()
  "move cursor to middle or bottom of screen or scroll up(Page Down)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-window-line))
  (if (= (point-max) (point))
      (message "End of buffer@")
    (let ( (pos0 (current-window-line)) )
      (move-to-window-line nil)
      (if (> (current-window-line) pos0)
          nil ;; ok
        (move-to-window-line -1)
        (if (> (current-window-line) pos0)
            nil ;; ok
          (message "scroll up")
          (scroll-up)
          )
        )
      )
    )
  )
;;====================================
;;;; scroll half screen でらうま倶楽部
;;====================================
(global-set-key (kbd "M-p") 'half-page-down)
(global-set-key (kbd "M-n") 'half-page-up)
;; overwridden by cua mode
(global-set-key (kbd "C-v") 'half-page-up)
(global-set-key (kbd "M-v") 'half-page-down)

;;====================================
;;;; Home Toggle like Visual Studio
;;====================================
(global-set-key (kbd "C-a") 'ak-home-toggle)

;;====================================
;;;; begining/end of buffer/line(shift)
;;====================================
(global-set-key [C-home]  'beginning-of-buffer)
(global-set-key [C-end]   'end-of-buffer)
(global-set-key [home]  'ak-beginning-of-buffer)
(global-set-key [end]   'ak-end-of-buffer)
(defun ak-beginning-of-buffer()
  "Set cursor at beginning of buffer.(unshift)
Set cursor at beginning of 1line/2buffer.(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (let ((stp (point)))
	(beginning-of-line)
	(if (= stp (point))
	    (call-interactively 'beginning-of-buffer)))
    (call-interactively 'beginning-of-buffer)))
(defun ak-end-of-buffer()
  "Set cursor at end of buffer.(unshift)
Set cursor at end of 1line/2buffer.(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (let ((stp (point)))
	(end-of-line)
	(if (= stp (point))
	    (call-interactively 'end-of-buffer)))
    (call-interactively 'end-of-buffer)))

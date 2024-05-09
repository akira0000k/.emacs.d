


;; ------ 02cursor.el ------

;;====================================
;;;; control keys
;;====================================

;;              [C-up]                    ;; Start Mission Control @ MAC OSX
;;              [C-down]                  ;; Application Window (Mission Control @ MAC OSX)
;; (global-set-key [C-down] #'(lambda()(interactive)(scroll-up 1)))
;; (global-set-key [C-up]   #'(lambda()(interactive)(scroll-down 1)))
;; (global-set-key [C-S-down] #'(lambda()(interactive)(scroll-up 4)))
;; (global-set-key [C-S-up]   #'(lambda()(interactive)(scroll-down 4)))
(global-set-key [C-up]     #'(lambda()(interactive)(scroll-down 1)(previous-line 1)))
(global-set-key [C-down]   #'(lambda()(interactive)(scroll-up   1)(next-line     1)))
(global-set-key [C-S-up]   #'(lambda()(interactive)(scroll-down 4)(previous-line 4)))
(global-set-key [C-S-down] #'(lambda()(interactive)(scroll-up   4)(next-line     4)))
(global-set-key (kbd "<wheel-up>")  #'(lambda()(interactive)(scroll-down 2)))
(global-set-key (kbd "<wheel-down>")  #'(lambda()(interactive)(scroll-up 2)))


;;;; iTerm2 use move tab function by C-tab
(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-tab] #'(lambda()(interactive)(other-window -1)))

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
;; (global-set-key (kbd "<M-down>") '(lambda()(interactive "^")
;;                             (if (eolp) (next-line))
;;                             (end-of-line)))
;; (global-set-key (kbd "<M-up>")   '(lambda()(interactive "^")
;;                             (if (bolp) (previous-line))
;;                             (beginning-of-line)))

;; scroll other window 2 line
(global-set-key (kbd "M-<down>")   #'(lambda()(interactive)(scroll-other-window  1)))
(global-set-key (kbd "ESC <down>") #'(lambda()(interactive)(scroll-other-window  1)))
(global-set-key (kbd "M-<up>")     #'(lambda()(interactive)(scroll-other-window -1)))
(global-set-key (kbd "ESC <up>")   #'(lambda()(interactive)(scroll-other-window -1)))
(global-set-key (kbd "M-S-<down>")   #'(lambda()(interactive)(scroll-other-window  4)))
(global-set-key (kbd "ESC S-<down>") #'(lambda()(interactive)(scroll-other-window  4)))
(global-set-key (kbd "M-S-<up>")     #'(lambda()(interactive)(scroll-other-window -4)))
(global-set-key (kbd "ESC S-<up>")   #'(lambda()(interactive)(scroll-other-window -4)))
(global-set-key (kbd "M-s-<up>")     'beginning-of-buffer-other-window)  ;;like M-home
(global-set-key (kbd "ESC s-<up>")   'beginning-of-buffer-other-window)  ;;like M-home
(global-set-key (kbd "M-s-<down>")   'end-of-buffer-other-window)        ;;like M-end
(global-set-key (kbd "ESC s-<down>") 'end-of-buffer-other-window)        ;;like M-end
;;   'scroll-other-window-down  M-<prior>
;;   'scroll-other-window       M-<next>

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
    (if (first-page-p)
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
    (if (last-page-p)
        (goto-char (point-max))
      ;;else
      (if (not this-command-keys-shift-translated)
          (scroll-up )
        ;;else
        (let ((po (point)))
          (move-to-window-line -1)      ;move cursor to window end
          (end-of-line)
          (if (= po (point))            ;cursor really moved?
              (progn
                (scroll-up )        ;try again
                (move-to-window-line -1)
                (end-of-line)))
          )
        )
      )
    )
  )
(defun first-page-p ()
  (if (= (point-min) (window-start))
          t
        nil))
(defun last-page-p ()
  (if (= (point-max) (window-end))
          t
        nil))


;;====================================
;;;; goto top, mid, bottom
;;====================================
;; (global-set-key (kbd "s-t") 'ak-goto-top-screen)
;; (global-set-key (kbd "s-m") 'ak-goto-mid-screen)
;; (global-set-key (kbd "s-b") 'ak-goto-bottom-screen)
;; (defun ak-goto-top-screen ()
;;   "goto cursor top of screen"
;;   (interactive "^")
;;   ;;(goto-char (window-start))
;;   (move-to-window-line 0)
;;   )
;; (defun ak-goto-mid-screen ()
;;   "goto cursor mid of screen"
;;   (interactive "^")
;;   (move-to-window-line nil)
;;   )
;; (defun ak-goto-bottom-screen ()
;;   "goto cursor bottom of screen"
;;   (interactive "^")
;;   (move-to-window-line -1)
;;   )

(global-set-key (kbd "s-<prior>") 'ak-cursor-top)
(global-set-key (kbd "s-<next>")  'ak-cursor-bottom)
(global-set-key (kbd "M-<left>")  'ak-cursor-top)
(global-set-key (kbd "M-<right>") 'ak-cursor-bottom)
(defun ak-cursor-top ()
  "move cursor to middle or top of screen or scroll down(Page Up)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-line))
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (= (window-start) (point))
        (progn
          (scroll-down (- (window-body-height) 1))
          (message "scroll down")
          )
      (let ( (pos0 (current-line)) )
        (move-to-window-line nil)
        (if (>= (current-line) pos0)
            (move-to-window-line 0)
          )
        )
      )
    )
  )
(defun ak-cursor-bottom ()
  "move cursor to middle or bottom of screen or scroll up(Page Down)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-line))
  (if (= (point-max) (point))
      (message "End of buffer@")
    (let ( (pos0 (current-line)) )
      (move-to-window-line nil)
      (if (> (current-line) pos0)
          nil ;; ok
        (move-to-window-line -1)
        (if (> (current-line) pos0)
            nil ;; ok
          (scroll-up (- (window-body-height) 1))
          (message "scroll up")
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

;;====================================
;;;; Home Toggle like Visual Studio
;;====================================
(global-set-key [C-home]  'beginning-of-buffer)
(global-set-key [C-end]   'end-of-buffer)
;;;;  (global-set-key [home]  'home-toggle)
;;;;  (global-set-key [end]   'move-end-of-line)  ;; MAC OSX .. default=end of buffer
(global-set-key (kbd "C-a") 'home-toggle)
(global-set-key (kbd "s-<left>") 'home-toggle)
(defun home-toggle ()
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

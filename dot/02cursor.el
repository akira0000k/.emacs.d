


;; ------ 02cursor.el ------

;;====================================
;;;; control keys
;;====================================

;;                 "C-<up>"	  ;; Start Mission Control @ MAC OSX
;;		   "C-<down>"	  ;; Application Window (Mission Control @ MAC OSX)
(keymap-global-set "C-<up>"   'ak-scroll-down1)   ;;was backward-paragraph
(keymap-global-set "C-<down>" 'ak-scroll-up1)     ;;was forward-paragraph
(keymap-global-set "C-S-<up>"   'ak-scroll-down2)
(keymap-global-set "C-S-<down>" 'ak-scroll-up2)
(keymap-global-set "C-M-p" 'ak-line-up)       ;;was backward-list
(keymap-global-set "C-M-n" 'ak-line-down)     ;;was forward-list
(keymap-global-set "C-s-p" 'ak-line-up-fast)
(keymap-global-set "C-s-n" 'ak-line-down-fast)
(keymap-global-set "C-M-<prior>" 'backward-list)
(keymap-global-set "C-M-<next>"  'forward-list)
(keymap-global-set "ESC C-<prior>" 'backward-list)
(keymap-global-set "ESC C-<next>"  'forward-list)


(keymap-global-set "<wheel-up>"   'ak-scroll-down2)
(keymap-global-set "<wheel-down>" 'ak-scroll-up2)
(keymap-global-set "C-<wheel-up>"   'ak-line-up-fast)
(keymap-global-set "C-<wheel-down>" 'ak-line-down-fast)


;;;; iTerm2 use move tab function by C-<tab>
;;(keymap-global-set "C-<tab>" 'other-window)
;;(keymap-global-set "C-S-<tab>" 'ak-prev-window)
(keymap-global-set "C-<tab>" 'next-window-any-frame)
(keymap-global-set "C-S-<tab>" 'previous-window-any-frame)

;; Control-Comma,   go to filetop
;; Control-Period.  go to fileend
(keymap-global-set "C-," 'beginning-of-buffer)
(keymap-global-set "C-." 'end-of-buffer)
;; Shift-Control-Comma,   select to filetop
;; Shift-Control-Period.  select to fileend
(keymap-set key-translation-map "C-<" "C-S-,")
(keymap-set key-translation-map "C->" "C-S-.")
;; Shift-Control-^,       select to previous page
(keymap-set key-translation-map "C-~" "C-S-^")


;; ;; MAC OSX option key + up down left right
;; ;;;; "M-<right>"   ;; previous word
;; ;;;; "M-<left>"    ;; next word
;; (keymap-global-set "M-<down>" #'(lambda()(interactive "^")
;;                             (if (eolp) (forward-line))
;;                             (end-of-line)))
;; (keymap-global-set "M-<up>"   #'(lambda()(interactive "^")
;;                             (if (bolp) (forward-line -1))
;;                             (beginning-of-line)))

;; scroll other window
;;     M-<home>  'beginning-of-buffer-other-window
;;     M-<end>   'end-of-buffer-other-window      
;;     M-<prior> 'scroll-other-window-down
;;     M-<next>  'scroll-other-window     
(keymap-global-set "M-<down>"     'ak-scroll-other-window1)
(keymap-global-set "ESC <down>"   'ak-scroll-other-window1)
(keymap-global-set "M-<up>"       'ak-scroll-other-window-1)
(keymap-global-set "ESC <up>"     'ak-scroll-other-window-1)
(keymap-global-set "M-S-<down>"   'ak-scroll-other-windowN)
(keymap-global-set "ESC S-<down>" 'ak-scroll-other-windowN)
(keymap-global-set "M-S-<up>"     'ak-scroll-other-window-N)
(keymap-global-set "ESC S-<up>"   'ak-scroll-other-window-N)
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
;;;; Page Down/Up. Shift select cover page first.
;;====================================
(keymap-global-set "<next>"  'ak-scroll-up)   ;;PageDown
(keymap-global-set "<prior>" 'ak-scroll-down) ;;PageUp
(defun ak-scroll-down ()
  "scroll down = Page Up"
  (interactive "^")
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (ak-first-page-p)
        (goto-char (point-min))
      (if (not this-command-keys-shift-translated)
          (scroll-down)
        ;;else
        (if (= (window-start) (point))
            (scroll-down))
        (goto-char (window-start)))
      )))
(defun ak-scroll-up ()
  "scroll up = Page Down"
  (interactive "^")
  (if (= (point-max) (point))
      (message "End of buffer@")
    ;;else
    (if (ak-last-page-p)
        (goto-char (point-max))
      ;;else
      (if this-command-keys-shift-translated
          (let ((po (point)))
            (move-to-window-line -1)      ;move cursor to window end
            (when (= po (point))          ;cursor didnot move
              (scroll-up)                 ;try again
              (move-to-window-line -1)
	      ))
        ;;else
	(scroll-up)
	(forward-line 1))
      )))


;;====================================
;;;; goto top, mid, bottom
;;====================================
;; (keymap-global-set "s-<left>"  'ak-cursor-top)
;; (keymap-global-set "s-<right>" 'ak-cursor-bottom)
(keymap-global-set "M-<left>"  'ak-cursor-top)
(keymap-global-set "M-<right>" 'ak-cursor-bottom)
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
        (move-to-window-line nil) ;; try to move center
        (if (>= (current-window-line) pos0)
            (move-to-window-line 0))) ;; move to first line
      )))
(defun ak-cursor-bottom ()
  "move cursor to middle or bottom of screen or scroll up(Page Down)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-window-line))
  (if (= (point-max) (point))
      (message "End of buffer@")
    (let ( (pos0 (current-window-line)) )
      (move-to-window-line nil) ;; try to move center
      (if (> (current-window-line) pos0)
          nil ;; ok
        (move-to-window-line -1) ;; try to move bottom
        (if (> (current-window-line) pos0)
            nil ;; ok
          (message "scroll up")
          (scroll-up))
        ))))
;;====================================
;;;; scroll half screen でらうま倶楽部
;;====================================
(keymap-global-set "M-p" 'half-page-down)
(keymap-global-set "M-n" 'half-page-up)
;; overwridden by cua mode
(keymap-global-set "C-v" 'half-page-up)
(keymap-global-set "M-v" 'half-page-down)
(keymap-global-set "C-^" 'half-page-down)

;;====================================
;;;; Home Toggle like Visual Studio
;;====================================
(keymap-global-set "C-a" 'ak-home-toggle)

;;====================================
;;;; begining/end of buffer/line(shift)
;;====================================
(keymap-global-set "C-<home>"  'beginning-of-buffer)
(keymap-global-set "C-<end>"   'end-of-buffer)
(keymap-global-set "<home>"  'ak-beginning-of-buffer)
(keymap-global-set "<end>"   'ak-end-of-buffer)
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

;;====================================
;; customize left-right scroll 
;;====================================
(defcustom ak-lr-scroll-chars 20
  "Number of characters for scroll right/left (S-f11/S-f12)."
  :type 'integer
  :group 'display)
(defvar ak-lr-default nil)
(defvar ak-lr nil)
(defun ak-set-scroll-value(arg)
  (unless ak-lr-default (setq ak-lr-default ak-lr-scroll-chars))
  (unless ak-lr (setq ak-lr ak-lr-scroll-chars))
  (when (/= ak-lr-default ak-lr-scroll-chars) ;;defcustom value changed
    (setq ak-lr-default ak-lr-scroll-chars)
    (setq ak-lr ak-lr-scroll-chars))
  (cond ((not arg)) ;; "arg is nil"
	((or (listp arg)(= arg 0)) ;; arg is list "C-u S-<f11>" or 0 "C-u 0 S-<f11>"
	 (setq ak-lr ak-lr-scroll-chars))
	(t (setq ak-lr arg)) ;;"arg is value"
	))
(defun ak-scroll-right(&optional arg)
  "Scroll-right (move left) ak-lr-scroll-chars coloms."
  (interactive "P")
  (ak-set-scroll-value arg)
  ;;(message "<== %s %s" arg ak-lr)
  (scroll-right ak-lr)
  )
(defun ak-scroll-left(&optional arg)
  "Scroll-left (move right) ak-lr-scroll-chars coloms."
  (interactive "P")
  (ak-set-scroll-value arg)
  ;;(message "==> %s %s" arg ak-lr)
  (scroll-left ak-lr)
  )
(keymap-global-set "<remap> <scroll-right>" 'ak-scroll-right)
(keymap-global-set "<remap> <scroll-left>" 'ak-scroll-left)

;;====================================
;;;; NEW! extend region in next/prev screen.
;;====================================
;; mark whole sentence or extend to next.
(defun ak-mark-sentence ()
  (interactive)
  ;;(message "ak-mark-s")
  (if (region-active-p)
      ;; expanding region
      (forward-sentence)
    ;; define region
    (forward-sentence)
    (backward-sentence)
    (set-mark (point))
    (forward-sentence)
    ))
(defun ak-mark-sentence-backward ()
  (interactive)
  ;;(message "ak-mark-s-b")
  (if (region-active-p)
      ;; expanding region
      (unless (bobp) (backward-sentence))
    ;; define region
    (unless (bobp) (backward-sentence))
    (mark-end-of-sentence 1)
    ))
(keymap-global-set "s-]" 'ak-mark-sentence)
(keymap-global-set "s-}" 'ak-mark-sentence-backward)
;; M-e, M-a is for/backward-sentence

;; mark whole paragraph or extend to next.
(defun ak-mark-paragraph ()
  (interactive)
  ;;(message "ak-mark-p")
  (if (region-active-p)
      ;; expanding region
      (forward-paragraph)
    ;; define region
    (mark-paragraph)
    (exchange-point-and-mark)))
(defun ak-mark-paragraph-backward ()
  (interactive)
  ;;(message "ak-mark-p")
  (if (region-active-p)
      ;; expanding region
      (unless (bobp) (backward-paragraph))
    ;; define region
    (mark-paragraph)
    ))
(defun ak-forward-paragraph ()
  (interactive) ;;"^p"
  (forward-paragraph))
(defun ak-backward-paragraph ()
  (interactive) ;;"^p"
  (backward-paragraph))
(keymap-global-set "M-}" 'ak-forward-paragraph)
(keymap-global-set "M-{" 'ak-backward-paragraph)
(keymap-global-set "M-h" 'ak-mark-paragraph)
(keymap-global-set "M-H" 'ak-mark-paragraph-backward)
;; C-<down>, C-<up> was for/backward-paragraph

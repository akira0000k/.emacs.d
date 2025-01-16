;; ------ 00misc.el ------

;; Erase Menu bar
(menu-bar-mode -1)
;;(menu-bar-mode 1)
;;;; M-x tmm-menubar
;;;; ESC `

(display-time)
(line-number-mode t)
(column-number-mode t)
(setq kill-whole-line t)
(delete-selection-mode 1)
(setq dired-dnd-protocol-alist nil)

;;(setq visible-bell t)
(setq ring-bell-function 'ignore)

(setq default-input-method "japanese")
(setq split-width-threshold nil)
(setq use-dialog-box nil)

;;====================================
;;;; keybinding while Isearch.  ex. C-s C-w ..yank word
;;====================================
(define-key isearch-mode-map "\C-k" 'isearch-edit-string)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;;   frequently used
;;   C-k                isearch-edit-string       ex. C-s C-k
;;   M-e                isearch-edit-string
;;   C-r                isearch-repeat-backward   ex. C-s C-r
;;   C-s                isearch-repeat-forward    ex. C-s C-s
;;   C-w                isearch-yank-word-or-char ex. C-s C-w
;;
;;   toggle
;;   M-c                isearch-toggle-case-fold       ex. C-s M-c
;;   M-r                isearch-toggle-regexp          ex. C-s M-r
;;   M-s SPC            isearch-toggle-lax-whitespace  ex. C-s M-s SPC
;;   M-%                isearch-query-replace          ex. C-s aaa M-% bbb
;;   C-M-%              isearch-query-replace-regexp   ex. C-s ^aaa C-M-% bbb

;;   toggle default
(setq isearch-lax-whitespace nil)  ;;off
;;(setq isearch-lax-whitespace t)  ;;on (default)

(global-set-key (kbd "C-r") 'query-replace) ;; M-% aaa bbb
(global-set-key (kbd "C-M-r") 'query-replace-regexp) ;; C-M-% aaa bbb

;; no cua-mode  cut/copy/paste=C-w C-S-w C-y
(global-set-key (kbd "C-S-w") 'kill-ring-save) ;; M-w
(global-set-key (kbd "C-x r W") 'copy-rectangle-as-kill)  ;; C-x r M-w

;; for MAC OSX
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
;; like iTerm M-s-q ==> send <C-x><C-c>
(global-set-key (kbd "M-s-q") 'save-buffers-kill-emacs)


;; overwridden by cua-mode
;;;;  ;; no cua-mode  cut/paste=C-w C-v  copy/paste=M-w M-v
;;;;  (global-set-key (kbd "M-v") 'yank) ;; C-y
;;;;  (global-set-key (kbd "C-v") 'yank) ;; C-y
(global-set-key (kbd "C-z") 'undo) ;; C-x C-z  ^Z ..fg

;;                    M-f10       'toggle-frame-maximized
;;                    M-f11       'toggle-frame-fullscreen  ;; <- f11
;;                    C-x C-c     'save-buffers-kill-terminal
;;                    C-x C-z     'suspend-frame            ;; <- C-z
;;                    C-x 5 2     'make-frame-command
;;                    s-n         'make-frame


;;====================================
;;;; kill region or kill line. (MAC OSX style)
;;====================================
(global-set-key (kbd "C-k") 'ak-kill-line)
;;  copy
(global-set-key (kbd "C-S-k") 'ak-copy-line)
;; kill active region or kill line
;; active region may have length 0
(defun ak-kill-line (&optional arg)
  (interactive "P")
  (if (region-active-p)
      (kill-region 0 0 t)
    (kill-line arg)))
(defun ak-copy-line (&optional arg)
  (interactive "P")
  (if (region-active-p)
      (kill-ring-save 0 0 t)
    (kill-line arg)
    (yank)))



;; ------ 01keys.el ------

;;====================================
;;;; Teraterm End key = <select>
;;====================================
(define-key input-decode-map "\e[1~" [home])   ;;<find> to <home>  (screen)
(define-key input-decode-map "\e[4~" [end])    ;;<select> to <end>  (NumLock-off 1)
(define-key input-decode-map "\e[3~" [deletechar])   ;;vscode delete key was DEL

;;  MAC OSX  default reversed by kbd setting   ¥-->\   fn ¥-->¥
;;      but C-\  M-\  ...ng
(define-key input-decode-map (kbd "M-¥") (kbd "M-\\"))
;;      for emacs.app    terminal->no need
(define-key input-decode-map (kbd "C-¥") (kbd "C-\\"))

;;  C-S-DEL kill-whole-line
(define-key input-decode-map "\e[3;6~" (kbd "C-S-<backspace>")) ;;was C-S-<delete>

;;  S-SPC is backward SPC.
(define-key input-decode-map "\e[32;2u" (kbd "S-SPC"))
(define-key input-decode-map "\e[27;2;32~" (kbd "S-SPC"))

;;  MAC OSX iTerm2
;;  C-SPC:0x00 C-@:M-[27;5;64~ for set-mark
;;  C-7:0x1f   C-_;M-[27;5;95~ for undo

;; 5: Control
;;(define-key input-decode-map "\e[27;5;58~" (kbd "C-:")) ;;ja?
(define-key input-decode-map "\e[27;5;64~" (kbd "C-@"))
(define-key input-decode-map "\e[27;5;94~" (kbd "C-^"))
(define-key input-decode-map "\e[27;5;95~" (kbd "C-_"))
;; 6: Control + shift
;;(define-key input-decode-map "\e[27;6;39~" (kbd "C-'")) ;;ja?
;;(define-key input-decode-map "\e[27;6;61~" (kbd "C-=")) ;;ja?
(define-key input-decode-map "\e[27;6;96~" (kbd "C-`"))
(define-key input-decode-map "\e[27;6;123~" (kbd "C-{"))
(define-key input-decode-map "\e[27;6;124~" (kbd "C-|"))
(define-key input-decode-map "\e[27;6;125~" (kbd "C-}"))
(define-key input-decode-map "\e[27;6;126~" (kbd "C-~"))
;; 7: Control + Meta
;;(define-key input-decode-map "\e[27;7;58~" (kbd "C-M-:")) ;;ja?
(define-key input-decode-map "\e[27;7;64~" (kbd "C-M-@"))
(define-key input-decode-map "\e[27;7;94~" (kbd "C-M-^"))
(define-key input-decode-map "\e[27;7;95~" (kbd "C-M-_"))
;; 8: Control + Meta + Shift
;;(define-key input-decode-map "\e[27;8;39~" (kbd "C-M-'")) ;;ja?
;;(define-key input-decode-map "\e[27;8;61~" (kbd "C-M-=")) ;;ja?
(define-key input-decode-map "\e[27;8;96~" (kbd "C-M-`"))
(define-key input-decode-map "\e[27;8;123~" (kbd "C-M-{"))
(define-key input-decode-map "\e[27;8;124~" (kbd "C-M-|"))
(define-key input-decode-map "\e[27;8;125~" (kbd "C-M-}"))
(define-key input-decode-map "\e[27;8;126~" (kbd "C-M-~"))

;;====================================
;;;; Another modifier key after ESC 
;;====================================
;; avoid confusing with Esc C-x => eval-defun (in elisp moode)
;; simple.el
;; (define-key function-key-map [?\C-x ?@ ?S] 'event-apply-shift-modifier)
;; (define-key function-key-map [?\C-x ?@ ?s] 'event-apply-super-modifier)

(define-key function-key-map [?\M-s ?@ ?S] 'event-apply-shift-modifier)
(define-key function-key-map [?\M-s ?@ ?s] 'event-apply-super-modifier)

;;;; Esc Esc s @ S ^A   C-M-S-a   Shift + beginning-of-defun
;;;; Esc Esc s @ S ^E   C-M-S-e   Shift + end-of-defun
;;;; Esc Esc s @ S ^F	C-M-S-f   Shift + forward-sexp
;;;; Esc Esc s @ S ^B	C-M-S-b   Shift + backward-sexp
;;;; Esc Esc s @ S ^N	C-M-S-n   Shift + forward-list
;;;; Esc Esc s @ S ^P	C-M-S-p   Shift + backward-list
;;;; Esc Esc s @ S ^D   C-M-S-d   Shift + down-list
;;;; Esc Esc s @ S ^U   C-M-S-u   Shift + backward-up-list
;;;; Esc Esc s @ S ^L	C-M-S-l   recenter-other-window
;;;; Esc Esc s @ S ^V	C-M-S-v   scroll-other-window-down
;;;; Esc Esc s @ s f	M-s-f     isearch-forward-regexp
;;;; Esc Esc s @ s F	M-s-F     isearch-backward-regexp


;;====================================
;;;; MAC OSX command key for iTerm2
;;====================================
;;;; terminal send Esc s up for command up
(define-key input-decode-map "\es\eOA" (kbd "s-<up>"))
(define-key input-decode-map "\es\eOB" (kbd "s-<down>"))
(define-key input-decode-map "\es\eOC" (kbd "s-<right>"))
(define-key input-decode-map "\es\eOD" (kbd "s-<left>"))
(define-key input-decode-map "\es\e[1;2A" (kbd "s-S-<up>"))
(define-key input-decode-map "\es\e[1;2B" (kbd "s-S-<down>"))
(define-key input-decode-map "\es\e[1;2C" (kbd "s-S-<right>"))
(define-key input-decode-map "\es\e[1;2D" (kbd "s-S-<left>"))

(define-key input-decode-map "\es@+C-S-s-n" (kbd "C-S-s-n"))
(define-key input-decode-map "\es@+C-S-s-p" (kbd "C-S-s-p"))

;;====================================
;;;; MAC OSX command keys
;;====================================
;;;; MAC OSX command key + up down left right
(global-set-key [s-up]    'beginning-of-buffer)
(global-set-key [s-down]  'end-of-buffer)
(global-set-key [s-left]  'move-beginning-of-line)
(global-set-key [s-right] 'move-end-of-line)
;;     same as default
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "s-D") 'dired)
(global-set-key (kbd "s-M") 'manual-entry)
(global-set-key (kbd "s-L") 'shell-command)
(global-set-key (kbd "s-|") 'shell-command-on-region)
(global-set-key (kbd "s-?") 'info)

(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-x") 'kill-region)
(if (equal (framep-on-display) 'ns)
    (global-set-key (kbd "s-c") 'ns-copy-including-secondary) ;;Xwindow
  (global-set-key (kbd "s-c") 'kill-ring-save)) ;;Terminal
(global-set-key (kbd "s-v") 'yank)
(if (equal (framep-on-display) 'ns)
    (global-set-key (kbd "s-y") 'ns-paste-secondary)) ;;Xwindow

(global-set-key (kbd "s-k") 'kill-current-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-u") 'revert-buffer)

(global-set-key (kbd "s-n") 'make-frame)
(global-set-key (kbd "s-w") 'delete-frame)
(global-set-key (kbd "s-'") 'next-window-any-frame) ;; 0x27 '
(global-set-key (kbd "s-`") 'other-frame)           ;; 0x60 `
;;(global-set-key (kbd "s-~") 'ns-prev-frame)       ;; 0x7E ~
(global-set-key (kbd "s-~") 'ak-prev-frame)

(global-set-key (kbd "s-d") 'isearch-repeat-backward)
(global-set-key (kbd "s-f") 'isearch-forward)
(global-set-key (kbd "s-F") 'isearch-backward)
(global-set-key (kbd "M-s-f") 'isearch-forward-regexp)
(global-set-key (kbd "M-s-F") 'isearch-backward-regexp)
(global-set-key (kbd "s-g") 'isearch-repeat-forward)
(global-set-key (kbd "s-e") 'isearch-yank-kill)
(global-set-key (kbd "s-j") 'exchange-point-and-mark)
;;      HIRAGANA key
(define-key input-decode-map (kbd "s-ち") (kbd "s-a"))	    ;;mark-whole-buffer
(define-key input-decode-map (kbd "s-り") (kbd "s-l"))	    ;;goto-line
(define-key input-decode-map (kbd "s-ー") (kbd "s-|"))	    ;;shell-command-on-region
(define-key input-decode-map (kbd "s-・") (kbd "s-?"))	    ;;info
							     
(define-key input-decode-map (kbd "s-つ") (kbd "s-z"))	    ;;undo
(define-key input-decode-map (kbd "s-さ") (kbd "s-x"))	    ;;kill-region
(define-key input-decode-map (kbd "s-そ") (kbd "s-c"))	    ;;ns-copy-including-secondary / kill-ring-save
(define-key input-decode-map (kbd "s-ひ") (kbd "s-v"))	    ;;yank
(define-key input-decode-map (kbd "s-ん") (kbd "s-y"))	    ;;ns-paste-secondary
							     
(define-key input-decode-map (kbd "s-の") (kbd "s-k"))	    ;;kill-current-buffer
(define-key input-decode-map (kbd "s-と") (kbd "s-s"))	    ;;save-buffer
(define-key input-decode-map (kbd "s-な") (kbd "s-u"))	    ;;revert-buffer
							     
(define-key input-decode-map (kbd "s-み") (kbd "s-n"))	    ;;make-frame
(define-key input-decode-map (kbd "s-て") (kbd "s-w"))	    ;;delete-frame
(define-key input-decode-map (kbd "s-ゃ") (kbd "s-'"))	    ;;next-window-any-frame
(define-key input-decode-map (kbd "s-へ") (kbd "s-`"))	    ;;other-frame
(define-key input-decode-map (kbd "s-゛") (kbd "s-~"))	    ;;ak-prev-frame

(define-key input-decode-map (kbd "s-し")   (kbd "s-d"))    ;;isearch-repeat-backward
(define-key input-decode-map (kbd "s-は")   (kbd "s-f"))    ;;isearch-forward
(define-key input-decode-map (kbd "M-s-は") (kbd "M-s-f"))  ;;isearch-forward-regexp
(define-key input-decode-map (kbd "s-き")   (kbd "s-g"))    ;;isearch-repeat-forward
(define-key input-decode-map (kbd "s-い")   (kbd "s-e"))    ;;isearch-yank-kill
(define-key input-decode-map (kbd "s-ま")   (kbd "s-j"))    ;;exchange-point-and-mark


;;====================================
;;;; Allow Meta key in Kana mode.
;;====================================
(define-key input-decode-map (kbd "M-ち") (kbd "M-a"))  ;;backward-sentence
(define-key input-decode-map (kbd "M-こ") (kbd "M-b"))	;;backward-word
(define-key input-decode-map (kbd "M-そ") (kbd "M-c"))	;;capitalize-word
(define-key input-decode-map (kbd "M-し") (kbd "M-d"))	;;kill-word
(define-key input-decode-map (kbd "M-い") (kbd "M-e"))	;;forward-sentence
(define-key input-decode-map (kbd "M-は") (kbd "M-f"))	;;forward-word
(define-key input-decode-map (kbd "M-く") (kbd "M-h"))	;;mark-paragraph
(define-key input-decode-map (kbd "M-に") (kbd "M-i"))	;;tab-to-tab-stop
(define-key input-decode-map (kbd "M-ま") (kbd "M-j"))	;;default-indent-new-line
(define-key input-decode-map (kbd "M-の") (kbd "M-k"))	;;kill-sentence
(define-key input-decode-map (kbd "M-り") (kbd "M-l"))	;;downcase-word
(define-key input-decode-map (kbd "M-も") (kbd "M-m"))	;;back-to-indentation
(define-key input-decode-map (kbd "M-み") (kbd "M-n"))	;;half-page-up
(define-key input-decode-map (kbd "M-せ") (kbd "M-p"))	;;half-page-down
(define-key input-decode-map (kbd "M-た") (kbd "M-q"))	;;fill-paragraph
(define-key input-decode-map (kbd "M-す") (kbd "M-r"))	;;move-to-window-line-top-bottom
(define-key input-decode-map (kbd "M-か") (kbd "M-t"))	;;transpose-words
(define-key input-decode-map (kbd "M-な") (kbd "M-u"))	;;upcase-word
(define-key input-decode-map (kbd "M-ひ") (kbd "M-v"))	;;ak-cua-scroll-up
(define-key input-decode-map (kbd "M-て") (kbd "M-w"))	;;kill-ring-save
(define-key input-decode-map (kbd "M-さ") (kbd "M-x"))	;;execute-extended-command
(define-key input-decode-map (kbd "M-ん") (kbd "M-y"))	;;yank-pop
(define-key input-decode-map (kbd "M-つ") (kbd "M-z"))	;;zap-to-char
(define-key input-decode-map (kbd "M-め") (kbd "M-/"))	;;dabbrev-expand



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
  "set cursor at beginning of buffer or line(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (ak-home-toggle)
    ;;(beginning-of-buffer arg) ;;Warning
    (call-interactively 'beginning-of-buffer)
  ))
;;(defun ak-end-of-buffer(&optional arg)
(defun ak-end-of-buffer()
  "set cursor at end of buffer or line(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (end-of-line)
    ;;(end-of-buffer arg) ;;Warning
    ;; [Byte compile] Warning: ‘end-of-buffer’ is for interactive use only; use ‘(goto-char (point-max))’ instead.
    (call-interactively 'end-of-buffer)
  ))



;; ------ 03cua.el ------

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)   ;;defalt  region selected->C-x:cut C-c:copy
;(setq cua-enable-cua-keys nil)
(cua-mode t)

;; ;; <C-return>  start cua set rectangle mark
;; (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; Alternate keybind of cua-rect for org-mode. 
(global-set-key (kbd "C-c C-SPC") 'cua-set-rectangle-mark)

;; C-x SPC     start emacs24 rectangle mark mode

;;  ;; cut/paste=C-w C-v  copy/paste=M-w M-v   possible
;;  (if (boundp 'cua--cua-keys-keymap)
;;      (define-key cua--cua-keys-keymap (kbd "M-v") 'yank))
;;  ;;was     M-v runs the command delete-selection-repeat-replace-region

;;====================================
;;;; Page Down/Page Up  =  M-v M-u
;;====================================
(if (boundp 'cua--cua-keys-keymap)
    (progn
      (define-key cua--cua-keys-keymap (kbd "M-v") 'ak-cua-scroll-up)
      (define-key cua--cua-keys-keymap (kbd "M-V") 'cua-scroll-down)
      ;;(define-key cua--cua-keys-keymap (kbd "M-u") 'cua-scroll-down) ;;was upcase-word
      ))
(defun ak-cua-scroll-up (&optional arg)
  (interactive "^P")
  (cua-scroll-up arg)
  (forward-line 1))

;;;; org-mode 
;; see org-mode-hook

(defun cua-set-rectangle-mark2 (&optional reopen)
  "Set mark and start in CUA rectangle mode.
With prefix argument, activate previous rectangle if possible."
  (interactive "P")
  (if (string= major-mode "org-mode")
      (org-insert-heading-respect-content)
    ;; else
    (cua-set-rectangle-mark reopen)))

(if (boundp 'cua-global-keymap)
    (define-key cua-global-keymap (kbd "C-<return>") 'cua-set-rectangle-mark2))



;; ------ 04dired.el ------

;;====================================
;;;;  dired bindings
;;====================================

(setq dired-clean-up-buffers-too nil)
;; Save Z directory
(defvar dired-default-directory default-directory)
;; t = Open like Vi by [right]
(defcustom ak-dired-view-on-right-arrow nil
  "Non-nil means open in view mode by right arrow in dired."
  :type 'boolean
  :group 'dired
  )

;; Extra keybinds for dired mode

(with-eval-after-load 'dired
  (require 'dired-x)
  ;;(require 'wdired)
  (define-key dired-mode-map [right]   'ak-dired-right-char)      ;; -> f, v
  (define-key dired-mode-map [left]    'ak-dired-left-char)       ;; <- ^
  (define-key dired-mode-map [home]    'ak-dired-home)
  (define-key dired-mode-map [end]     'ak-dired-end)
  (define-key dired-mode-map [prior]   'ak-dired-scroll-down)
  (define-key dired-mode-map [next]    'ak-dired-scroll-up)
  (define-key dired-mode-map [f5]      'revert-buffer)               ;; g
  (define-key dired-mode-map "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
  ;; S            dired-do-symlink
  ;; Y            dired-do-relsymlink  dired-x.el
  ;; edit filename in wdired mode      autoload wdired.el
  (define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)

  (define-key dired-mode-map "h" 'ak-dired-home-dir)
  (define-key dired-mode-map "r" 'ak-dired-root-dir)
  (define-key dired-mode-map "z" 'ak-dired-defo-dir)
  (and (getenv "A_DIRECTORY") (define-key dired-mode-map "a" 'ak-dired-a-dir))
  (and (getenv "B_DIRECTORY") (define-key dired-mode-map "b" 'ak-dired-b-dir))
  (and (getenv "C_DIRECTORY") (define-key dired-mode-map "c" 'ak-dired-c-dir))
  (and (getenv "E_DIRECTORY") (define-key dired-mode-map "e" 'ak-dired-e-dir))
  (define-key dired-mode-map (kbd "C-b") 'dired-up-directory)

  ;; avoid remapping to dired-next(previous)-line
  (defalias 'ak-dired-next-line 'next-line)
  (defalias 'ak-dired-previous-line 'previous-line)
  (define-key dired-mode-map "\C-n" 'ak-dired-next-line)
  (define-key dired-mode-map "\C-p" 'ak-dired-previous-line)

  ;; line scroll and keep cursor on file name
  (define-key dired-mode-map [C-up]   'ak-dired-line-up       )
  (define-key dired-mode-map [C-down] 'ak-dired-line-down     )
  (define-key dired-mode-map [s-up]   'ak-dired-line-up-fast  )
  (define-key dired-mode-map [s-down] 'ak-dired-line-down-fast)
  (define-key dired-mode-map (kbd "C-M-p") 'ak-dired-line-up  ) ;;was dired-prev-subdir
  (define-key dired-mode-map (kbd "C-M-n") 'ak-dired-line-down) ;;was dired-next-subdir

  ;; skip files
  (define-key dired-mode-map "N" 'dired-next-dirline)     ;;was dired-do-man    ">"
  (define-key dired-mode-map "P" 'dired-prev-dirline)     ;;was dired-do-print  "<"
  (define-key dired-mode-map (kbd "C-,") 'ak-dired-beginning-of-buffer)
  (define-key dired-mode-map (kbd "C-.") 'ak-dired-end-of-buffer)
  (define-key dired-mode-map (kbd ",") 'ak-dired-beginning-of-buffer)
  (define-key dired-mode-map (kbd ".") 'ak-dired-end-of-buffer)  ;;was dired-clean-directory
  (define-key dired-mode-map (kbd "M-.") 'dired-clean-directory) ;;was xref-find-definitions
  (define-key dired-mode-map (kbd "C-h") 'dired-unmark-backward) ;;like backspace

  ;; Vi-like
  (define-key dired-mode-map "j" 'next-line)
  (define-key dired-mode-map "k" 'previous-line)
  (define-key dired-mode-map "J" 'ak-dired-line-down)
  (define-key dired-mode-map "K" 'ak-dired-line-up)
  ;;(message "eval-after-load 'dired done.")
  )

(defun ak-dired-home-dir()(interactive)(dired "~"))
(defun ak-dired-root-dir()(interactive)(dired "/"))
(defun ak-dired-defo-dir()(interactive)(dired dired-default-directory))
(defun ak-dired-a-dir()(interactive)(dired (getenv "A_DIRECTORY")))
(defun ak-dired-b-dir()(interactive)(dired (getenv "B_DIRECTORY")))
(defun ak-dired-c-dir()(interactive)(dired (getenv "C_DIRECTORY")))
(defun ak-dired-e-dir()(interactive)(dired (getenv "E_DIRECTORY")))

(add-hook 'dired-mode-hook
	  (lambda ()
            ;;(dired-omit-mode 1)
            (setq truncate-lines 1)
            ))

(defun ak-dired-right-char (&optional arg)
  "find file or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (forward-char arg)
    ;;else
    (if ak-dired-view-on-right-arrow
	(dired-view-file)
      (dired-find-file))
    )
  )
(defun ak-dired-left-char (&optional arg)
  "up directory or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (dired-up-directory)
    )
  )

(defun ak-dired-home()
  "go to first file or select to col1"
  (interactive "^")
  (if this-command-keys-shift-translated
      (beginning-of-line)
    (ak-dired-beginning-of-buffer))
  )
(defun ak-dired-beginning-of-buffer()
  "in dired set cursor at first file"
  (interactive "^")
  (goto-char (point-min))
  (dired-goto-next-nontrivial-file)
  ;; no valid file, first line.
  (when (equal (point) (point-max))
    (goto-char (point-min))
    (dired-next-line 1))
  )
(defun ak-dired-end()
  "go to last file or select to end of line"
  (interactive "^")
  (if this-command-keys-shift-translated
      (end-of-line)
    (ak-dired-end-of-buffer))
  )
(defun ak-dired-end-of-buffer()
  "in dired set cursor at last file"
  (interactive "^")
  (goto-char (point-max))
  (dired-previous-line 1)
  )

(defun ak-dired-scroll-down ()
  "Page up and set cursor at file"
  (interactive "^")
  (if (ak-first-page-p)
      (ak-dired-beginning-of-buffer)
    (scroll-down)
    (dired-previous-line 1))
  )
(defun ak-dired-scroll-up ()
  "Page down and set cursor at file"
  (interactive "^")
  (if (ak-last-page-p)
      (progn
        (move-to-window-line -1)
        (dired-previous-line 1))
    (scroll-up)
    (dired-next-line 1))
  )

(defun ak-dired-line-up()        (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line -1)
	   (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down()      (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (scroll-up   1)(move-to-window-line pos0)(dired-next-line 0)))
(defun ak-dired-line-up-fast()   (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line (- ak-fast-scroll-lines))
	   (scroll-down ak-fast-scroll-lines)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down-fast() (interactive "^")
       (let ( (pos0 (current-window-line)) )
	 (if (ak-last-page-p)
	     (dired-next-line ak-fast-scroll-lines)
	 (scroll-up ak-fast-scroll-lines)(move-to-window-line pos0)(dired-next-line 0))))

(defun ak-dired-find-file-hexl ()
  "In dired, visit the Binary file in hexl-mode named on this line."
  (interactive)
  (hexl-find-file (dired-get-filename)))


;;====================================
;;;; press left at top of window then kill buffer and show dired
;;====================================
(global-set-key (kbd "C-b") 'ak-backward-char)

;; ;; Cursor L, R move always logical order, backward and forward,
;; ;; even at R2L text and visual-order-cursor-movement is t
;; (global-set-key [left] 'ak-backward-char)
;; (global-set-key [right] 'forward-char)

;; cursor move L R naturally at R2L text.
(global-set-key [left] 'ak-left-char)
(global-set-key [right] 'ak-right-char)
(if (boundp 'cua--rectangle-keymap)
    (progn
      (define-key cua--rectangle-keymap [remap ak-right-char]          #'cua-resize-rectangle-right)
      (define-key cua--rectangle-keymap [remap ak-left-char]           #'cua-resize-rectangle-left)
      (define-key cua--rectangle-keymap [remap ak-backward-char]       #'cua-resize-rectangle-left)
      ))

(setq visual-order-cursor-movement t)

(defun ak-backward-char (&optional arg)
  "press left arrow at the top  then kill buffer."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (if (not(equal (point) (point-min)))
        (backward-char arg)
      ;else
      (kill-buffer-and-dired)
      )
    )
  )
(defun ak-left-char (&optional arg)
  "press left arrow at the top  then kill buffer."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (left-char arg)
    ;;else
    (if (and(equal (point) (point-min))
	(equal (current-bidi-paragraph-direction) 'left-to-right))
	(kill-buffer-and-dired)
      ;;else
      (left-char arg))
    )
  )
(defun ak-right-char (&optional arg)
  "press right arrow at the top  then kill buffer at R2L text."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (right-char arg)
    ;;else
    (if (and(equal (point) (point-min))
	(equal (current-bidi-paragraph-direction) 'right-to-left))
	(kill-buffer-and-dired)
      ;;else
      (right-char arg))
    )
  )
(defun kill-buffer-and-dired()
  "kill this buffer and show current directory."
  ;;(interactive)
  (if (string= major-mode "dired-mode")
      (kill-buffer nil)
    (find-alternate-file "."))
  )



;; ------ 05like.el ------

;;====================================
;;;; function keys
;;====================================
;;was                 help-command
(global-set-key [f1] 'help-for-help)
(global-set-key [S-f1] 'other-window)

;;        C-x 6 2		2C-two-columns
;;        C-x 6 b		2C-associate-buffer
;;        C-x 6 s		2C-split
;;was                 2C-command
(global-set-key [f2] 'ak-divide-screen-toggle)
;;(global-set-key [S-f2] 'ak-divide-screen-or-other)
(global-set-key [S-f2] 'ak-divide-screen3-or-other)

;;was                 kmacro-start-macro-or-insert-counter
(global-set-key [f3] 'isearch-repeat-forward)
(global-set-key [S-f3] 'isearch-repeat-backward)

;;was                    kmacro-end-or-call-macro
(global-set-key [f4]    'kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key [S-f4] 'delete-window)

(global-set-key [f5]  'recenter)
(global-set-key [S-f5] 'ak-dired-current-dir)
(defun ak-dired-current-dir()
  "dired current directory" (interactive)
  (dired "."))

(global-set-key [f6]   'universal-coding-system-argument)       ;;   C-x RET-c
(global-set-key [S-f6]   'electric-indent-mode)
;;test macro
(global-set-key (kbd "ESC <f6>")  'kmacro-start-macro-or-insert-counter)  ;; <f3>
(global-set-key [C-f6]  'kmacro-end-or-call-macro)  ;; <f4>

(global-set-key [f7]   'ak-shrink-window)
(global-set-key [S-f7] 'ak-shrink-window2)
(global-set-key [f8]   'ak-enlarge-window)
(global-set-key [S-f8] 'ak-enlarge-window2)

(global-set-key [f9]  'describe-key-briefly)
(global-set-key [S-f9] 'ak-toggle-case-fold-search)
(defun ak-toggle-case-fold-search()
  "Toggle search case." (interactive)
  (if case-fold-search
      (progn (setq-default case-fold-search nil)
	     (message "case sensitive Search mode"))
    (setq-default case-fold-search t)
    (message "ignore case Search mode")))

;;was  menu-bar-open
(global-set-key [f10] 'ak-window-swap-split)
;; (global-set-key [S-f10] 'ak-window-vh-split)
;; (global-set-key [f10] 'ak-window-rotate-split)
(global-set-key [S-f10] 'ak-window-rotate-split-reverse)
;;               M-f10   toggle-frame-maximized  =  "ESC <f10>"

(global-set-key (kbd "M-<f11>")   'toggle-frame-fullscreen)  ;; <f11>
(global-set-key (kbd "ESC <f11>") 'toggle-frame-fullscreen)  ;; <f11>

;;was                 'toggle-frame-fullscreen  ==> "ESC <f11>"
(global-set-key [f11] 'toggle-truncate-lines)  ;; Show Desktop (MAC OSX)
;; (require 'linum)                            ;; obsolete (emacs29)
;; (global-set-key [f12] 'global-linum-mode)
(global-set-key [f12] 'global-display-line-numbers-mode)
;;(global-set-key [f12] 'display-line-numbers-mode)
(global-set-key [S-f11] 'scroll-right)
(global-set-key [S-f12] 'scroll-left)


;;======================================
;;; shrink / enlarge window automatic_|_
;;======================================
(defun ak-shrink-window (&optional vh)
  "shrink window to possible direction"
  (interactive)
  (if (window-full-height-p)
      (shrink-window 1 t)
    (if (window-full-width-p)
        (shrink-window 1 nil)
      ;;else
      (if vh
	  (shrink-window 1 t) ;;<-|
	(shrink-window 1 nil)) ;;_A_ (default)
      ))
  )
(defun ak-shrink-window2 ()
  "for small window, shrink <-|"
  (interactive)
  (ak-shrink-window t))
(defun ak-enlarge-window (&optional vh)
  "enlarge window to possible direction"
  (interactive)
  (if (window-full-height-p)
      (enlarge-window 1 t)
    (if (window-full-width-p)
        (enlarge-window 1 nil)
      ;;else
      (if vh
	  (enlarge-window 1 t) ;;->|
	(enlarge-window 1 nil)) ;;_V_ (default)
      ))
  )
(defun ak-enlarge-window2 ()
  "for small window, enlarge ->|"
  (interactive)
  (ak-enlarge-window t))
;;=============================A<>B=====
;;; swap 2 screen  A<-|->B    ------
;;=============================B<>A=====
(defun ak-window-swap-split ()
  "swap 2 window of U-D or L-R"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-right)
          (if (not (= before-minx (nth 0 (window-edges))))
	      (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-below)
        (if (not (= before-miny (nth 1 (window-edges))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
;;================================A=====
;;; VerHor swap 2  A|B  <-->   ------
;;================================B=====
(defun ak-window-vh-split ()
  "toggle window split ver-hor"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-below)
          (if (= before-minx (nth 0 (window-edges)))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-right)
        (if (= before-miny (nth 1 (window-edges)))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
;;========================A=========B===
;;; rotate 2 screen  A|B ---  B|A  ---
;;========================B=========A===
(defun ak-xor (a b)
  "Exclusive or."
  (if a (not b) b))
(defun ak-window-rotate-split (&optional reverse)
  "rotate window split clockwise"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
	  ;;(message "||vertical||")
          (split-window-below)
          (if (ak-xor reverse (= before-minx (nth 0 (window-edges))))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
	;;(message "--horizontal--")
        (split-window-right)
        (if (ak-xor reverse (not (= before-miny (nth 1 (window-edges)))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
(defun ak-window-rotate-split-reverse ()
  "rotate window split unti-clockwise"
  (interactive)
  (ak-window-rotate-split t)
  )

;;====================================
;;;; jump matching paren (<--->)
;;====================================
(global-set-key "\C-]" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis"
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        )
  )

;;====================================
;;;;divide/one screen
;;====================================
(defun ak-divide-screen-toggle()
  "Divide one window or Close next window."
  (interactive)
        (if (one-window-p)
                (split-window-below)
          (delete-other-windows)))

;;====================================
;;;;divide L|R /one screen
;;====================================
(defun ak-divide-screen3-toggle()
  "Divide one window or Close next window."
  (interactive)
        (if (one-window-p)
                (split-window-right)
          (delete-other-windows)))

;;====================================
;;;;divide/other screen (reverse)
;;====================================
(defun ak-divide-screen-or-other()
  "Divide one window or move to next window."
  (interactive)
        (if (one-window-p)
                (split-window-below)
          (other-window -1)))

;;====================================
;;;;divide L|R /other screen (reverse)
;;====================================
(defun ak-divide-screen3-or-other()
  "Divide one window or move to next window."
  (interactive)
        (if (one-window-p)
                (split-window-right)
          (other-window -1)))

;;====================================
;;;;add region mark
;;====================================
;;  "リージョンに引用マークをつける"  M-x cite-region
(defvar quoting-marker "//")
;;;(defun cite-region ()        tex で消える
(defun ciregion ()
  "insert // to region"
  (interactive)
  (setq quoting-marker
                (read-string "Quoting marker: " quoting-marker)
                )
  
  (save-excursion
    (let 
                (
                  (e (max (region-end) (region-beginning)))
                   (b (min (region-end) (region-beginning)))
                    (len (length quoting-marker))
                         )
      (goto-char b)
      (while (<= (+ (point) 1) e)
        ;;xx (insert-string quoting-marker)
        (insert quoting-marker)
        (setq e (+ e len))
        (forward-line 1)))))
;;;end cite-region



;; ------ 06shell.el ------

;;====================================
;;;; shell-mode
;;====================================
;; M-x shell  ==>  M-x s
(defalias 's 'shell)

(with-eval-after-load 'shell
  (load "~/.emacs.d/site-lisp/tails-comint-history")
  ;; comint 関係の設定
  (setq comint-process-echoes t)
  (setq comint-input-autoexpand nil)
  ;;(setq comint-input-autoexpand 'input)
  ;;(setq comint-input-autoexpand 'history)
  (setq comint-scroll-to-bottom-on-input t)
  ;;(setq comint-scroll-to-bottom-on-output t)
  (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
  (define-key shell-mode-map  [f5]     'ak-do-resync-dirs)
  (define-key comint-mode-map [home]   'beginning-of-buffer)
  (define-key comint-mode-map [end]    'end-of-buffer)
  (define-key comint-mode-map [C-up]   'ak-scroll-down1)
  (define-key comint-mode-map [C-down] 'ak-scroll-up1)
  (define-key comint-mode-map [up]     'ak-shell-up)
  (define-key comint-mode-map [down]   'ak-shell-down)
  )

(add-hook 'shell-mode-hook
	  (lambda ()
	    (dirtrack-mode)
	    (setq shell-dirstack-query "pwd")
            ))

(defun ak-shell-down ()
  "next command by down arrow at shell mode."
  (interactive "^")
  (if (= (point-max) (point))
      (tails-comint-next-input)  ;(comint-next-input 1)
    (forward-line)))

(defun ak-shell-up ()
  "prev command by up arrow at shell mode."
  (interactive "^")
  (if (= (point-max) (point))
      (tails-comint-previous-input)     ;(comint-previous-input 1)
    (forward-line -1)))

(defun ak-do-resync-dirs()
  "resync current directory with pwd command. same as M-x dirs." (interactive)
  (shell-resync-dirs))

;(setq comint-password-prompt-regexp
;      "\\(\\([Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(Enter \\|Repeat \\|Bad \\)?[Pp]assphrase\\)\\(, try again\\)?\\( for [^:]+\\)?:\\s *\\'"
;      )

;; (setq comint-password-prompt-regexp
;;    "\\(^ *\\|\\( SMB\\|'s\\|Bad\\|CVS\\|Current\\|Enter\\(?: \\(?:Auth\\|same\\|the\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Repeat\\|Retype\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|login\\) +.*\\)\\(?:adgangskode\\|contrasenya\\|contraseña\\|decryption key\\|encryption key\\|geslo\\|hasło\\|heslo\\|iphasiwedi\\|jelszó\\|lozinka\\|lösenord\\|mot de passe\\|mật khẩu\\|parola\\|pasahitza\\|pass phrase\\|passcode\\|passord\\|passphrase\\|passwor[dt]\\|pasvorto\\|pin\\|salasana\\|senha\\|slaptažodis\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'")


(add-to-list 'display-buffer-alist
	     ;;'("^\\*shell\\*$" . (display-buffer-same-window))  ;; default
	     ;;'("^\\*shell\\*$" . (display-buffer-below-selected))  ;; emacs 25.1
	     '("^\\*shell\\*$" . (display-buffer-at-bottom))
	     )



;; ------ 07buffer.el ------

;;====================================
;;;;circular buffer change
;;====================================
;;C-PageUp C-PageDown .. Excel:change tab
(global-set-key [C-prior] 'ak-last-buffer)
(global-set-key [C-next]  'ak-next-buffer)

(defun ak-last-buffer()
  "Popup last buffer from list, and show it"
  (interactive)
  (switch-to-buffer (get-last-buffer))
  ;;(list-buffers-if-exist)
  )

(defun ak-next-buffer()
  "Bury current buffer at bottom of list, and show next one."
  (interactive)
  (bury-buffer (buffer-name))
  (switch-to-buffer (get-first-buffer))
  ;;(list-buffers-if-exist)
  )

(defun get-last-buffer()
  (let ((lastbuf nil)
        (blist (buffer-list))
        (name nil))
  (while blist
        (setq name (buffer-name (car blist)))
        (if (miscbufferp name)
                t              ;;skip minibuffer
          (setq lastbuf name))
        (setq blist (cdr blist))
        )
  lastbuf))

(defun get-first-buffer()
  (let ((firstbuf nil)
        (blist (buffer-list))
        (buffer nil)
        (name nil))
  (while blist
        (setq buffer (car blist))
        (setq name (buffer-name buffer))
        (if (miscbufferp name)
                (setq blist (cdr blist))
          (setq firstbuf name)
          (setq blist nil))
        )
  firstbuf))

(defun miscbufferp(name)
  (or (string-match "^ " name)
      (string-match "^\\*Buffer List\\*" name)
;;      (string-match "^\\*scratch\\*" name)
;;      (string-match "^\\*Messages\\*" name)
      (string-match "^\\*svn-log-edit\\*" name)
      (string-match "^\\*ftp" name)
      (string-match "^TAGS" name)
      ))

;;(defun list-buffers-if-exist()
;;  (and (get-buffer "*Buffer List*") (get-buffer-window (get-buffer "*Buffer List*")) (list-buffers)))
(defun list-buffers-if-exist()
  (let ((buflist (get-buffer "*Buffer List*")))
    (if buflist
	(if (get-buffer-window buflist)
	    (list-buffers)
	  ;;else
	  (if (get-buffer-window-list buflist nil t)
	      (when (fboundp 'auto-revert-set-timer)
		;; Update Buffer List on other frame
		(let ((orgint auto-revert-interval))
		  (setq auto-revert-interval 0.1)
		  (auto-revert-set-timer)
		  (setq auto-revert-interval orgint)))
	    )))
    ))

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)
;; (defun ak-kill-buffer()
;;   (interactive)
;;   (kill-buffer)
;;   (list-buffers-if-exist))
;; (global-set-key [remap kill-buffer] 'ak-kill-buffer)

(defun ak-kill-current-buffer()
  (interactive)
  ;; enabling focus-out hook of org-mode
  (if (string= major-mode "org-mode")
      (if (fboundp 'ak-org-focus-out)
	  (ak-org-focus-out)))
  (kill-current-buffer)
  (list-buffers-if-exist))
(global-set-key [remap kill-current-buffer] 'ak-kill-current-buffer)
(global-set-key [remap kill-this-buffer] 'ak-kill-current-buffer)

(setq ad-redefinition-action 'accept)

;;(defadvice quit-window (after AK-quit-window )
;;  "Quit window and change buffer-list."
;;  (list-buffers-if-exist))
;;(ad-activate 'quit-window)
(defun ak-quit-window (&optional kill window)
  "Quit window and change buffer-list."
  ;;(message "quit window done")
  (list-buffers-if-exist))
(advice-add 'quit-window :after #'ak-quit-window)

(defun ak-bury-buffer (&optional buffer-or-name)
  "Bury buffer and change buffer-list."
  ;;(message "bury buffer done")
  (list-buffers-if-exist))
(advice-add 'bury-buffer :after #'ak-bury-buffer)

(defun ak-switch-to-buffer (buffer-or-name &optional norecord force-same-window)
  "Switch window and change buffer-list."
  ;;(message "switch to buffer done")
  (list-buffers-if-exist))
(advice-add 'switch-to-buffer :after #'ak-switch-to-buffer)

(defun ak-find-file (filename &optional wildcards)
  "Find-File and change buffer-list."
  ;;(message "find file done")
  (list-buffers-if-exist))
(advice-add 'find-file :after #'ak-find-file)

;;(setq ad-redefinition-action 'accept)
(defun ak-shell (&optional buffer file-name)
  "M-x shell"
  (list-buffers-if-exist))
(advice-add 'shell :after #'ak-shell)

(defun ak-dired (dirname &optional switches)
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(advice-add 'dired :after #'ak-dired)

(defun ak-info (&optional file-or-node buffer)
  "Enter Info, the documentation browser."
  (list-buffers-if-exist))
(advice-add 'info :after #'ak-info)

;; s-^ kill-some-buffers use it.  see files.el
(defun ak-before-kill-buffer-ask (buffer)
  "Show buffer."
  (switch-to-buffer buffer))
(advice-add 'kill-buffer-ask :before #'ak-before-kill-buffer-ask)



;; ------ 08mode.el ------

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;;view-mode
;;====================================
;;  "ESC f1"  view mode
(global-set-key (kbd "ESC <f1>") 'ak-View-mode)
(defun ak-View-mode()
  "make current file view mode." (interactive)
  (view-mode t))
;;  "i"     editing
(defun ak-View-exit()
  "make current file editable." (interactive)
  (message "editing")(View-exit))

(setq view-inhibit-help-message t)

(setq view-mode-hook
      '(lambda()
	 (when view-mode
	   (message "View mode: type i (edit), Esc-f1 (view), :w (save), :q (kill)")
	   )))

(with-eval-after-load 'view
  (define-key view-mode-map [f5] 'ak-revert-buffer-noconfirm)
  (define-key view-mode-map "i" 'ak-View-exit)
  (define-key view-mode-map "h" 'left-char)
  (define-key view-mode-map "j" 'next-line)
  (define-key view-mode-map "k" 'previous-line)
  (define-key view-mode-map "l" 'right-char)
  (define-key view-mode-map "b" 'backward-char)
  (define-key view-mode-map "f" 'forward-char)
  (define-key view-mode-map "a" 'beginning-of-visual-line)
  (define-key view-mode-map "e" 'end-of-visual-line)
  (define-key view-mode-map "H" 'ak-goto-top-screen)   
  (define-key view-mode-map "M" 'ak-goto-mid-screen)   
  (define-key view-mode-map "L" 'ak-goto-bottom-screen)
  (define-key view-mode-map "y"	'ak-line-up)
  (define-key view-mode-map (kbd "RET") 'ak-line-down)
  (define-key view-mode-map "K" 'ak-line-up)
  (define-key view-mode-map "J" 'ak-line-down)
  (define-key view-mode-map "u" 'half-page-down)
  (define-key view-mode-map "d" 'half-page-up)
  (define-key view-mode-map [remap View-scroll-page-backward] #'ak-scroll-page-backward);; DEL, S-SPC
  (define-key view-mode-map [remap View-scroll-page-forward]  #'ak-scroll-page-forward) ;; SPC
  (define-key view-mode-map "　" 'ak-scroll-page-forward)
  (define-key view-mode-map "G" 'end-of-buffer)
  (define-key view-mode-map "o" 'ak-View-scroll-to-buffer-end)
  (define-key view-mode-map "/" 'isearch-forward-regexp)
  (define-key view-mode-map "\\" 'isearch-backward-regexp)
  (define-key view-mode-map "n" 'isearch-repeat-forward)
  (define-key view-mode-map "N" 'isearch-repeat-backward)
  (define-key view-mode-map "p" 'isearch-repeat-backward)
  (define-key view-mode-map (kbd ": w") 'save-buffer)
  (define-key view-mode-map (kbd ": q") 'kill-current-buffer)
  )
;;  "E"     #'View-exit-and-edit
;;  "q"     #'View-quit
;;  ">"     #'end-of-buffer
;;  "<"     #'beginning-of-buffer
;;  "g"     #'View-goto-line  (nnn g:goto nnn / g:goto end)
;;  "s"     #'isearch-forward
;;  "r"     #'isearch-backward
;;  "."     #'set-mark-command
;;  "x"     #'exchange-point-and-mark

(defun ak-revert-buffer-noconfirm()
  "read file into buffer again without confirm." (interactive)
  (revert-buffer nil t t))
;;;;(revert-buffer &optional IGNORE-AUTO NOCONFIRM PRESERVE-MODES)

(defun ak-View-scroll-to-buffer-end()
  "scroll to buffer end and go to point max." (interactive "^")
  (View-scroll-to-buffer-end) (goto-char (point-max)))

;;====================================
;;;; s-: ispell
;;====================================
;; brew install hunspell
;; download "en_US.dic" and "en_US.aff" from
;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/
(setq-default ispell-program-name "hunspell")

(or (getenv "DICTIONARY") (setenv "DICTIONARY" "en_US")) ;;default dictionary
;;(or (getenv "DICPATH")
;;    (setenv "DICPATH" (concat (getenv "HOME") "/Library/Spelling")))

(with-eval-after-load "ispell"
  (setq ispell-dictionary (getenv "DICTIONARY"))
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;;(add-hook 'latex-mode-hook 'flyspell-mode)

;;====================================
;;;;abbrev-mode
;;====================================
;; s-E  edit-abbrevs
;;(setq save-abbrevs 'silently)
(setq save-abbrevs t)
(global-set-key (kbd "C-'") 'expand-abbrev)
;; 1. from in-file words.
;; M-/    dabbrev-expand        autoM-/ M-/ M-/..
;; C-M-/  dabbrev-completion    too short: "Selecting deleted buffer" message(bug?)
;;
;; 2. register words
;; longlongwordC-x a l  add-mode-abbrev    or   C-x a g   add-global-abbrev
;; Mode abbrev that expands into "longlongword": llw
;; llwC-x '  =>  llwC-'    expand-abbrev
;;
;; M-x define-mode-abbrev   or M-x define-global-abbrev
;; Define mode abbrev: rfm
;; Expansion for rfm: read-from-minibuffer
;; rfmC-'
;;
;; 3. M-x abbev-mode
;; llwSPACE
;; rfmSPACE
;; https://www.math.s.chiba-u.ac.jp/~matsu/emacs/emacs21/abbrev.html

;;====================================
;;;;go-mode
;;====================================
;; (autoload 'go-mode "~/.emacs.d/site-lisp/go-mode.el" nil t)
;; ;;   
;; (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))


;;====================================
;;;;yaml-mode
;;====================================
;; (autoload 'yaml-mode "~/.emacs.d/site-lisp/yaml-mode.el" nil t)
;; ;;
;; (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


;;====================================
;;;;markdown-mode
;;====================================
;; M-x package-install RET markdown-mode RET
;; M-x package-install RET markdown-preview-mode RET

;;(require 'markdown-mode "markdown-mode.el" t)
;; M-x markdown-live-preview-mode
;; C-c C-c l

(when (fboundp 'markdown-mode)
  ;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  ;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

  (add-hook 'markdown-mode-hook
	    (lambda ()
	      ;;(setq markdown-command "markdown")  ;;default legacy command
	      ;;(setq markdown-command-needs-filename nil) ;;default=nil:stdin t:filename
	      (setq markdown-preview-stylesheets
		    (list "~/.emacs.d/css/md.css")
		    ;;(list "~/.emacs.d/markdown/Clearness.css")
		    ;;(list "~/.emacs.d/markdown/Solarized(Dark).css")
		    ;;(list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css")
		    )
	      ;; markdown preview mode
	      ;; M-x markdown-preview-mode
	      (local-set-key (kbd "C-c p") 'markdown-preview-mode)
	      )))

;;====================================
;;;; elpy  python developing environment
;;====================================

;; error in process sentinel: elpy-rpc--default-error-callback: peculiar error: "exited abnormally with code 1"
;; M-x elpy-rpc-reinstall-virtualenv

;;;; comment for 1 sec
;; (if (fboundp 'elpy-enable)
;;     (elpy-enable))

;;====================================
;;;; git
;;====================================

;; ;; VC (version control) is standard lisp package.
;; ;; Cancel .git check when no "git" command installed.
;; (setq vc-handled-backends nil)


;;====================================
;;;; org-mode
;;====================================

;; # shift-selection in org-mode
;; nil      : no
;; t        : except on headline, list, property, BEGIN in clock table, table, timestamp
;; "always" : except on timestamp
(setq org-support-shift-select t)

(autoload 'buffer-focus-in-callback  "~/.emacs.d/site-lisp/buffer-focus-hook")

(defun ak-org-focus-in ()
  (message "no xcv."))

(defun ak-org-focus-out ()
  (message "xcv enable.")
  t)

(add-hook 'org-mode-hook
	  (lambda()
	    (setq-local cua-enable-cua-keys nil)
	    (buffer-focus-in-callback 'ak-org-focus-in)
	    (buffer-focus-out-callback 'ak-org-focus-out)
	    (local-set-key (kbd "C-y") 'org-yank)
	    ))

;; ------ 09org.el ------

(global-set-key (kbd "C-c l") 'org-store-link)
;; (setq org-startup-with-inline-images t)

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(eval-after-load "org"
  '(require 'ox-md nil t))

;;+++++++++++++++++++++++
(setq org-todo-keywords
      '((sequence "SOMEDAY" "TODO" "DOING" "|" "DONE" "CANCELLED"))
      ;;'((sequence "TODO" "|" "DONE")) ;;;; default
      )
;;
;; or, in org file
;;#+TODO: TODO DOING | DONE CANCELLED

;; org-todo
;; http://emacs.rubikitch.com/sd1502-org-mode/
;;
;; org-captureで2種類のメモを扱うようにする
(setq org-capture-templates
      '(("t" "New TODO" entry
         (file+headline "~/org/todo.org" "やること") "* TODO %U これやろう%?\n\n")
        ("m" "Memo" entry
         (file+headline "~/org/memo.org" "メモ") "* %U なんのメモ?%?\n関連ファイル=%F")
	))
;; %T <active timestamp>    as C-c .
;; %U [inactive timestamp]  as C-c !

;; org-agendaでaを押したら予定表とTODOリストを表示
(setq org-agenda-custom-commands
      '(
	("a" "Agenda and TODO" ((agenda "")(alltodo "")))
	))
;; org-agendaで扱うファイル/ディレクトリは複数可
(setq org-agenda-files '(
			 "~/org/todo.org"
			 "~/org/todos/"
			 "~/org/idol/"
			 "~/org/"
			 ))

;; TODOリストにアクティブな日付がついているTODOを表示しない
(setq org-agenda-todo-ignore-with-date t)
;; 今日から予定を表示させる
(setq org-agenda-start-on-weekday nil)

;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook #'(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;; DONEの時刻を記録
(setq org-log-done 'time)



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
(defun ak-scroll-page-backward (&optional arg)
  "scroll down = Page Up"
  (interactive "^P")
  (if (= (point-min) (point))
      (message "Beginning of buffer.")
    (if (ak-first-page-p)
        (goto-char (point-min))
      (scroll-down arg)
      )
    )
  )
;; basic scroll-up
(defun ak-scroll-page-forward (&optional arg)
  "scroll up = Page Down"
  (interactive "^P")
  (if (= (point-max) (point))
      (message "End of buffer.")
    ;;else
    (if (ak-last-page-p)
        (goto-char (point-max))
      ;;else
      (scroll-up arg)
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

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

;; overwridden by cua-mode
;;;;  ;; no cua-mode  cut/paste=C-w C-v  copy/paste=M-w M-v
;;;;  (global-set-key (kbd "M-v") 'yank) ;; C-y
;;;;  (global-set-key (kbd "C-v") 'yank) ;; C-y
(global-set-key (kbd "C-z") 'undo) ;; C-x C-z  ^Z ..fg

;;                    M-f10       'toggle-frame-maximized
;;                    f11         'toggle-frame-fullscreen  ;; -> M-f11
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
;;;; terminal send control+option up for command up
;;(define-key input-decode-map "\e[1;7A" (kbd "s-<up>"))
;;(define-key input-decode-map "\e[1;8A" (kbd "s-S-<up>"))
;;(define-key input-decode-map "\e[1;7B" (kbd "s-<down>"))
;;(define-key input-decode-map "\e[1;8B" (kbd "s-S-<down>"))
;;(define-key input-decode-map "\e[1;7C" (kbd "s-<right>"))
;;(define-key input-decode-map "\e[1;8C" (kbd "s-S-<right>"))
;;(define-key input-decode-map "\e[1;7D" (kbd "s-<left>"))
;;(define-key input-decode-map "\e[1;8D" (kbd "s-S-<left>"))
;;(define-key input-decode-map "\e[5;7~" (kbd "s-<prior>"))
;;(define-key input-decode-map "\e[5;8~" (kbd "s-S-<prior>"))
;;(define-key input-decode-map "\e[6;7~" (kbd "s-<next>"))
;;(define-key input-decode-map "\e[6;8~" (kbd "s-S-<next>"))
;;;; terminal send Esc s up for command up
(define-key input-decode-map "\es\eOA" (kbd "s-<up>"))
(define-key input-decode-map "\es\eOB" (kbd "s-<down>"))
(define-key input-decode-map "\es\eOC" (kbd "s-<right>"))
(define-key input-decode-map "\es\eOD" (kbd "s-<left>"))
(define-key input-decode-map "\es\e[1;2A" (kbd "s-S-<up>"))
(define-key input-decode-map "\es\e[1;2B" (kbd "s-S-<down>"))
(define-key input-decode-map "\es\e[1;2C" (kbd "s-S-<right>"))
(define-key input-decode-map "\es\e[1;2D" (kbd "s-S-<left>"))



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
;;;;  (global-set-key (kbd "s-c") 'kill-ring-save) ;;Terminal
(global-set-key (kbd "s-c") 'ns-copy-including-secondary) ;;Xwindow
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-y") 'ns-paste-secondary) ;;Xwindow

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
(global-set-key (kbd "s-ち") 'mark-whole-buffer)
(global-set-key (kbd "s-り") 'goto-line)
(global-set-key (kbd "s-ー") 'shell-command-on-region)
(global-set-key (kbd "s-・") 'info)

(global-set-key (kbd "s-つ") 'undo)
(global-set-key (kbd "s-さ") 'kill-region)
(global-set-key (kbd "s-そ") 'ns-copy-including-secondary) ;;kill-ring-save)
(global-set-key (kbd "s-ひ") 'yank)
(global-set-key (kbd "s-ん") 'ns-paste-secondary)

(global-set-key (kbd "s-の") 'kill-current-buffer)
(global-set-key (kbd "s-と") 'save-buffer)
(global-set-key (kbd "s-な") 'revert-buffer)

(global-set-key (kbd "s-み") 'make-frame)
(global-set-key (kbd "s-て") 'delete-frame)
(global-set-key (kbd "s-ゃ") 'next-window-any-frame) ;; 0x27 '
(global-set-key (kbd "s-へ") 'other-frame)	     ;; 0x60 `
;;(global-set-key (kbd "s-゛") 'ns-prev-frame)	     ;; 0x7E ~
(global-set-key (kbd "s-゛") 'ak-prev-frame)

(global-set-key (kbd "s-し") 'isearch-repeat-backward)
(global-set-key (kbd "s-は") 'isearch-forward)
(global-set-key (kbd "M-s-は") 'isearch-forward-regexp)
(global-set-key (kbd "s-き") 'isearch-repeat-forward)
(global-set-key (kbd "s-い") 'isearch-yank-kill)
(global-set-key (kbd "s-ま") 'exchange-point-and-mark)






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
(global-set-key [C-up]   #'(lambda()(interactive "^")(scroll-down 1)(previous-line 1)))
(global-set-key [C-down] #'(lambda()(interactive "^")(scroll-up   1)(next-line     1)))
(global-set-key [s-up]   #'(lambda()(interactive "^")(scroll-down 4)(previous-line 4)))
(global-set-key [s-down] #'(lambda()(interactive "^")(scroll-up   4)(next-line     4)))
(global-set-key (kbd "<wheel-up>")  #'(lambda()(interactive)(scroll-down 2)))
(global-set-key (kbd "<wheel-down>")  #'(lambda()(interactive)(scroll-up 2)))


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
;;   'beginning-of-buffer-other-window  M-<home>
;;   'end-of-buffer-other-window        M-<end>
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
		 (next-line 1))
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

(global-set-key (kbd "s-<left>")  'ak-cursor-top)
(global-set-key (kbd "s-<right>") 'ak-cursor-bottom)
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
          (message "scroll down")
          (scroll-down)
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
(global-set-key (kbd "C-a") 'ak-home-toggle)
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

;;====================================
;;;; begining/end of buffer/line(shift)
;;====================================
(global-set-key [C-home]  'beginning-of-buffer)
(global-set-key [C-end]   'end-of-buffer)
(global-set-key [home]  'ak-beginning-of-buffer)
(global-set-key [end]   'ak-end-of-buffer)
(defun ak-beginning-of-buffer(&optional arg)
  "set cursor at beginning of buffer or line(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (ak-home-toggle)
    (beginning-of-buffer arg)
  ))
(defun ak-end-of-buffer(&optional arg)
  "set cursor at end of buffer or line(shift)"
  (interactive "^")
  (if this-command-keys-shift-translated
      (move-end-of-line arg)
    (end-of-buffer arg)
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
  (next-line 1))

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
;; edit filename in dired mode
(require 'wdired)
(require 'dired-x)
(setq dired-clean-up-buffers-too nil)
;; S            dired-do-symlink
;; Y            dired-do-relsymlink
(define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)
(define-key dired-mode-map "h" #'(lambda()(interactive)(dired "~")))
(define-key dired-mode-map "r" #'(lambda()(interactive)(dired "/")))
(define-key dired-mode-map "z" #'(lambda()(interactive)(dired dired-default-directory)))
;; avoid remapping to dired-next(previous)-line
(defalias 'ak-dired-next-line 'next-line)
(defalias 'ak-dired-previous-line 'previous-line)
(define-key dired-mode-map "\C-n" 'ak-dired-next-line)
(define-key dired-mode-map "\C-p" 'ak-dired-previous-line)
;; keep cursor on file name
(define-key dired-mode-map [C-up]   #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [C-down] #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-up 1)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [s-up]   #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-down 4)(move-to-window-line pos0)(dired-next-line 0))))
(define-key dired-mode-map [s-down] #'(lambda()(interactive "^")
			     (let ( (pos0 (current-line)) )
			       (scroll-up 4)(move-to-window-line pos0)(dired-next-line 0))))
(and (setq a-directory (getenv "A_DIRECTORY")) (define-key dired-mode-map "a" #'(lambda()(interactive)(dired a-directory))))
(and (setq b-directory (getenv "B_DIRECTORY")) (define-key dired-mode-map "b" #'(lambda()(interactive)(dired b-directory))))
(and (setq c-directory (getenv "C_DIRECTORY")) (define-key dired-mode-map "c" #'(lambda()(interactive)(dired c-directory))))
(and (setq e-directory (getenv "E_DIRECTORY")) (define-key dired-mode-map "e" #'(lambda()(interactive)(dired e-directory))))
;;                         ">" 'dired-next-dirline
;;                         "<" 'dired-previous-dirline
(setq dired-default-directory default-directory)

;; Auto revert files when they change
(global-auto-revert-mode t)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;;(setq auto-revert-interval 5) ;;default

(setq dired-mode-hook
      '(lambda ()
         ;;(dired-omit-mode 1)
         (setq truncate-lines 1)
         (local-set-key [right]   'ak-dired-find-file)          ;; -> f
         (local-set-key [left]    'ak-dired-up-directory)       ;; <- ^
         (local-set-key [home]    'ak-dired-beginning-of-buffer)
         (local-set-key [end]     'ak-dired-end-of-buffer)
         (local-set-key [prior]   'ak-dired-scroll-down)
         (local-set-key [next]    'ak-dired-scroll-up)
         (local-set-key [f5]      'revert-buffer)               ;; g
         ;; (local-set-key "\M-s" 'shell)                          ;;emacs23  override M-s prefix
         (local-set-key "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
         ))
(defun ak-dired-find-file (&optional arg)
  "find file or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (forward-char arg)
    ;else
    (dired-find-file)
    )
  )
(defun ak-dired-up-directory (&optional arg)
  "up directory or select char."
  (interactive "^p")
  (if this-command-keys-shift-translated
      (backward-char arg)
    ;else
    (dired-up-directory)
    )
  )

(defun ak-dired-beginning-of-buffer(&optional arg)
  "in dired set cursor at first file"
  (interactive "^p")
  (if this-command-keys-shift-translated
      (move-beginning-of-line arg)
    ;(setq mark-active nil)
    (goto-char (point-min))
    (dired-next-line 4))
  )
(defun ak-dired-end-of-buffer(&optional arg)
  "in dired set cursor at last file"
  (interactive "^p")
  (if this-command-keys-shift-translated
      (move-end-of-line arg)
    ;(setq mark-active nil)
    (goto-char (point-max))
    (dired-previous-line 1))
  )

(defun ak-dired-scroll-down ()
  "Page up and set cursor at file"
  (interactive "^")
  (if (ak-first-page-p)
      (progn
        (move-to-window-line 0)
        (dired-next-line 4))
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
(global-set-key [S-f5]  #'(lambda()(interactive)(dired ".")))

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
(global-set-key [S-f9] #'(lambda()(interactive)
                          (if case-fold-search
                              (progn (setq-default case-fold-search nil)(message "case sensitive Search mode"))
                            (progn (setq-default case-fold-search t)(message "ignore case Search mode")))
                          ))

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
;; (global-set-key (kbd "M-s") 'shell) ;; M-x shell
;; M-x shell  ==>  M-x s
(defalias 's 'shell)

(setq shell-mode-hook
      '(lambda ()
         ;; comint 関係の設定
         (setq shell-dirstack-query "pwd")
         (setq comint-process-echoes t)
         (setq comint-input-autoexpand nil)
                                        ;(setq comint-input-autoexpand 'input)
                                        ;(setq comint-input-autoexpand 'history)
         (setq comint-scroll-to-bottom-on-input t)
                                        ;(setq comint-scroll-to-bottom-on-output t)
         (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
	 (dirtrack-mode)
         ))

(load "~/.emacs.d/site-lisp/tails-comint-history.el")

(define-key shell-mode-map  [f5]     #'(lambda()(interactive)(dirs)))
(define-key comint-mode-map [home]   'beginning-of-buffer)
(define-key comint-mode-map [end]    'end-of-buffer)
(define-key comint-mode-map [C-up]   #'(lambda()(interactive)(scroll-down 1)))
(define-key comint-mode-map [C-down] #'(lambda()(interactive)(scroll-up 1)))
(define-key comint-mode-map [up]     'ak-shell-up)
(define-key comint-mode-map [down]   'ak-shell-down)
(defun ak-shell-down ()
  "next command by down arrow at shell mode."
  (interactive "^")
  (if (= (point-max) (point))
      (tails-comint-next-input)  ;(comint-next-input 1)
    (next-line)))

(defun ak-shell-up ()
  "prev command by up arrow at shell mode."
  (interactive "^")
  (if (= (point-max) (point))
      (tails-comint-previous-input)     ;(comint-previous-input 1)
    (previous-line)))

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

;; Auto revert files when they change
(global-auto-revert-mode t)
;; Also auto refresh buffer list and dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;;(setq auto-revert-interval 5) ;;default

;;(defun list-buffers-if-exist()
;;  (and (get-buffer "*Buffer List*") (get-buffer-window (get-buffer "*Buffer List*")) (list-buffers)))
(defun list-buffers-if-exist()
  (let ((buflist (get-buffer "*Buffer List*"))
	(orgint auto-revert-interval))
    (if buflist
	(if (get-buffer-window buflist)
	    (list-buffers)
	  ;;else
	  (if (get-buffer-window-list buflist nil t)
	      (progn
		;; Update Buffer List on other frame
		(setq auto-revert-interval 0.1)
		(auto-revert-set-timer)
		(setq auto-revert-interval orgint))
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

(defadvice quit-window (after AK-quit-window )
  "Quit window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'quit-window)

(defadvice bury-buffer (after AK-bury-buffer )
  "Quit window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'bury-buffer)

(defadvice switch-to-buffer (after AK-switch-to-buffer )
  "Switch window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'switch-to-buffer)

;; (defadvice delete-window (after AK-delete-window )
;;   "Delete window and change buffer-list."
;;   (list-buffers-if-exist))
;; (ad-activate 'delete-window)

(defadvice find-file (after AK-find-file )
  "Find-File and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'find-file)

;; (defadvice view-file (after AK-view-file )
;;   "View-File and change buffer-list."
;;   (list-buffers-if-exist))
;; (ad-activate 'view-file)

;;(setq ad-redefinition-action 'accept)
(defadvice shell (after AK-shell)
  "M-x shell"
  (list-buffers-if-exist))
(ad-activate 'shell)

;; (defadvice dired-find-file-hexl (after AK-dired-find-file-hexl )
;;   "Find-File-Hexl and change buffer-list."
;;   (list-buffers-if-exist))
;; (ad-activate 'dired-find-file-hexl)

(defadvice dired (after AK-dired )
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'dired)

(defadvice info (after AK-info )
  "Enter Info, the documentation browser."
  (list-buffers-if-exist))
(ad-activate 'info)



;; ------ 08mode.el ------

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;;view-mode
;;====================================
(require 'view)
(define-key view-mode-map [f5] #'(lambda()(interactive)(revert-buffer nil t t)))


;;====================================
;;;;bash-completion
;;====================================
;;(load "~/.emacs.d/site-lisp/bash-completion.el")


;;====================================
;;;;go-mode
;;====================================
;;(load "~/.emacs.d/site-lisp/go-mode.el")
(require 'go-mode)
;;   
;;  (autoload 'go-mode "go-mode" nil t)
;;  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))


;;====================================
;;;;yaml-mode
;;====================================
(require 'yaml-mode)


;;====================================
;;;;markdown-mode
;;====================================
;; M-x package-install RET markdown-mode RET
;; M-x package-install RET markdown-preview-mode RET

;;(require 'markdown-mode "markdown-mode.el" t)
;; M-x markdown-live-preview-mode
;; C-c C-c l
(if (fboundp 'markdown-mode)
    (progn
      (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
      (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
      (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

      (setq markdown-command "markdown")  ;;default legacy command

      (setq markdown-mode-hook
	    '(lambda ()
	       (setq markdown-command-needs-filename t)
	       ;; markdown preview mode
	       ;; M-x markdown-preview-mode
	       (define-key markdown-mode-map (kbd "C-c p") 'markdown-preview-mode)
	       (setq markdown-preview-stylesheets
		     (list "~/.emacs.d/css/md.css")
		     ;;(list "~/.emacs.d/markdown/Clearness.css")
		     ;;(list "~/.emacs.d/markdown/Solarized(Dark).css")
		     ;;(list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css")
		     )
	       ))))

;;====================================
;;;; elpy  python developing environment
;;====================================

;; error in process sentinel: elpy-rpc--default-error-callback: peculiar error: "exited abnormally with code 1"
;; M-x elpy-rpc-reinstall-virtualenv

(if (fboundp 'elpy-enable)
    (elpy-enable))

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

(require 'buffer-focus-hook)

(defun ak-org-focus-in ()
  (message "no xcv."))

(defun ak-org-focus-out ()
  (message "xcv enable.")
  t)

(add-hook 'org-mode-hook (lambda()
			   (setq-local cua-enable-cua-keys nil)
			   ;;           C-y is not cua-paste but org-yank
			   (define-key org-mode-map (kbd "C-y") 'org-yank)
			   ;;(define-key org-mode-map (kbd "C-c C-SPC") 'cua-set-rectangle-mark)
			   (buffer-focus-in-callback 'ak-org-focus-in)
			   (buffer-focus-out-callback 'ak-org-focus-out)
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

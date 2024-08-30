


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




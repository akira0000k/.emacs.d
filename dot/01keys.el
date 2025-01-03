


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

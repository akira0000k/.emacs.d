


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
(define-key input-decode-map (kbd "s-¥") (kbd "s-\\"))

;;;; delete key sequence is...
;;(define-key input-decode-map "\e[3~" (kbd "<deletechar>")) ;;delete-forward-char
;;(define-key input-decode-map "\e[3;2~" (kbd "S-<delete>")) ;;kill-region
;;(define-key input-decode-map "\e[3;3~" (kbd "M-<delete>"))
;;(define-key input-decode-map "\e[3;4~" (kbd "M-S-<delete>"))
;;(define-key input-decode-map "\e[3;5~" (kbd "C-<delete>")) ;;kill-word
;;(define-key input-decode-map "\e[3;6~" (kbd "C-S-<delete>"))
;;(define-key input-decode-map "\e[3;7~" (kbd "C-M-<delete>")) ;;backword-kill-sexp
;;(define-key input-decode-map "\e[3;8~" (kbd "C-M-S-<delete>"))

;;;; new BackSpace key sequence.
;; DEL (127) backward-delete-char-untabify
(define-key input-decode-map "\e[27;2;127~" (kbd "S-<backspace>"))
;; M-DEL (255) backward-kill-word
(define-key input-decode-map "\e[27;4;127~" (kbd "M-S-DEL"))
(define-key input-decode-map "\e[27;5;127~" (kbd "C-<backspace>")) ;;backword-kill-word
(define-key input-decode-map "\e[27;6;127~" (kbd "C-S-<backspace>")) ;;kill-whole-line
(define-key input-decode-map "\e[27;7;127~" (kbd "C-M-<backspace>")) ;;backword-kill-sexp
(define-key input-decode-map "\e[27;8;127~" (kbd "C-M-S-<backspace>"))

;;;; TAB
;; TAB (9)             indent-for-tab-command              ;;magit-section-toggle
;; S-TAB     M-[ Z     <backtab>                           ;;magit-section-cycle-global
(define-key input-decode-map "\e[27;3;9~" (kbd "M-<tab>")) ;;magit-section-cycle-diffs
(define-key input-decode-map "\e[27;4;9~" (kbd "M-S-<tab>"))
;;efine-key input-decode-map "\e[27;5;9~" (kbd "C-<tab>")) ;;magit-section-cycle
;;efine-key input-decode-map "\e[27;6;9~" (kbd "C-S-<tab>")) ;;previous-window-any-frame(me)
;;efine-key input-decode-map "\e[27;7;9~" (kbd "C-M-<tab>"))
(define-key input-decode-map "\e[27;8;9~" (kbd "C-M-S-<tab>"))

;;;; RET
;; RET (13)       newline
;;efine-key input-decode-map "\e[27;2;13~" (kbd "S-<return>"))
;; M-RET (141)
(define-key input-decode-map "\e[27;4;13~" (kbd "M-S-RET"))
;;efine-key input-decode-map "\e[27;5;13~" (kbd "C-<return>")) ;;cua-set-rectangle-mark~
;;efine-key input-decode-map "\e[27;6;13~" (kbd "C-S-<return>"))
;;efine-key input-decode-map "\e[27;7;13~" (kbd "C-M-<return>"))
(define-key input-decode-map "\e[27;8;13~" (kbd "C-M-S-<return>"))

;;  S-SPC is backward SPC.
;; SPC (32)
(define-key input-decode-map "\e[27;2;32~" (kbd "S-SPC")) ;;ak-scroll-page-backward(view)
;; M-SPC (160)
(define-key input-decode-map "\e[27;4;32~" (kbd "M-S-SPC"))
;; C-SPC    C-@ (0)                                         ;;set-mark
(define-key input-decode-map "\e[27;6;32~" (kbd "C-S-SPC")) ;;cua-toggle-global-mark
;;efine-key input-decode-map "\e[27;7;32~" (kbd "C-M-SPC")) ;;mark-sexp
(define-key input-decode-map "\e[27;8;32~" (kbd "C-M-S-SPC"))

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
(global-set-key (kbd "s-:") 'ispell)
(global-set-key (kbd "s-E") 'edit-abbrevs)

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
(global-set-key (kbd "s-^") 'kill-some-buffers)

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
(define-key input-decode-map (kbd "s-け") (kbd "s-:"))	    ;;ispell
(define-key input-decode-map (kbd "s-ぃ") (kbd "s-E"))	    ;;edit-abbrevs
							     
(define-key input-decode-map (kbd "s-つ") (kbd "s-z"))	    ;;undo
(define-key input-decode-map (kbd "s-さ") (kbd "s-x"))	    ;;kill-region
(define-key input-decode-map (kbd "s-そ") (kbd "s-c"))	    ;;ns-copy-including-secondary / kill-ring-save
(define-key input-decode-map (kbd "s-ひ") (kbd "s-v"))	    ;;yank
(define-key input-decode-map (kbd "s-ん") (kbd "s-y"))	    ;;ns-paste-secondary
							     
(define-key input-decode-map (kbd "s-の") (kbd "s-k"))	    ;;kill-current-buffer
(define-key input-decode-map (kbd "s-と") (kbd "s-s"))	    ;;save-buffer
(define-key input-decode-map (kbd "s-な") (kbd "s-u"))	    ;;revert-buffer
(define-key input-decode-map (kbd "s-へ") (kbd "s-^"))	    ;;kill-some-buffers
							     
(define-key input-decode-map (kbd "s-み") (kbd "s-n"))	    ;;make-frame
(define-key input-decode-map (kbd "s-て") (kbd "s-w"))	    ;;delete-frame
(define-key input-decode-map (kbd "s-ゃ") (kbd "s-'"))	    ;;next-window-any-frame
(define-key input-decode-map (kbd "s-゛") (kbd "s-`"))	    ;;other-frame

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

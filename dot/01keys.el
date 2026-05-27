;; ------ 01keys.el ------ ;;; -*- lexical-binding: t; -*-

;;====================================
;;;; Teraterm End key = <select>
;;====================================
(keymap-set input-decode-map "ESC [ 1 ~" "<home>")   ;;<find> to <home>  (screen)
(keymap-set input-decode-map "ESC [ 4 ~" "<end>")    ;;<select> to <end>  (NumLock-off 1)
(keymap-set input-decode-map "ESC [ 3 ~" "<deletechar>")   ;;vscode delete key was DEL

;;  MAC OSX  default reversed by kbd setting   ¥-->\   fn ¥-->¥
;;      but C-\  M-\  ...ng
(keymap-set input-decode-map "M-¥" "M-\\")
;;      for emacs.app    terminal->no need
(keymap-set input-decode-map "C-¥" "C-\\")
(keymap-set input-decode-map "s-¥" "s-\\")

;;;; delete key sequence is...
;;(ak-input-decode-set "\e[3~" "<deletechar>") ;;delete-forward-char
;;(ak-input-decode-set "\e[3;2~" "S-<delete>") ;;kill-region
;;(ak-input-decode-set "\e[3;3~" "M-<delete>")
;;(ak-input-decode-set "\e[3;4~" "M-S-<delete>")
;;(ak-input-decode-set "\e[3;5~" "C-<delete>") ;;kill-word
;;(ak-input-decode-set "\e[3;6~" "C-S-<delete>") ;;kill-whole-line(me)
;;(ak-input-decode-set "\e[3;7~" "C-M-<delete>") ;;backword-kill-sexp
;;(ak-input-decode-set "\e[3;8~" "C-M-S-<delete>")

;;;; new BackSpace key sequence.
;; DEL (127) backward-delete-char-untabify
(ak-input-decode-set "\e[27;2;127~" "S-<backspace>")
;; M-DEL (255) backward-kill-word
(ak-input-decode-set "\e[27;4;127~" "M-S-DEL")
(ak-input-decode-set "\e[27;5;127~" "C-<backspace>") ;;backword-kill-word
(ak-input-decode-set "\e[27;6;127~" "C-S-<backspace>") ;;kill-whole-line
(ak-input-decode-set "\e[27;7;127~" "C-M-<backspace>") ;;backword-kill-sexp
(ak-input-decode-set "\e[27;8;127~" "C-M-S-<backspace>")

;;(ak-input-decode-set "\xff" "M-DEL") ;; M-DEL (255) backward-kill-word
;;(ak-input-decode-set "\x09" "T")TT

;;;; TAB
;; TAB (9)             indent-for-tab-command              ;;magit-section-toggle
;; S-TAB     M-[ Z     <backtab>                           ;;magit-section-cycle-global
(ak-input-decode-set "\e[27;3;9~" "M-<tab>") ;;magit-section-cycle-diffs
(ak-input-decode-set "\e[27;4;9~" "M-S-<tab>")
;;(ak-input-decode-set "\e[27;5;9~" "C-<tab>") ;;magit-section-cycle
;;(ak-input-decode-set "\e[27;6;9~" "C-S-<tab>") ;;previous-window-any-frame(me)
;;(ak-input-decode-set "\e[27;7;9~" "C-M-<tab>")
(ak-input-decode-set "\e[27;8;9~" "C-M-S-<tab>")

;;;; RET
;; RET (13)       newline
;;(ak-input-decode-set "\e[27;2;13~" "S-<return>")
;; M-RET (141)
(ak-input-decode-set "\e[27;4;13~" "M-S-RET")
;;(ak-input-decode-set "\e[27;5;13~" "C-<return>") ;;cua-set-rectangle-mark~
;;(ak-input-decode-set "\e[27;6;13~" "C-S-<return>")
;;(ak-input-decode-set "\e[27;7;13~" "C-M-<return>")
(ak-input-decode-set "\e[27;8;13~" "C-M-S-<return>")

;;  S-SPC is backward SPC.
;; SPC (32)
(ak-input-decode-set "\e[27;2;32~" "S-SPC") ;;ak-scroll-page-backward(view)
;; M-SPC (160)
(ak-input-decode-set "\e[27;4;32~" "M-S-SPC")
;; C-SPC    C-@ (0)                                         ;;set-mark
(ak-input-decode-set "\e[27;6;32~" "C-S-SPC") ;;cua-toggle-global-mark
;;(ak-input-decode-set "\e[27;7;32~" "C-M-SPC") ;;mark-sexp
(ak-input-decode-set "\e[27;8;32~" "C-M-S-SPC")

;;  MAC OSX iTerm2
;;  C-SPC:0x00 C-@:M-[27;5;64~ for set-mark
;;  C-7:0x1f   C-_:M-[27;5;95~ for undo

;; 5: Control
(ak-input-decode-set "\e[27;5;64~" "C-@")
(ak-input-decode-set "\e[27;5;94~" "C-^")
(ak-input-decode-set "\e[27;5;95~" "C-_")
;; 6: Control + shift
(ak-input-decode-set "\e[27;6;96~" "C-`")
(ak-input-decode-set "\e[27;6;123~" "C-{")
(ak-input-decode-set "\e[27;6;124~" "C-|")
(ak-input-decode-set "\e[27;6;125~" "C-}")
(ak-input-decode-set "\e[27;6;126~" "C-~")
;; 7: Control + Meta
(ak-input-decode-set "\e[27;7;64~" "C-M-@")
(ak-input-decode-set "\e[27;7;94~" "C-M-^")
(ak-input-decode-set "\e[27;7;95~" "C-M-_")
;; 8: Control + Meta + Shift
(ak-input-decode-set "\e[27;8;96~" "C-M-`")
(ak-input-decode-set "\e[27;8;123~" "C-M-{")
(ak-input-decode-set "\e[27;8;124~" "C-M-|")
(ak-input-decode-set "\e[27;8;125~" "C-M-}")
(ak-input-decode-set "\e[27;8;126~" "C-M-~")
;; 9: super
(ak-input-decode-set "\e[27;9;39~" "s-'")
(ak-input-decode-set "\e[27;9;93~" "s-]")
(ak-input-decode-set "\e[27;9;94~" "s-^")
(ak-input-decode-set "\e[27;9;125~" "s-}")
;; 10: Shift + super
(ak-input-decode-set "\e[27;10;58~" "s-:")
(ak-input-decode-set "\e[27;10;63~" "s-?")
(ak-input-decode-set "\e[27;10;96~" "s-`")
(ak-input-decode-set "\e[27;10;124~" "s-|")
(ak-input-decode-set "\e[27;10;126~" "s-~")
;; 11: Meta + super
;; 12: Meta + Shift + super
;; 13: Control + super
;; 14: Control + Shift + super
;; 15: Control + Meta + super
;; 16: Control + Meta + Shift + super
;; US keyboard style    down(5 7 9) [' =]    shift(6 8 10) [:] 

;;====================================
;;;; Another modifier key after ESC   (for backward compatibility)
;;====================================
;; avoid confusing with Esc C-x => eval-defun (in elisp moode)
;; simple.el
;; (define-key function-key-map [?\C-x ?@ ?S] 'event-apply-shift-modifier)
;; (define-key function-key-map [?\C-x ?@ ?s] 'event-apply-super-modifier)

(keymap-set function-key-map "M-s @ S" 'event-apply-shift-modifier)
(keymap-set function-key-map "M-s @ s" 'event-apply-super-modifier)

;;;; Esc M-s @ S ^A   C-M-S-a	  Shift + beginning-of-defun
;;;; Esc M-s @ s f	M-s-f	  isearch-forward-regexp
;;;; Esc M-s @ s F	M-s-F	  isearch-backward-regexp


;;====================================
;;;; character code
;;====================================
;; n        (110 0x6e)
;; N        (48  0x4e)
;; M-n      (238 0xee)                  half-page-up(me)
;; M-N      (206 0xce)                  shifted
;; C-n      (14  0x0e)   ^N             next-line
;; (ak-input-decode-set "\e[27;6;110~" "C-S-n")
;; C-M-n    (142  0x8e)  ^M-N           ak-line-down(me)
;; (ak-input-decode-set "\e[27;8;110~" "C-M-S-n")
;; (ak-input-decode-set "\e[27;9;110~" "s-n")
;; (ak-input-decode-set "\e[27;10;102~" "s-F")
;; (ak-input-decode-set "\e[27;11;102~" "M-s-f")
;; (ak-input-decode-set "\e[27;12;102~" "M-s-F")
;; (ak-input-decode-set "\e[27;13;110~" "C-s-n")
;; (ak-input-decode-set "\e[27;14;110~" "C-S-s-n")
;;                      "\e[27;15;110~" "C-M-s-n"
;;			"\e[27;16;110~" "C-M-S-s-n"
;;;;;;;;;;;;;;;;;;;;;; all alphabet ;;;;;;;;;;;;;;;;;;;;;;;
(ak-input-decode-set "\e[27;6;97~" "C-S-a")
(ak-input-decode-set "\e[27;8;97~" "C-M-S-a")
(ak-input-decode-set "\e[27;9;97~" "s-a")
(ak-input-decode-set "\e[27;6;98~" "C-S-b")
(ak-input-decode-set "\e[27;8;98~" "C-M-S-b")
(ak-input-decode-set "\e[27;9;99~" "s-c")
(ak-input-decode-set "\e[27;8;100~" "C-M-S-d")
(ak-input-decode-set "\e[27;9;100~" "s-d")
(ak-input-decode-set "\e[27;10;100~" "s-D")
(ak-input-decode-set "\e[27;6;101~" "C-S-e")
(ak-input-decode-set "\e[27;8;101~" "C-M-S-e")
(ak-input-decode-set "\e[27;9;101~" "s-e")
(ak-input-decode-set "\e[27;10;101~" "s-E")
(ak-input-decode-set "\e[27;6;102~" "C-S-f")
(ak-input-decode-set "\e[27;8;102~" "C-M-S-f")
(ak-input-decode-set "\e[27;9;102~" "s-f")
(ak-input-decode-set "\e[27;10;102~" "s-F")
(ak-input-decode-set "\e[27;11;102~" "M-s-f")
(ak-input-decode-set "\e[27;12;102~" "M-s-F")
(ak-input-decode-set "\e[27;9;103~" "s-g")
;;(ak-input-decode-set "\e[27;9;104~" "s-h");;no
;;(ak-input-decode-set "\e[27;9;105~" "s-i");;no
(ak-input-decode-set "\e[27;9;106~" "s-j")
(ak-input-decode-set "\e[27;6;107~" "C-S-k")
(ak-input-decode-set "\e[27;9;107~" "s-k")
(ak-input-decode-set "\e[27;8;108~" "C-M-S-l")
(ak-input-decode-set "\e[27;9;108~" "s-l")
(ak-input-decode-set "\e[27;10;108~" "s-L")
(ak-input-decode-set "\e[27;10;109~" "s-M")
(ak-input-decode-set "\e[27;6;110~" "C-S-n")
(ak-input-decode-set "\e[27;8;110~" "C-M-S-n")
(ak-input-decode-set "\e[27;9;110~" "s-n")
(ak-input-decode-set "\e[27;13;110~" "C-s-n")
(ak-input-decode-set "\e[27;14;110~" "C-S-s-n")
;;(ak-input-decode-set "\e[27;9;111~" "s-o");;no
(ak-input-decode-set "\e[27;6;112~" "C-S-p")
(ak-input-decode-set "\e[27;8;112~" "C-M-S-p")
(ak-input-decode-set "\e[27;13;112~" "C-s-p")
(ak-input-decode-set "\e[27;14;112~" "C-S-s-p")
;;(ak-input-decode-set "\e[27;9;113~" "s-q");;no
;;(ak-input-decode-set "\e[27;9;114~" "s-r");;ignore
(ak-input-decode-set "\e[27;9;115~" "s-s")
;;(ak-input-decode-set "\e[27;9;116~" "s-t");;no
(ak-input-decode-set "\e[27;8;117~" "C-M-S-u")
(ak-input-decode-set "\e[27;9;117~" "s-u")
(ak-input-decode-set "\e[27;6;118~" "C-S-v")
(ak-input-decode-set "\e[27;8;118~" "C-M-S-v")
(ak-input-decode-set "\e[27;9;118~" "s-v")
(ak-input-decode-set "\e[27;6;119~" "C-S-w")
(ak-input-decode-set "\e[27;9;119~" "s-w")
(ak-input-decode-set "\e[27;9;120~" "s-x")
;;(ak-input-decode-set "\e[27;9;121~" "s-y");;ignore
(ak-input-decode-set "\e[27;9;122~" "s-z")

;;====================================
;;;; MAC OSX command key for iTerm2
;;====================================
(ak-input-decode-set "\e[1;9A" "s-<up>")
(ak-input-decode-set "\e[1;9B" "s-<down>")
(ak-input-decode-set "\e[1;9C" "s-<right>")
(ak-input-decode-set "\e[1;9D" "s-<left>")
(ak-input-decode-set "\e[1;10A" "S-s-<up>")
(ak-input-decode-set "\e[1;10B" "S-s-<down>")
(ak-input-decode-set "\e[1;10C" "S-s-<right>")
(ak-input-decode-set "\e[1;10D" "S-s-<left>")
(ak-input-decode-set "\e[1;13A" "C-s-<up>")
(ak-input-decode-set "\e[1;13B" "C-s-<down>")
(ak-input-decode-set "\e[1;14A" "C-S-s-<up>")
(ak-input-decode-set "\e[1;14B" "C-S-s-<down>")

;;====================================
;;;; MAC OSX command keys
;;====================================
;; MAC OSX command key + up down left right
(keymap-global-set "s-<up>"    'beginning-of-buffer)
(keymap-global-set "s-<down>"  'end-of-buffer)
(keymap-global-set "s-<left>"  'move-beginning-of-line)
(keymap-global-set "s-<right>" 'move-end-of-line)
(keymap-global-set "s-p" nil) ;;ns-print-buffer
(unless (equal (framep-on-display) 'ns)
  (keymap-global-set "s-c" 'kill-ring-save)) ;;Terminal

(unless (lookup-key global-map (kbd "s-a"))
  (message "global-set ns keys.")
  ;;     same as default
  (keymap-global-set "s-a" 'mark-whole-buffer)
  (keymap-global-set "s-l" 'goto-line)
  (keymap-global-set "s-D" 'dired)
  (keymap-global-set "s-M" 'manual-entry)
  (keymap-global-set "s-L" 'shell-command)
  (keymap-global-set "s-|" 'shell-command-on-region)
  (keymap-global-set "s-?" 'info)
  (keymap-global-set "s-:" 'ispell)
  (keymap-global-set "s-E" 'edit-abbrevs)

  (keymap-global-set "s-z" 'undo)
  (keymap-global-set "s-x" 'kill-region)
  (keymap-global-set "s-c" 'kill-ring-save) ;;Terminal
  (keymap-global-set "s-v" 'yank)
  ;;(keymap-global-set "s-c" 'ns-copy-including-secondary) ;;Xwindow
  ;;(keymap-global-set "s-y" 'ns-paste-secondary)) ;;Xwindow

  (keymap-global-set "s-k" 'kill-current-buffer)
  (keymap-global-set "s-s" 'save-buffer)
  (keymap-global-set "s-u" 'revert-buffer)
  (keymap-global-set "s-^" 'kill-some-buffers)

  (keymap-global-set "s-n" 'make-frame)
  (keymap-global-set "s-w" 'delete-frame)
  (keymap-global-set "s-'" 'next-window-any-frame) ;; 0x27 '
  (keymap-global-set "s-`" 'other-frame)	   ;; 0x60 `
  ;;(keymap-global-set "s-~" 'ns-prev-frame)	   ;; 0x7E ~
  (keymap-global-set "s-~" 'ak-prev-frame)

  (keymap-global-set "s-d" 'isearch-repeat-backward)
  (keymap-global-set "s-f" 'isearch-forward)
  (keymap-global-set "s-F" 'isearch-backward)
  (keymap-global-set "M-s-f" 'isearch-forward-regexp)
  (keymap-global-set "M-s-F" 'isearch-backward-regexp)
  (keymap-global-set "s-g" 'isearch-repeat-forward)
  (keymap-global-set "s-e" 'isearch-yank-kill)
  (keymap-global-set "s-j" 'exchange-point-and-mark)
  )
;;      HIRAGANA key
(keymap-set input-decode-map "s-ち" "s-a")	    ;;mark-whole-buffer
(keymap-set input-decode-map "s-り" "s-l")	    ;;goto-line
(keymap-set input-decode-map "s-ー" "s-|")	    ;;shell-command-on-region
(keymap-set input-decode-map "s-・" "s-?")	    ;;info
(keymap-set input-decode-map "s-け" "s-:")	    ;;ispell
(keymap-set input-decode-map "s-ぃ" "s-E")	    ;;edit-abbrevs
					    
(keymap-set input-decode-map "s-つ" "s-z")	    ;;undo
(keymap-set input-decode-map "s-さ" "s-x")	    ;;kill-region
(keymap-set input-decode-map "s-そ" "s-c")	    ;;ns-copy-including-secondary / kill-ring-save
(keymap-set input-decode-map "s-ひ" "s-v")	    ;;yank
(keymap-set input-decode-map "s-ん" "s-y")	    ;;ns-paste-secondary
					    
(keymap-set input-decode-map "s-の" "s-k")	    ;;kill-current-buffer
(keymap-set input-decode-map "s-と" "s-s")	    ;;save-buffer
(keymap-set input-decode-map "s-な" "s-u")	    ;;revert-buffer
(keymap-set input-decode-map "s-へ" "s-^")	    ;;kill-some-buffers
					    
(keymap-set input-decode-map "s-み" "s-n")	    ;;make-frame
(keymap-set input-decode-map "s-て" "s-w")	    ;;delete-frame
(keymap-set input-decode-map "s-ゃ" "s-'")	    ;;next-window-any-frame
(keymap-set input-decode-map "s-゛" "s-`")	    ;;other-frame

(keymap-set input-decode-map "s-し" "s-d")	    ;;isearch-repeat-backward
(keymap-set input-decode-map "s-は" "s-f")	    ;;isearch-forward
(keymap-set input-decode-map "M-s-は" "M-s-f")	    ;;isearch-forward-regexp
(keymap-set input-decode-map "s-き" "s-g")	    ;;isearch-repeat-forward
(keymap-set input-decode-map "s-い" "s-e")	    ;;isearch-yank-kill
(keymap-set input-decode-map "s-ま" "s-j")	    ;;exchange-point-and-mark

;; like iTerm M-s-q ==> send <C-x><C-c>
(keymap-set input-decode-map "M-s-q" "C-x C-c")
(keymap-set input-decode-map "M-s-た" "C-x C-c")

;;====================================
;;;; Allow Meta key in Kana mode.
;;====================================
(keymap-set input-decode-map "M-ち" "M-a")	;;backward-sentence
(keymap-set input-decode-map "M-こ" "M-b")	;;backward-word
(keymap-set input-decode-map "M-そ" "M-c")	;;capitalize-word
(keymap-set input-decode-map "M-し" "M-d")	;;kill-word
(keymap-set input-decode-map "M-い" "M-e")	;;forward-sentence
(keymap-set input-decode-map "M-は" "M-f")	;;forward-word
(keymap-set input-decode-map "M-く" "M-h")	;;mark-paragraph
(keymap-set input-decode-map "M-に" "M-i")	;;tab-to-tab-stop
(keymap-set input-decode-map "M-ま" "M-j")	;;default-indent-new-line
(keymap-set input-decode-map "M-の" "M-k")	;;kill-sentence
(keymap-set input-decode-map "M-り" "M-l")	;;downcase-word
(keymap-set input-decode-map "M-も" "M-m")	;;back-to-indentation
(keymap-set input-decode-map "M-み" "M-n")	;;half-page-up
(keymap-set input-decode-map "M-ら" "M-o")	;;overwrite-mode (keybind-ver2)new
(keymap-set input-decode-map "M-せ" "M-p")	;;half-page-down
(keymap-set input-decode-map "M-た" "M-q")	;;fill-paragraph
(keymap-set input-decode-map "M-す" "M-r")	;;move-to-window-line-top-bottom
(keymap-set input-decode-map "M-か" "M-t")	;;transpose-words
(keymap-set input-decode-map "M-な" "M-u")	;;upcase-word
(keymap-set input-decode-map "M-ひ" "M-v")	;;ak-cua-scroll-up
(keymap-set input-decode-map "M-て" "M-w")	;;kill-ring-save
(keymap-set input-decode-map "M-さ" "M-x")	;;execute-extended-command
(keymap-set input-decode-map "M-ん" "M-y")	;;yank-pop
(keymap-set input-decode-map "M-つ" "M-z")	;;zap-to-char
(keymap-set input-decode-map "M-め" "M-/")	;;dabbrev-expand
(keymap-set input-decode-map "M-へ" "M-^")	;;delete-indentation
(keymap-set input-decode-map "M-ー" "M-\\")	;;delete-horizontal-space
(keymap-set input-decode-map "M-ゅ" "M-(")	;;insert-parentheses
(keymap-set input-decode-map "M-れ" "M-;")	;;comment-dwim
(keymap-set input-decode-map "M-け" "M-:")	;;eval-expression
(keymap-set input-decode-map "M-゛" "M-@")	;;mark-word
(keymap-set input-decode-map "M-「" "M-{")	;;backward-paragraph
(keymap-set input-decode-map "M-」" "M-}")	;;forward-paragraph
(keymap-set input-decode-map "M-、" "M-<")	;;beginning-of-buffer
(keymap-set input-decode-map "M-。" "M->")	;;end-of-buffer
(keymap-set input-decode-map "M-ね" "M-,")	;;xref-go-back
(keymap-set input-decode-map "M-る" "M-.")	;;xref-find-definitions
(keymap-set input-decode-map "M-・" "M-?")	;;xref-find-references

;;====================================
;;;; ignore IM change key C-S-l (Ａ), C-S-j (ち), C-+ (A)
;;====================================
(keymap-global-set "C-S-j" 'ignore)
(keymap-global-set "C-S-l" 'ignore)
(keymap-global-set "C-+" 'ignore)
;; ignore IM cyclic change key command-[, command-{  (ex C-M-SPC, C-SPC)
;;(keymap-global-set "s-[" 'ignore)
;;(keymap-global-set "s-{" 'ignore)




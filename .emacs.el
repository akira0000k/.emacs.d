;;; -*- lexical-binding: t; -*-
;;====================================
;;  auto revert setting dired/buffer
;;====================================
;; Auto revert files when they change
(global-auto-revert-mode t) ;; comment this line if you dont need.
 
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t) ;;default: nil
(setq auto-revert-verbose nil) ;;default: t

;;(setq auto-revert-interval 5) ;;default: 5

;;(setq auto-revert-use-notify t) ;;default: t

;;====================================
;;  common functions
;;====================================
;; file name relative to .emacs.d/
(defalias '_emacs_d/ 'locate-user-emacs-file)

;; string valid?
(defun ak-validstrp(str)
  (and str (> (length str) 0)))

(unless (fboundp 'keymap-set)
  (defun keymap-set (keymap key command)
    (if (stringp command)
	(define-key keymap (kbd key) (kbd command))
      (define-key keymap (kbd key) command)
      ))
  (defun keymap-global-set (key command)
    (global-set-key (kbd key) command))
  (defun keymap-local-set (key command)
    (local-set-key (kbd key) command))
  )
(defun ak-input-decode-set (sequence key)
  (define-key input-decode-map sequence (kbd key)))

(unless (fboundp 'use-package)
  (defmacro use-package (&rest _args) nil)
  )

;; ------ 00misc.el ------ ;;; -*- lexical-binding: t; -*-

;; Erase Menu bar
(unless (display-graphic-p) (menu-bar-mode -1))
;;(menu-bar-mode 1) ;;default
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
;;;; 削除はゴミ箱にいれる
;;====================================
(setq delete-by-moving-to-trash t)

;;====================================
;;;; grep case insensitive
;;====================================
(setq grep-command "grep --color=auto -nH --null -i -e ")
;;(setq grep-command "grep --color=auto -nH -i -e ")

;;====================================
;;;; keybinding while Isearch.  ex. C-s C-w ..yank word
;;====================================
(keymap-set isearch-mode-map "C-k" 'isearch-edit-string)
(keymap-set isearch-mode-map "C-h" 'isearch-delete-char)
;; ;; incremental search 中に C-j を改行にマッチさせる。(default動作)
;; (keymap-set isearch-mode-map "C-j" 'isearch-printing-char) ;;default
;; isearch-edit-string と replace の minibuffer内で C-j を単純改行挿入にする
(keymap-set minibuffer-local-isearch-map "C-j" 'electric-indent-just-newline)
(when (fboundp 'defvar-keymap)
  (load (_emacs_d/ "site-lisp/replace-patch"))
  (keymap-set minibuffer-local-replace-map "C-j" 'electric-indent-just-newline)
  )
;;                                                  C-h を単純バックスペースにする
(keymap-set minibuffer-local-isearch-map "C-h" 'delete-backward-char)
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

(keymap-global-set "C-r" 'query-replace) ;; M-% aaa bbb
(keymap-global-set "C-M-r" 'query-replace-regexp) ;; C-M-% aaa bbb

;; Insert key .. toggle overwrite-mode
(keymap-global-set "M-o" 'overwrite-mode)

;; no cua-mode  cut/copy/paste=C-w C-S-w C-y
(keymap-global-set "C-S-w" 'kill-ring-save) ;; M-w
(keymap-global-set "C-x r W" 'copy-rectangle-as-kill)  ;; C-x r M-w

;; for MAC OSX
(keymap-global-set "C-h" 'backward-delete-char-untabify)
;;(keymap-global-set "C-h" 'delete-backward-char)


;; overwridden by cua-mode
;;;;  ;; no cua-mode  cut/paste=C-w C-v  copy/paste=M-w M-v
;;;;  (keymap-global-set "M-v" 'yank) ;; C-y
;;;;  (keymap-global-set "C-v" 'yank) ;; C-y
(keymap-global-set "C-z" 'undo) ;; C-x C-z  ^Z ..fg

;;                    C-x C-c     'save-buffers-kill-terminal
;;                    C-x C-z     'suspend-frame            ;; <- C-z

;; alternate keybind for pos<--ex-->mark (was C-x C-x)
(keymap-global-set "M-s M-j" 'exchange-point-and-mark)

;; like C-S-<backspace>
(keymap-global-set "C-S-<delete>" 'kill-whole-line)

;;====================================
;;;; kill region or kill line. (MAC OSX style)
;;====================================
(keymap-global-set "C-k" 'ak-kill-line)
;;  copy
(keymap-global-set "C-S-k" 'ak-copy-line)
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



;; ------ 02cursor.el ------ ;;; -*- lexical-binding: t; -*-

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
(keymap-global-set "C-<tab>" 'other-window)
(keymap-global-set "C-S-<tab>" 'ak-prev-window)
(when (fboundp 'next-window-any-frame)
  (keymap-global-set "C-<tab>" 'next-window-any-frame)
  (keymap-global-set "C-S-<tab>" 'previous-window-any-frame))

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



;; ------ 03cua.el ------ ;;; -*- lexical-binding: t; -*-

;;;; Toggle hilighting area after mark(C-SPC) + move(<left>)
;;(transient-mark-mode 'toggle) ;; nil)* -1)

;;;; start shift-selection set mark. cancel(C-g)
;;(setq shift-select-mode 'permanent) ;; t)* nil)

;;;; toggle deleting select area with C-d, or overwriting.
;;(delete-selection-mode 'toggle) ;; nil) -1)*

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)   ;;defalt  region selected->C-x:cut C-c:copy
(cua-mode t)

;; <C-return>  start cua set rectangle mark
;; C-c C-SPC   start cua set rectangle mark

;; C-x SPC     start emacs24 rectangle mark mode

;; s-j  (command-j)  cua-exchange-point-and-mark
;; 上から選択したか、下から選択したかを切り替え。
;; 矩形選択時は、文字挿入が矩形の前/後に変わる。

(when (boundp 'cua-global-keymap)
  ;; Alternate keybind of cua-rect for org-mode. 
  (keymap-set cua-global-keymap "C-c C-SPC" 'cua-set-rectangle-mark)
  (keymap-set cua-global-keymap "C-<return>" 'cua-set-rectangle-mark2)
  (defun cua-set-rectangle-mark2 (&optional reopen)
    "Set mark and start in CUA rectangle mode.
With prefix argument, activate previous rectangle if possible."
    (interactive "P")
    (if (string= major-mode "org-mode")
	(org-insert-heading-respect-content)
      ;; else
      (cua-set-rectangle-mark reopen)))
  )

(when (boundp 'cua--cua-keys-keymap)
  ;; Page Down/Page Up  =  M-v M-u
  (keymap-set cua--cua-keys-keymap "M-v" 'ak-cua-scroll-up) ;;was delete-selection-repeat-replace-region.
  (keymap-set cua--cua-keys-keymap "M-V" 'cua-scroll-down)
  ;;(keymap-set cua--cua-keys-keymap "M-u" 'cua-scroll-down) ;;was upcase-word
  (defun ak-cua-scroll-up (&optional arg)
    (interactive "^P")
    (cua-scroll-up arg)
    (forward-line 1))
  )

;; cua-mode の on/off をするなら、キーバインド設定後にoffにする。
;;(cua-mode 'toggle) ;; nil)* -1)
;;(cua-mode -1)

;;  X C V initial choice here.
;; t    : default  region selected->C-x:cut C-c:copy, C-v:paste
;; nil  : thankyou       use legacy C-w:cut M-w:copy, C-y:paste
;;'shift: bug?
;;(setq cua-enable-cua-keys 'shift) ;; t)* nil)
;;(setq cua-enable-cua-keys nil)



;; ------ 04dired.el ------ ;;; -*- lexical-binding: t; -*-

;;====================================
;;;;  dired bindings
;;====================================

(setq dired-clean-up-buffers-too nil)
;; Save Z directory
(defvar ak-dired-default-directory default-directory)
;; t = Open View mode by <right>
(defcustom ak-dired-view-on-right-arrow nil
  "Non-nil means open in view mode by right arrow in dired."
  :type 'boolean
  :group 'dired
  )

;; Extra keybinds for dired mode

(with-eval-after-load 'dired
  (require 'dired-x)
  ;;(require 'wdired)
  (keymap-set dired-mode-map "<right>"   'ak-dired-right-char)      ;; -> f, v
  (keymap-set dired-mode-map "<left>"    'ak-dired-left-char)       ;; <- ^
  (keymap-set dired-mode-map "<home>"    'ak-dired-home)
  (keymap-set dired-mode-map "<end>"     'ak-dired-end)
  (keymap-set dired-mode-map "<prior>"   'ak-dired-scroll-down)
  (keymap-set dired-mode-map "<next>"    'ak-dired-scroll-up)
  (keymap-set dired-mode-map "<f5>"      'revert-buffer)               ;; g
  (keymap-set dired-mode-map "S-<f5>"    'revert-buffer)               ;; g
  (keymap-set dired-mode-map "H"    'ak-dired-find-file-hexl)        ;;originally make Hard link
  ;; S            dired-do-symlink
  ;; Y            dired-do-relsymlink  dired-x.el
  ;; edit filename in wdired mode      autoload wdired.el
  (keymap-set dired-mode-map "E" 'wdired-change-to-wdired-mode)

  (keymap-set dired-mode-map "h" 'ak-dired-home-dir)
  (keymap-set dired-mode-map "r" 'ak-dired-root-dir)
  (keymap-set dired-mode-map "z" 'ak-dired-defo-dir)
  (and (getenv "A_DIRECTORY") (keymap-set dired-mode-map "a" 'ak-dired-a-dir))
  (and (getenv "B_DIRECTORY") (keymap-set dired-mode-map "b" 'ak-dired-b-dir))
  (and (getenv "C_DIRECTORY") (keymap-set dired-mode-map "c" 'ak-dired-c-dir))
  (and (getenv "E_DIRECTORY") (keymap-set dired-mode-map "e" 'ak-dired-e-dir))
  (keymap-set dired-mode-map "C-b" 'ak-dired-left-char)

  ;; search only filename
  ;;;;(setq dired-isearch-filenames t) ;;turns isearch-forward to search filename only
  (keymap-set dired-mode-map "C-s" 'dired-isearch-filenames)
  ;;01keys.el(keymap-global-set "s-f" 'isearch-forward) ;;command s = search username

  ;; avoid remapping to dired-next(previous)-line
  (defalias 'ak-dired-next-line 'next-line)
  (defalias 'ak-dired-previous-line 'previous-line)
  (keymap-set dired-mode-map "C-n" 'ak-dired-next-line)
  (keymap-set dired-mode-map "C-p" 'ak-dired-previous-line)

  ;; ;; line scroll and keep cursor on file name
  ;; (keymap-set dired-mode-map "C-<up>"   'ak-dired-line-up       )
  ;; (keymap-set dired-mode-map "C-<down>" 'ak-dired-line-down     )
  ;; (keymap-set dired-mode-map "C-s-<up>"   'ak-dired-line-up-fast  )
  ;; (keymap-set dired-mode-map "C-s-<down>" 'ak-dired-line-down-fast)
  ;; (keymap-set dired-mode-map "C-M-p" 'ak-dired-line-up  ) ;;was dired-prev-subdir
  ;; (keymap-set dired-mode-map "C-M-n" 'ak-dired-line-down) ;;was dired-next-subdir

  ;; skip files
  (keymap-set dired-mode-map "N" 'dired-next-dirline)     ;;was dired-do-man    ">"
  (keymap-set dired-mode-map "P" 'dired-prev-dirline)     ;;was dired-do-print  "<"
  (keymap-set dired-mode-map "C-," 'ak-dired-beginning-of-buffer)
  (keymap-set dired-mode-map "C-." 'ak-dired-end-of-buffer)
  (keymap-set dired-mode-map "," 'ak-dired-beginning-of-buffer)
  (keymap-set dired-mode-map "." 'ak-dired-end-of-buffer)  ;;was dired-clean-directory
  (keymap-set dired-mode-map "M-." 'dired-clean-directory) ;;was xref-find-definitions
  (keymap-set dired-mode-map "C-h" 'dired-unmark-backward) ;;like backspace

  ;; Vi-like
  (keymap-set dired-mode-map "j" 'ak-dired-line-down)
  (keymap-set dired-mode-map "k" 'ak-dired-line-up)
  (keymap-set dired-mode-map "J" 'ak-dired-line-down-fast)
  (keymap-set dired-mode-map "K" 'ak-dired-line-up-fast)
  ;;(message "eval-after-load 'dired done.")
  )

(defun ak-dired-home-dir()(interactive)(dired "~"))
(defun ak-dired-root-dir()(interactive)(dired "/"))
(defun ak-dired-defo-dir()(interactive)(dired ak-dired-default-directory))
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

(defun ak-dired-line-up()        (interactive)
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line -1)
	   (scroll-down 1)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down()      (interactive)
       (let ( (pos0 (current-window-line)) )
	 (scroll-up   1)(move-to-window-line pos0)(dired-next-line 0)))
(defun ak-dired-line-up-fast()   (interactive)
       (let ( (pos0 (current-window-line)) )
	 (if (ak-first-page-p)
	     (dired-next-line (- ak-fast-scroll-lines))
	   (scroll-down ak-fast-scroll-lines)(move-to-window-line pos0)(dired-next-line 0))))
(defun ak-dired-line-down-fast() (interactive)
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
(keymap-global-set "C-b" 'ak-backward-char)

;; ;; Cursor L, R move always logical order, backward and forward,
;; ;; even at R2L text and visual-order-cursor-movement is t
;; (keymap-global-set "<left>" 'ak-backward-char)
;; (keymap-global-set "<right>" 'forward-char)

;; cursor move L R naturally at R2L text.
(keymap-global-set "<left>" 'ak-left-char)
(keymap-global-set "<right>" 'ak-right-char)
(if (boundp 'cua--rectangle-keymap)
    (progn
      (keymap-set cua--rectangle-keymap "<remap> <ak-right-char>"    #'cua-resize-rectangle-right)
      (keymap-set cua--rectangle-keymap "<remap> <ak-left-char>"     #'cua-resize-rectangle-left)
      (keymap-set cua--rectangle-keymap "<remap> <ak-backward-char>" #'cua-resize-rectangle-left)
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
  (unless (minibuffer-prompt)
    (if (string-match "^\\*scratch\\*" (buffer-name))
	(dired ".")
      (find-alternate-file ".")))
  )



;; ------ 05like.el ------ ;;; -*- lexical-binding: t; -*-

;;====================================
;;;; function keys
;;====================================

;;(keymap-global-set "<f1>" 'help-for-help) ;;was help-command
(keymap-global-set "S-<f1>" 'other-window)

;;        C-x 6 2		2C-two-columns
;;        C-x 6 b		2C-associate-buffer
;;        C-x 6 s		2C-split
;;was                 2C-command
(keymap-global-set "<f2>" 'ak-divide-screen-toggle)
;;(keymap-global-set "S-<f2>" 'ak-divide-screen-or-other)
(keymap-global-set "S-<f2>" 'ak-divide-screen3-or-other)

;;was                 kmacro-start-macro-or-insert-counter
(keymap-global-set "<f3>" 'isearch-repeat-forward)
(keymap-global-set "S-<f3>" 'isearch-repeat-backward)

;;was                    kmacro-end-or-call-macro
(keymap-global-set "<f4>"    'kill-current-buffer)
(keymap-global-set "S-<f4>" 'delete-window)

(keymap-global-set "S-<f5>" 'recenter)
(keymap-global-set "<f5>" 'ak-dired-current-dir-other-window)
(defun ak-dired-current-dir-other-window()
  "Dired current directory other window." (interactive)
  (dired-other-window "."))

(keymap-global-set "<f6>"   'universal-coding-system-argument)       ;;   C-x RET-c
(keymap-global-set "S-<f6>"   'electric-indent-mode)
;;test macro
(keymap-global-set "ESC <f6>"  'kmacro-start-macro-or-insert-counter)  ;; <f3>
(keymap-global-set "C-<f6>"  'kmacro-end-or-call-macro)  ;; <f4>

(keymap-global-set "<f7>"   'ak-shrink-window)
(keymap-global-set "S-<f7>" 'ak-shrink-window2)
(keymap-global-set "<f8>"   'ak-enlarge-window)
(keymap-global-set "S-<f8>" 'ak-enlarge-window2)

(keymap-global-set "<f9>"  'describe-key-briefly)
(keymap-global-set "S-<f9>" 'ak-toggle-case-fold-search)
(defun ak-toggle-case-fold-search()
  "Toggle search case." (interactive)
  (if case-fold-search
      (progn (setq-default case-fold-search nil)
	     (message "case sensitive Search mode"))
    (setq-default case-fold-search t)
    (message "ignore case Search mode")))

;;was  menu-bar-open
(keymap-global-set "<f10>" 'ak-window-swap-split)
;; (keymap-global-set "<S-f10>" 'ak-window-vh-split)
;; (keymap-global-set "<f10>" 'ak-window-rotate-split)
(keymap-global-set "S-<f10>" 'ak-window-rotate-split-reverse)
;;               M-f10   toggle-frame-maximized  =  "ESC <f10>"

(keymap-global-set "M-<f11>"   'toggle-frame-fullscreen)  ;; <f11>
(keymap-global-set "ESC <f11>" 'toggle-frame-fullscreen)  ;; <f11>

;;was                 'toggle-frame-fullscreen  ==> "ESC <f11>"
(keymap-global-set "<f11>" 'toggle-truncate-lines)  ;; Show Desktop (MAC OSX)
;; (require 'linum)                            ;; obsolete (emacs29)
;; (keymap-global-set "<f12>" 'global-linum-mode)
(keymap-global-set "<f12>" 'global-display-line-numbers-mode)
;;(keymap-global-set "<f12>" 'display-line-numbers-mode)
(keymap-global-set "S-<f11>" 'scroll-right)
(keymap-global-set "S-<f12>" 'scroll-left)


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
(keymap-global-set "C-]" 'match-paren)
(defun match-paren ()
  "Go to the matching parenthesis if on parenthesis"
  (interactive)
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



;; ------ 06shell.el ------ ;;; -*- lexical-binding: t; -*-

;;====================================
;;;; shell-mode
;;====================================
;; M-x shell  ==>  M-x s
(defalias 's 'shell)
;;            ==>  M-s M-s
(keymap-global-set "M-s M-s" 'shell)
(keymap-global-set "M-s s" 'eshell)

(with-eval-after-load 'shell
  (load (_emacs_d/ "site-lisp/tails-comint-history"))
  ;; comint 関係の設定
  (setq comint-process-echoes t)
  (setq comint-input-autoexpand nil)
  ;;(setq comint-input-autoexpand 'input)
  ;;(setq comint-input-autoexpand 'history)
  (setq comint-scroll-to-bottom-on-input t)
  ;;(setq comint-scroll-to-bottom-on-output t)
  (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
  (keymap-set shell-mode-map  "S-<f5>"     'ak-do-resync-dirs)
  (keymap-set comint-mode-map "<home>"   'beginning-of-buffer)
  (keymap-set comint-mode-map "<end>"    'end-of-buffer)
  (keymap-set comint-mode-map "C-<up>"   'ak-scroll-down1)
  (keymap-set comint-mode-map "C-<down>" 'ak-scroll-up1)
  (keymap-set comint-mode-map "<up>"     'ak-shell-up)
  (keymap-set comint-mode-map "<down>"   'ak-shell-down)
  )

(add-hook 'shell-mode-hook
	  (lambda ()
	    ;;(shell-dirtrack-mode 0)
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



;; ------ 07buffer.el ------ ;;; -*- lexical-binding: t; -*-

;;====================================
;;;;circular buffer change
;;====================================
;;C-PageUp C-PageDown .. Excel:change tab
(keymap-global-set "C-<prior>" 'ak-last-buffer)
(keymap-global-set "C-<next>"  'ak-next-buffer)

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

(defun list-buffers-if-exist()
  (let ((buflist (get-buffer "*Buffer List*")))
    (if buflist
	(if (get-buffer-window buflist)
	    ;; exists in same frame, refresh as C-x C-b
	    (list-buffers)
	  ;;else
	  (when (get-buffer-window-list buflist nil t)
	    ;; in other frame.
	    (list-buffers-noselect)
	    ))
      )))

;; avoid warning to redefined advice.
(setq ad-redefinition-action 'accept)

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    ;;; old "defadvice" style.
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)

;; kill current buffer.
;; kill top buffer of bufferlist and show "next" buffer.
(defun ak-kill-current-buffer()
  (interactive)
  (if (minibufferp)
      (abort-recursive-edit)
    (if (string-match "^\\*Buffer List\\*" (buffer-name))
	(kill-buffer)
      (let ((cb (current-buffer)))
	(ak-next-buffer)
	(ak-last-buffer)
	(kill-buffer cb)
	(list-buffers-if-exist)))))
(keymap-global-set "<remap> <kill-current-buffer>" 'ak-kill-current-buffer)
(keymap-global-set "<remap> <kill-buffer>" 'ak-kill-current-buffer)

;; kill buffer from menu, Close.
(defun ak-kill-this-buffer ()
  "Menu: File >Close, affecting buffer list imediately."
  ;;(message "kill this buffer done")
  (list-buffers-if-exist))
(advice-add 'kill-this-buffer :after #'ak-kill-this-buffer)

(defun ak-quit-window (&optional _kill _window)
  "Quit window and change buffer-list."
  ;;(message "quit window done")
  (list-buffers-if-exist))
(advice-add 'quit-window :after #'ak-quit-window)

(defun ak-bury-buffer (&optional _buffer-or-name)
  "Bury buffer and change buffer-list."
  ;;(message "bury buffer done")
  (list-buffers-if-exist))
(advice-add 'bury-buffer :after #'ak-bury-buffer)

(defun ak-switch-to-buffer (_buffer-or-name &optional _norecord _force-same-window)
  "Switch window and change buffer-list."
  ;;(message "switch to buffer done")
  (list-buffers-if-exist))
(advice-add 'switch-to-buffer :after #'ak-switch-to-buffer)

(defun ak-find-file (_filename &optional _wildcards)
  "Find-File and change buffer-list."
  ;;(message "find file done")
  (list-buffers-if-exist))
(advice-add 'find-file :after #'ak-find-file)

;;(setq ad-redefinition-action 'accept)
(defun ak-shell (&optional _buffer _file-name)
  "M-x shell"
  (list-buffers-if-exist))
(advice-add 'shell :after #'ak-shell)

(defun ak-dired (_dirname &optional _switches)
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(advice-add 'dired :after #'ak-dired)

(defun ak-dired-other-window (_dirname &optional _switches)
  "Dired other Window and change buffer-list."
  (list-buffers-if-exist))
(advice-add 'dired-other-window :after #'ak-dired-other-window)

(defun ak-info (&optional _file-or-node _buffer)
  "Enter Info, the documentation browser."
  (list-buffers-if-exist))
(advice-add 'info :after #'ak-info)

;; s-^ kill-some-buffers use it.  see files.el
(defun ak-before-kill-buffer-ask (buffer)
  "Show buffer."
  (switch-to-buffer buffer))
(advice-add 'kill-buffer-ask :before #'ak-before-kill-buffer-ask)


;; Auto Revert Interval 60 if Buffer Menu focused.

(with-eval-after-load 'autorevert
  (message "autorevert after load")
  (defvar auto-revert-interval-default nil)
  (defun ak-buffer-menu-focus-in ()
    (unless auto-revert-interval-default
      (setq auto-revert-interval-default auto-revert-interval))
    (setq auto-revert-interval 60)
    ;;(message "in  auto-revert-interval %d" auto-revert-interval)
    (auto-revert-set-timer)
    )
  (defun ak-buffer-menu-focus-out ()
    (setq auto-revert-interval auto-revert-interval-default)
    ;;(message "out auto-revert-interval %d" auto-revert-interval)
    (auto-revert-set-timer)
    t)

  (autoload 'buffer-focus-in-callback (_emacs_d/ "site-lisp/buffer-focus-hook"))
  (add-hook 'Buffer-menu-mode-hook
	    (lambda()
	      (buffer-focus-in-callback 'ak-buffer-menu-focus-in)
	      (buffer-focus-out-callback 'ak-buffer-menu-focus-out)
	      (add-hook 'kill-buffer-hook 'ak-buffer-menu-focus-out nil 'local)
	      ))
  ;;;;check exact revert timing
  ;;(setq auto-revert-use-notify nil)
)



;; ------ 08mode.el ------ ;;; -*- lexical-binding: t; -*-

;; (add-to-list 'load-path (_emacs_d/ "site-lisp/"))


;;====================================
;;;; startup.el
;;====================================
(defun my/fancy-startup-screen (oldfunc &optional concise)
  "Display fancy startup screen.
If CONCISE is non-nil, do nothing."
  ;;(message "my/fancy enter concise=%s" concise)
  (unless concise
    (apply oldfunc concise)
    ))
(advice-add 'fancy-startup-screen :around #'my/fancy-startup-screen)


;;====================================
;;;; defaultの quail japanese かな漢字変換
;; にゃおみん さん 雑記帳
;; PCの日本語入力について個人的メモ より
;; https://rn.nyaomin.info/entry/2024/02/08/230020
;;====================================
;; C-\ toggle-input-method
;; 入力中
(use-package quail
  :bind
  (:map quail-conversion-keymap
	("C-h" . quail-conversion-backward-delete-char)
	("C-j" . quail-no-conversion)
	("<f1>" . quail-translation-help))
  :config
  (setq quail-japanese-use-double-n t)  ;nを二回入力したら「ん」となるようにする
  )
;; 変換中
(use-package kkc
  :bind
  (:map kkc-keymap
	("C-h" . kkc-cancel)
	("C-j" . kkc-terminate)
	("S-SPC" . kkc-prev)
	("<f1>" . kkc-help))
  :config
  (setq kkc-init-file-name (_emacs_d/ ".kkc/kkcrc"))
  ;; (unless (load (_emacs_d/ "LEIM/ja-dic/ja-dic.elc" t nil t))
  ;;   (message "load personal ja-dic failed."))
  :load-path "LEIM"
  )

;;====================================
;;;; skk かな漢字変換
;;====================================
;; (ak-package-init-once)
;; M-x package-install RET ddskk RET
;; M-x package-install RET ddskk-posframe RET
(require 'package)       ;;for package-installed-p
(when (package-installed-p 'ddskk)
  ;;(setq default-input-method "japanese-skk") ;;C-\ toggle
  (keymap-global-set "C-x C-j" 'skk-mode)
  ;;; Customize .skk cash directory
  (unless (and (boundp 'skk-user-directory) skk-user-directory)
    (setq skk-user-directory (_emacs_d/ ".ddskk")))
  )

(with-eval-after-load "skk"
  (message "skk loaded")
  ;; isearch と統合。
  (load (_emacs_d/ "site-lisp/skk-setup"))
  ;; 確定を戻す
  (keymap-set skk-j-mode-map "C-/" 'skk-undo-kakutei)
  ;; x 以外でも前候補。
  (keymap-set skk-j-mode-map "S-SPC" 'skk-previous-candidate)
  (keymap-set skk-j-mode-map "M-DEL" 'skk-previous-candidate)
  (keymap-set skk-j-mode-map "C-<backspace>" 'skk-previous-candidate)
  (keymap-set skk-j-mode-map "<up>" 'skk-previous-candidate) ;;test

  ;; 辞書登録ミニバッファから、前候補(S-SPC,M-DEL,etc)で抜ける
  (load (_emacs_d/ "site-lisp/ak-skk-patch"))
  (keymap-set minibuffer-local-skk-map "S-SPC" 'backward-kill-word)
  ;; 辞書登録不要のときメッセージを出さずに終了。
  (setq skk-save-jisyo-function 'skk-save-jisyo-original2)
  
  ;; BS(DEL, C-h) でミニバッファから抜けるように関数変更。
  (defun skk-delete-backward-char-with-quit (oldfnc &rest arg)
    "ミニバッファ先頭ならミニバッファから抜ける。そうでなければ skk-delete-backward-char を呼び出す。"
    (interactive "*P")
    (if (and (minibuffer-prompt) (= (point-max) (+ (minibuffer-prompt-width) 1)))
	(exit-minibuffer)
      (apply oldfnc arg)))
  (advice-add 'skk-delete-backward-char :around #'skk-delete-backward-char-with-quit)
  ;; BSで変換候補を削ることはせず、前候補
  (setq skk-delete-implies-kakutei nil)

  ;; ;; 候補表示をかっこよく。
  ;; (when (and (package-installed-p 'ddskk-posframe) (display-graphic-p))
  ;;   (ddskk-posframe-mode t))
  
  ;;; Customize dictionary path in custom.el.
  (unless skk-large-jisyo
    (setq skk-large-jisyo (_emacs_d/ "SKK-DIC/SKK-JISYO.L")))

  (if (file-exists-p skk-large-jisyo)
      (message "skk dictionary: %s" skk-large-jisyo)
    (setq skk-large-jisyo nil)  
    (message "no skk dictionary. use lisp/leim/ja-dic/ja-dic.el instead"))
  )

;;====================================
;;;;view-mode
;;====================================
;;  "ESC f1"  view mode
(keymap-global-set "ESC <f1>" 'ak-View-mode)
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
	   (when current-input-method
	     (toggle-input-method nil))
	   )))

(with-eval-after-load 'view
  (keymap-set view-mode-map "S-<f5>" 'ak-revert-buffer-noconfirm)
  (keymap-set view-mode-map "i" 'ak-View-exit)
  (keymap-set view-mode-map "h" 'left-char)
  (keymap-set view-mode-map "j" 'next-line)
  (keymap-set view-mode-map "k" 'previous-line)
  (keymap-set view-mode-map "l" 'right-char)
  (keymap-set view-mode-map "b" 'backward-char)
  (keymap-set view-mode-map "f" 'forward-char)
  (keymap-set view-mode-map "a" 'beginning-of-visual-line)
  (keymap-set view-mode-map "e" 'ak-end-of-visual-line)
  (keymap-set view-mode-map "0" 'beginning-of-line)
  (keymap-set view-mode-map "$" 'end-of-line)
  (keymap-set view-mode-map "H" 'ak-goto-top-screen)   
  (keymap-set view-mode-map "M" 'ak-goto-mid-screen)   
  (keymap-set view-mode-map "L" 'ak-goto-bottom-screen)
  (keymap-set view-mode-map "y"	'ak-line-up)
  (keymap-set view-mode-map "RET" 'ak-line-down)
  (keymap-set view-mode-map "K" 'ak-line-up)
  (keymap-set view-mode-map "J" 'ak-line-down)
  (keymap-set view-mode-map "u" 'half-page-down)
  (keymap-set view-mode-map "d" 'half-page-up)
  (keymap-set view-mode-map "^" 'half-page-down)
  (keymap-set view-mode-map "v" 'half-page-up)
  (keymap-set view-mode-map "<remap> <View-scroll-page-backward>" #'ak-scroll-page-backward);; DEL, S-SPC
  (keymap-set view-mode-map "<remap> <View-scroll-page-forward>"  #'ak-scroll-page-forward) ;; SPC
  (keymap-set view-mode-map "　" 'ak-scroll-page-forward)
  (keymap-set view-mode-map "G" 'end-of-buffer)
  (keymap-set view-mode-map "o" 'ak-View-scroll-to-buffer-end)
  (keymap-set view-mode-map "/" 'isearch-forward-regexp)
  (keymap-set view-mode-map "\\" 'isearch-backward-regexp)
  (keymap-set view-mode-map "n" 'isearch-repeat-forward)
  (keymap-set view-mode-map "N" 'isearch-repeat-backward)
  (keymap-set view-mode-map "p" 'isearch-repeat-backward)
  (keymap-set view-mode-map ": w" 'save-buffer)
  (keymap-set view-mode-map ": q" 'kill-current-buffer)
  )
;;  "E"     #'View-exit-and-edit
;;  "q"     #'View-quit
;;  ">"     #'end-of-buffer
;;  "<"     #'beginning-of-buffer
;;  "g"     #'View-goto-line  (nnn g:goto nnn / g:beginning-of-buffer / G:end-of-buffer)
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

(defun ak-end-of-visual-line()
  "go to end of line or screen end." (interactive "^")
  (end-of-visual-line)
  (unless (eolp)
    (backward-char)))
  
;;====================================
;;;; s-: ispell
;;====================================
;; brew install hunspell
;; download "en_US.dic" and "en_US.aff" from
;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/
(setq-default ispell-program-name "hunspell")

(or (ak-validstrp (getenv "DICTIONARY")) (setenv "DICTIONARY" "en_US")) ;;default dictionary
(or (ak-validstrp (getenv "DICPATH"))
   (setenv "DICPATH" (expand-file-name (_emacs_d/ "Spelling"))))

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
(keymap-global-set "C-'" 'expand-abbrev)
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
;; (autoload 'go-mode (_emacs_d/ "site-lisp/go-mode.el") nil t)
;; ;;   
;; (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))


;;====================================
;;;;yaml-mode
;;====================================
;; (autoload 'yaml-mode (_emacs_d/ "site-lisp/yaml-mode.el") nil t)
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
		    (list (_emacs_d/ "css/md.css"))
		    ;;(list (_emacs_d/ "markdown/Clearness.css"))
		    ;;(list (_emacs_d/ "markdown/Solarized(Dark).css"))
		    ;;(list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css")
		    )
	      ;; markdown preview mode
	      ;; M-x markdown-preview-mode
	      (keymap-local-set "C-c p" 'markdown-preview-mode)
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

(autoload 'buffer-focus-in-callback  (_emacs_d/ "site-lisp/buffer-focus-hook"))

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
	    (add-hook 'kill-buffer-hook 'ak-org-focus-out nil 'local)
	    (keymap-local-set "C-y" 'org-yank)
	    ))

;; ------ 09org.el ------ ;;; -*- lexical-binding: t; -*-

(keymap-global-set "C-c l" 'org-store-link)
;; (setq org-startup-with-inline-images t)

(keymap-global-set "C-c c" 'org-capture)
(keymap-global-set "C-c a" 'org-agenda)

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
(defun ak-scroll-down1()
  "1 line scroll down, move cursor to top."
  (interactive)
  (if (ak-first-page-p)
      (if (= 0 (current-window-line))
	  (move-beginning-of-line nil)
	(forward-line -1))
    (scroll-down 1))
  )
(defun ak-scroll-up1()
  "1 line scroll up, at lease show 1 line."
  (interactive)
  (let ((ok (ignore-errors (scroll-up 1) t)))
    (if (not ok)
	(goto-char (point-max))
      (if (= 0 (current-window-line))
	  (forward-line)))
    ))
(defun ak-scroll-down2()
  "Boosted line scroll down, move cursor to top."
  (interactive)
  (if (ak-first-page-p)
      (if (= 0 (current-window-line))
	  (move-beginning-of-line nil)
	(forward-line (- ak-fast-scroll-lines)))
    (scroll-down ak-fast-scroll-lines))
  )
(defun ak-scroll-up2()
  "Boosted line scroll up, at lease show 1 line."
  (interactive)
  (let ((ok (ignore-errors (scroll-up ak-fast-scroll-lines) t)))
    (if (not ok)
	(goto-char (point-max))
      (if (= 0 (current-window-line))
	  (forward-line)))
    ))
;;(defun ak-scroll-down1() (interactive) (scroll-down 1))
;;(defun ak-scroll-down2() (interactive) (scroll-down 2))
;;(defun ak-scroll-up1() (interactive) (scroll-up 1))
;;(defun ak-scroll-up2() (interactive) (scroll-up 2))

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
      )))
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
      )))

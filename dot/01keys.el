


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


;; terminal send control+option up for command up
(define-key input-decode-map "\e[1;7A" (kbd "s-<up>"))
(define-key input-decode-map "\e[1;8A" (kbd "s-S-<up>"))
(define-key input-decode-map "\e[1;7B" (kbd "s-<down>"))
(define-key input-decode-map "\e[1;8B" (kbd "s-S-<down>"))
(define-key input-decode-map "\e[1;7C" (kbd "s-<right>"))
(define-key input-decode-map "\e[1;8C" (kbd "s-S-<right>"))
(define-key input-decode-map "\e[1;7D" (kbd "s-<left>"))
(define-key input-decode-map "\e[1;8D" (kbd "s-S-<left>"))
(define-key input-decode-map "\e[5;7~" (kbd "s-<prior>"))
(define-key input-decode-map "\e[5;8~" (kbd "s-S-<prior>"))
(define-key input-decode-map "\e[6;7~" (kbd "s-<next>"))
(define-key input-decode-map "\e[6;8~" (kbd "s-S-<next>"))
;;;; M-[ 1 ; 8 A	C-M-S-<up>      to   s-S-<up>   
;;;; M-[ 1 ; 8 B	C-M-S-<down>	to   s-S-<down> 
;;;; M-[ 1 ; 8 C	C-M-S-<right>	to   s-S-<right>
;;;; M-[ 1 ; 8 D	C-M-S-<left>	to   s-S-<left> 
;;;; M-[ 1 ; 7 A	C-M-<up>        to   s-<up>   
;;;; M-[ 1 ; 7 B	C-M-<down>	to   s-<down> 
;;;; M-[ 1 ; 7 C	C-M-<right>	to   s-<right>
;;;; M-[ 1 ; 7 D	C-M-<left>	to   s-<left> 
;;;; M-[ 5 ; 7 ~	C-M-<prior>	to   s-<prior>
;;;; M-[ 5 ; 8 ~	C-M-S-<prior>	to   s-S-<prior>
;;;; M-[ 6 ; 7 ~	C-M-<next>      to   s-<next>
;;;; M-[ 6 ; 8 ~	C-M-S-<next>    to   s-S-<next>



;;====================================
;;;; MAC OSX command keys
;;====================================
;;;; MAC OSX command key + up down left right
(global-set-key [s-up]    'beginning-of-buffer)
(global-set-key [s-down]  'end-of-buffer)
(global-set-key [s-left]  'move-beginning-of-line)
(global-set-key [s-right] 'move-end-of-line)
;;     same as default
;;;;  (global-set-key (kbd "s-a") 'mark-whole-buffer)
;;;;  (global-set-key (kbd "s-z") 'undo)
;;;;  (global-set-key (kbd "s-x") 'kill-region)
;;;;  (global-set-key (kbd "s-c") 'kill-ring-save) ;;Terminal
;;;;  (global-set-key (kbd "s-c") 'ns-copy-including-secondary) ;;Xwindow
;;;;  (global-set-key (kbd "s-v") 'yank)
;;;;  (global-set-key (kbd "s-y") 'ns-paste-secondary)

;;;;  (global-set-key (kbd "s-k") 'kill-current-buffer)
;;;;  (global-set-key (kbd "s-s") 'save-buffer)
;;;;  (global-set-key (kbd "s-u") 'revert-buffer)

;;;;  (global-set-key (kbd "s-d") 'isearch-repeat-backward)
;;;;  (global-set-key (kbd "s-f") 'isearch-forward)
;;;;  (global-set-key (kbd "s-F") 'isearch-backward)
;;;;  (global-set-key (kbd "s-g") 'isearch-repeat-forward)
;;;;  (global-set-key (kbd "s-e") 'isearch-yank-kill)
;;;;  (global-set-key (kbd "s-j") 'exchange-point-and-mark)
;;      HIRAGANA key
(global-set-key (kbd "s-ち") 'mark-whole-buffer)
(global-set-key (kbd "s-つ") 'undo)
(global-set-key (kbd "s-さ") 'kill-region)
(global-set-key (kbd "s-そ") 'ns-copy-including-secondary) ;;kill-ring-save)
(global-set-key (kbd "s-ひ") 'yank)
(global-set-key (kbd "s-ん") 'ns-paste-secondary)

(global-set-key (kbd "s-の") 'kill-current-buffer)
(global-set-key (kbd "s-と") 'save-buffer)
(global-set-key (kbd "s-な") 'revert-buffer)

(global-set-key (kbd "s-し") 'isearch-repeat-backward)
(global-set-key (kbd "s-は") 'isearch-forward)
(global-set-key (kbd "s-き") 'isearch-repeat-forward)
(global-set-key (kbd "s-い") 'isearch-yank-kill)
(global-set-key (kbd "s-ま") 'exchange-point-and-mark)




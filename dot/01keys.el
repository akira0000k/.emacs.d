


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

;; terminal send control+option up for command up
(define-key input-decode-map "\e[1;7A" (kbd "<s-up>"))
(define-key input-decode-map "\e[1;8A" (kbd "<s-S-up>"))
(define-key input-decode-map "\e[1;7B" (kbd "<s-down>"))
(define-key input-decode-map "\e[1;8B" (kbd "<s-S-down>"))
(define-key input-decode-map "\e[1;7C" (kbd "<s-right>"))
(define-key input-decode-map "\e[1;8C" (kbd "<s-S-right>"))
(define-key input-decode-map "\e[1;7D" (kbd "<s-left>"))
(define-key input-decode-map "\e[1;8D" (kbd "<s-S-left>"))
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
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-ち") 'mark-whole-buffer)
(global-set-key (kbd "s-さ") 'kill-region)
(global-set-key (kbd "s-そ") 'kill-ring-save)
(global-set-key (kbd "s-ひ") 'yank)
(global-set-key (kbd "s-つ") 'undo)



;; ;; MAC OSX Terminal.app keyboard setting
;; (progn
;;   (define-key input-decode-map "\e[25~" [S-f5])
;;   (define-key input-decode-map "\e[26~" [S-f6])
;;   (define-key input-decode-map "\e[28~" [S-f7])
;;   (define-key input-decode-map "\e[29~" [S-f8])
;;   (define-key input-decode-map "\e[31~" [S-f9])
;;   (define-key input-decode-map "\e[32~" [S-f10])
;;   (define-key input-decode-map "\e[33~" [S-f11])
;;   (define-key input-decode-map "\e[34~" [S-f12])
;; )

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
;;   toggle default
(setq isearch-case-fold-search nil)  ;;ignore case (default)
;;(setq isearch-case-fold-search t)  ;;case sensitive
(setq isearch-lax-whitespace nil)  ;;off
;;(setq isearch-lax-whitespace t)  ;;on (default)

;;   M-%                isearch-query-replace  ex. C-s aaa M-% bbb
(global-set-key (kbd "C-r") 'query-replace) ;; M-% aaa bbb

;; for MAC OSX
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

;; overwridden by cua-mode
;;;;(global-set-key (kbd "C-v") 'yank) ;; C-y
(global-set-key (kbd "C-z") 'undo) ;; C-x C-z  ^Z ..fg



;; ------ 01keys.el ------

;;====================================
;;;; Teraterm End key = <select>
;;====================================
(define-key input-decode-map "\e[4~" [end])    ;;<select> to <end>  (NumLock-off 1)

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
(define-key input-decode-map "\e[6;7~" (kbd "s-<next>"))
;;;; M-[ 1 ; 8 A	C-M-S-<up>      to   s-S-<up>   
;;;; M-[ 1 ; 8 B	C-M-S-<down>	to   s-S-<down> 
;;;; M-[ 1 ; 8 C	C-M-S-<right>	to   s-S-<right>
;;;; M-[ 1 ; 8 D	C-M-S-<left>	to   s-S-<left> 
;;;; M-[ 1 ; 7 A	C-M-<up>        to   s-<up>   
;;;; M-[ 1 ; 7 B	C-M-<down>	to   s-<down> 
;;;; M-[ 1 ; 7 C	C-M-<right>	to   s-<right>
;;;; M-[ 1 ; 7 D	C-M-<left>	to   s-<left> 
;;;; M-[ 6 ; 7 ~	C-M-<next>      to   s-<next>
;;;; M-[ 5 ; 7 ~	C-M-<prior>	to   s-<prior>
;; shift-control-,  select to filetop
;; shift-control-.  select to fileend
(define-key input-decode-map "\e[60;6u" (kbd "C-S-,"))  ;; for iTerm2
(define-key input-decode-map "\e[62;6u" (kbd "C-S-."))
(define-key input-decode-map (kbd "C-<") (kbd "C-S-,"))  ;; for Emacs.app
(define-key input-decode-map (kbd "C->") (kbd "C-S-."))
;;(define-key input-decode-map (kbd "M-<") (kbd "M-S-,")) //joke
;;(define-key input-decode-map (kbd "M->") (kbd "M-S-."))



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



;; ------ 02cursor.el ------

;;====================================
;;;; control keys
;;====================================

;;              [C-up]                    ;; Start Mission Control @ MAC OSX
;;              [C-down]                  ;; Application Window (Mission Control @ MAC OSX)
(global-set-key [C-down] '(lambda()(interactive)(scroll-up 1)))
(global-set-key [C-up]   '(lambda()(interactive)(scroll-down 1)))
(global-set-key (kbd "s-<next>")  '(lambda()(interactive)(scroll-up 2)))
(global-set-key (kbd "s-<prior>") '(lambda()(interactive)(scroll-down 2)))
;;(global-set-key [C-S-down] '(lambda()(interactive)(scroll-up 4)))
;;(global-set-key [C-S-up]   '(lambda()(interactive)(scroll-down 4)))
(global-set-key (kbd "<wheel-up>")  '(lambda()(interactive)(scroll-down 2)))
(global-set-key (kbd "<wheel-down>")  '(lambda()(interactive)(scroll-up 2)))
(global-set-key (kbd "C-M-p") '(lambda()(interactive)(previous-line 2)))
(global-set-key (kbd "C-M-n") '(lambda()(interactive)(next-line 2)))


;;;; iTerm2 use move tab function by C-tab
(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-tab] '(lambda()(interactive)(other-window -1)))

(global-set-key (kbd "C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'end-of-buffer)
;;(global-set-key (kbd "M-,") 'beginning-of-buffer)  ;;joke
;;(global-set-key (kbd "M-.") 'end-of-buffer)


;; ;; MAC OSX option key + up down left right
;; ;;;; [M-right]   ;; previous word
;; ;;;; [M-left]    ;; next word
;; (global-set-key (kbd "<M-down>") '(lambda()(interactive "^")
;;                             (if (eolp) (next-line))
;;                             (end-of-line)))
;; (global-set-key (kbd "<M-up>")   '(lambda()(interactive "^")
;;                             (if (bolp) (previous-line))
;;                             (beginning-of-line)))

;; fast cursor move
(global-set-key (kbd "<M-down>") '(lambda()(interactive "^")
                            (next-line 2)))
(global-set-key (kbd "<M-up>")   '(lambda()(interactive "^")
                            (previous-line 2)))


;;====================================
;;;; go to top or end by page down/up
;;====================================
(global-set-key (kbd "<next>")  'ak-scroll-up)   ;;PageDown
(global-set-key (kbd "<prior>") 'ak-scroll-down) ;;PageUp
(global-set-key (kbd "C-v") 'ak-scroll-up)    ;;orthodox style
(global-set-key (kbd "M-v") 'ak-scroll-down)  ;;orthodox style
(defun ak-scroll-down ()
  "scroll down = Page Up"
  (interactive "^")
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (first-page-p)
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
    (if (last-page-p)
        (goto-char (point-max))
      ;;else
      (if (not this-command-keys-shift-translated)
          (scroll-up )
        ;;else
        (let ((po (point)))
          (move-to-window-line -1)      ;move cursor to window end
          (end-of-line)
          (if (= po (point))            ;cursor really moved?
              (progn
                (scroll-up )        ;try again
                (move-to-window-line -1)
                (end-of-line)))
          )
        )
      )
    )
  )
(defun first-page-p ()
  (if (= (point-min) (window-start))
          t
        nil))
(defun last-page-p ()
  (if (= (point-max) (window-end))
          t
        nil))


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

(global-set-key (kbd "<C-S-up>") 'ak-cursor-top)
(global-set-key (kbd "<C-S-down>") 'ak-cursor-bottom)
(defun ak-cursor-top ()
  "move cursor to middle or top of screen or scroll down(Page Up)"
  (interactive "^")
  ;;(message "height=%d body=%d current=%d" (window-height) (window-body-height) (current-line))
  (if (= (point-min) (point))
      (message "Beginning of buffer@")
    (if (= (window-start) (point))
        (progn
          (scroll-down (- (window-body-height) 1))
          (message "scroll down")
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
          (scroll-up (- (window-body-height) 1))
          (message "scroll up")
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
(defun half-page-down()
  "カーソルは画面内固定で半画面 scroll-down。"
  (interactive "^")
  (if(= (window-start) 1)
      (progn
        (beginning-of-line)
        (next-line (/ (window-body-height) -2))
        )
    (let ( (a (current-line)) )
      (scroll-down (/ (window-body-height) 2))
      (move-to-window-line a)
      )))

(defun half-page-up()
  "カーソルは画面内固定で半画面 scroll-up。"
  (interactive "^")
  (if(= (window-end) (point-max))
      (next-line (/ (window-body-height) 2))
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
(global-set-key [C-home]  'beginning-of-buffer)
(global-set-key [C-end]   'end-of-buffer)
(global-set-key [home]  'home-toggle)
(global-set-key [end]   'move-end-of-line)  ;; MAC OSX .. default=end of buffer
(global-set-key (kbd "C-a")'home-toggle)
(defun home-toggle ()
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



;; ------ 03cua.el ------

;;;誘惑の甘い罠
;;; MAC OSX ではスーパー+xcv がつかえるのでそちらを使う?
(setq cua-prefix-override-inhibit-delay 0.01)
(setq cua-enable-cua-keys t)
;(setq cua-enable-cua-keys nil)
(cua-mode t)

;; ;; <C-return>  start cua set rectangle mark
;; (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)
;; shift select mode
;; C-x SPC     start emacs24 rectangle mark mode



;; ------ 04dired.el ------

;;====================================
;;;;  dired bindings
;;====================================
;; edit filename in dired mode
(require 'wdired)
(require 'dired-x)
;; S            dired-do-symlink
;; Y            dired-do-relsymlink
(define-key dired-mode-map "E" 'wdired-change-to-wdired-mode)
(define-key dired-mode-map "h" '(lambda()(interactive)(dired "~")))
(define-key dired-mode-map "r" '(lambda()(interactive)(dired "/")))
(define-key dired-mode-map "z" '(lambda()(interactive)(dired dired-default-directory)))
(and (setq a-directory (getenv "A_DIRECTORY")) (define-key dired-mode-map "a" '(lambda()(interactive)(dired a-directory))))
(and (setq b-directory (getenv "B_DIRECTORY")) (define-key dired-mode-map "b" '(lambda()(interactive)(dired b-directory))))
(and (setq c-directory (getenv "C_DIRECTORY")) (define-key dired-mode-map "c" '(lambda()(interactive)(dired c-directory))))
(and (setq e-directory (getenv "E_DIRECTORY")) (define-key dired-mode-map "e" '(lambda()(interactive)(dired e-directory))))
;;                         ">" 'dired-next-dirline
;;                         "<" 'dired-previous-dirline
(setq dired-default-directory default-directory)

;; Auto revert files when they change
(global-auto-revert-mode t)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

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
         (local-set-key "\M-s" 'shell)                          ;;emacs23  override M-s prefix
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
  (if (first-page-p)
      (progn
        (move-to-window-line 0)
        (dired-next-line 4))
    (scroll-down)
    (dired-previous-line 1))
  )
(defun ak-dired-scroll-up ()
  "Page down and set cursor at file"
  (interactive "^")
  (if (last-page-p)
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



;; ------ 05like.el ------

;;====================================
;;;; function keys
;;====================================
(global-set-key [f1] 'help-for-help)
(global-set-key [S-f1] 'other-window)
;;(global-set-key [S-f1] 'delete-other-windows)

(global-set-key [f2] 'ak-divide-screen-toggle)
(global-set-key [S-f2] 'ak-divide-screen-or-other)
;; (global-set-key [f2] 'ak-divide-screen-or-other)
;; (global-set-key [S-f2] 'delete-other-windows)

(global-set-key [f3] 'isearch-repeat-forward)
(global-set-key [S-f3] 'isearch-repeat-backward)

;;(global-set-key [f4]  '(lambda()(interactive)(kill-buffer nil)))
(global-set-key "\C-xk" 'ak-kill-buffer)
(global-set-key [f4]    'ak-kill-buffer)
(global-set-key [S-f4] 'delete-window)

(global-set-key [f5]  'recenter)
(global-set-key [S-f5]  '(lambda()(interactive)(dired ".")))

(global-set-key [f6]   'universal-coding-system-argument)       ;;   C-x RET-c
(global-set-key [S-f6]   'electric-indent-mode)

(global-set-key [f7]   'shrink-window)
(global-set-key [S-f7] 'shrink-window-horizontally)
(global-set-key [f8]   'enlarge-window)
(global-set-key [S-f8] 'enlarge-window-horizontally)

(global-set-key [f9]  'describe-key-briefly)
(global-set-key [S-f9] '(lambda()(interactive)
                          (if case-fold-search
                              (progn (setq case-fold-search nil)(message "case sensitive Search mode"))
                            (progn (setq case-fold-search t)(message "ignore case Search mode")))
                          ))

(global-set-key [f10] 'window-toggle-division)
(global-set-key [S-f10] 'window-toggle-division-reverse)

(global-set-key [f11] 'toggle-truncate-lines)  ;; Show Desktop (MAC OSX)
(global-set-key [f12] 'global-linum-mode)
(global-set-key [S-f11] 'scroll-right)
(global-set-key [S-f12] 'scroll-left)


;;====================================
;;;; press left at top of window then kill buffer and show dired
;;====================================
(global-set-key [left] 'ak-left-char)
;;(global-set-key (kbd "C-b") 'ak-left-char)

(defun ak-left-char (&optional arg)
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
(defun kill-buffer-and-dired()
  "kill this buffer and show current directory."
  ;;(interactive)
  (if (string= major-mode "dired-mode")
      (kill-buffer nil)
    (find-alternate-file "."))
  )

;;========================A=========B===
;;; rotate 2 screen  A|B ---  B|A  ---
;;========================B=========A===
(defun org-xor (a b)
  "Exclusive or."
  (if a (not b) b))
(defun window-toggle-division (&optional reverse)
  "toggle window ver-hor divide"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "one window"))
  (let ((before-height (window-height))
        (before-minx (nth 0 (window-edges)))
        (before-miny (nth 1 (window-edges)))
        (after-minx)
        (after-miny)
        (other-buf (window-buffer (next-window))))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (progn
          (split-window-vertically)            ;; ---------------
          (if (org-xor reverse (= before-minx (nth 0 (window-edges))))
              (other-window 1)
            )
          (switch-to-buffer other-buf)
          (other-window 1)
          )
      (progn
        (split-window-horizontally)            ;;     A | B
        (if (org-xor reverse (not (= before-miny (nth 1 (window-edges)))))
            (other-window 1)
          )
        (switch-to-buffer other-buf)
        (other-window 1)
        )
      )
    )
  )
(defun window-toggle-division-reverse ()
  "toggle window ver-hor divide"
  (interactive)
  (window-toggle-division t)
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
                (split-window)
          (delete-other-windows)))

;;====================================
;;;;divide/other screen
;;====================================
(defun ak-divide-screen-or-other()
  "Divide one window or move to next window."
  (interactive)
        (if (one-window-p)
                (split-window)
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



;; ------ 06buffer.el ------

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

(defun list-buffers-if-exist()
  (and (get-buffer "*Buffer List*") (get-buffer-window (get-buffer "*Buffer List*")) (list-buffers)))

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)
(defun ak-kill-buffer()
  (interactive)
  (kill-buffer)
  (list-buffers-if-exist))

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

(defadvice delete-window (after AK-delete-window )
  "Delete window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'delete-window)

(defadvice find-file (after AK-find-file )
  "Find-File and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'find-file)

;; (defadvice view-filee (after AK-view-file )
;;   "View-File and change buffer-list."
;;   (list-buffers-if-exist))
;; (ad-activate 'view-filee)

(defadvice shell (after AK-shell)
  "M-x shell"
  (list-buffers-if-exist))
(ad-activate 'shell)

(defadvice dired-find-file-hexl (after AK-dired-find-file-hexl )
  "Find-File-Hexl and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'dired-find-file-hexl)

(defadvice dired (after AK-dired )
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'dired)



;; ------ 07shell.el ------

;;====================================
;;;; shell-mode
;;====================================
(global-set-key (kbd "M-s") 'shell) ;; M-x shell

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

(define-key shell-mode-map  [f5]     '(lambda()(interactive)(dirs)))
(define-key comint-mode-map [home]   'beginning-of-buffer)
(define-key comint-mode-map [end]    'end-of-buffer)
(define-key comint-mode-map [C-up]   '(lambda()(interactive)(scroll-down 1)))
(define-key comint-mode-map [C-down] '(lambda()(interactive)(scroll-up 1)))
(define-key comint-mode-map [up]     'ak-shell-up)
(define-key comint-mode-map [down]   'ak-shell-down)
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



;; ------ 08mode.el ------

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;;view-mode
;;====================================
(require 'view)
(define-key view-mode-map [f5] '(lambda()(interactive)(revert-buffer nil t t)))


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
	       ;;(list "~/.emacs.d/markdown/Clearness.css")
	       (list "~/.emacs.d/markdown/Solarized(Dark).css")
	       ;;(list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css")
	       )
	 ))

;;====================================
;;;; elpy  python developing environment
;;====================================
(if (boundp 'elpy-enable)
    (elpy-enable))

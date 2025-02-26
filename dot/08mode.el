


;; ------ 08mode.el ------

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;; skk かな漢字変換
;;====================================
;; (ak-package-init-once)
;; M-x package-install RET ddskk RET
;; M-x package-install RET ddskk-posframe RET
(require 'package)       ;;for package-installed-p
(when (package-installed-p 'ddskk)
  (setq default-input-method "japanese-skk")
  )

(with-eval-after-load "skk"
  (message "skk loaded")
  ;; isearch と統合。
  (load "~/.emacs.d/site-lisp/skk-setup")
  ;; x 以外でも前候補。
  (if (display-graphic-p)
      (define-key skk-j-mode-map (kbd "S-SPC") 'skk-previous-candidate)) ;;emacs.app
  (define-key skk-j-mode-map (kbd "M-DEL") 'skk-previous-candidate) ;;iTerm2 -nw
  ;; 辞書登録ミニバッファから、前候補(x,S-SPC,M-DEL) で抜けるように関数変更。
  (load "~/.emacs.d/site-lisp/ak-skk-patch")
  ;; 候補表示をかっこよく。
  (when (and (package-installed-p 'ddskk-posframe) (display-graphic-p))
    (ddskk-posframe-mode t))
  ;; 日本語モードで終了した時辞書登録。
  (global-set-key (kbd "C-x C-c") 'skk-kill-emacs-without-saving-jisyo)
  (define-key skk-j-mode-map (kbd "C-x C-c") 'save-buffers-kill-terminal)
  )

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

(or (ak-validstrp (getenv "DICTIONARY")) (setenv "DICTIONARY" "en_US")) ;;default dictionary
;; (or (ak-validstrp (getenv "DICPATH"))
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

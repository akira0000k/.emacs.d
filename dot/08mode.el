


;; ------ 08mode.el ------

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;;view-mode
;;====================================
;; M-x view-mode  ==>  M-x v
(defalias 'v 'view-mode)
(global-set-key (kbd "ESC <f1>") #'(lambda() (interactive)(view-mode t)))
;;  "E"     #'View-exit-and-edit
;;  "q"     #'View-quit  --> [ak-]kill-current-buffer
(setq view-inhibit-help-message t)

(setq view-mode-hook
      '(lambda()
	 (when view-mode
	   (message "View mode: type i (edit), Esc-f1 (view), :w (save), :q (kill)")
	   )))

(with-eval-after-load 'view
  (define-key view-mode-map [f5] #'(lambda()(interactive)(revert-buffer nil t t)))
  (define-key view-mode-map "i" #'(lambda()(interactive)(message "editing")(View-exit)))
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
  (define-key view-mode-map (kbd "DEL") 'ak-scroll-page-backward)
  (define-key view-mode-map (kbd "SPC") 'ak-scroll-page-forward)
  (define-key view-mode-map "　" 'ak-scroll-page-forward)
  (define-key view-mode-map "G" 'end-of-buffer)
  (define-key view-mode-map "o" #'(lambda () (interactive "^") (View-scroll-to-buffer-end) (goto-char (point-max))))
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

(autoload 'buffer-focus-in-callback  "~/.emacs.d/site-lisp/buffer-focus-hook.el")

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




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

;; error in process sentinel: elpy-rpc--default-error-callback: peculiar error: "exited abnormally with code 1"
;; M-x elpy-rpc-reinstall-virtualenv

(if (fboundp 'elpy-enable)
    (elpy-enable))

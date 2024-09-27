


;; ------ 08mode.el ------

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")


;;====================================
;;;;view-mode
;;====================================
(with-eval-after-load 'view
  (define-key view-mode-map [f5] #'(lambda()(interactive)(revert-buffer nil t t))))


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
(if (fboundp 'markdown-mode)
    (progn
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
		     (list "~/.emacs.d/css/md.css")
		     ;;(list "~/.emacs.d/markdown/Clearness.css")
		     ;;(list "~/.emacs.d/markdown/Solarized(Dark).css")
		     ;;(list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css")
		     )
	       ))))

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

(autoload 'buffer-focus-in-callback "~/.emacs.d/site-lisp/buffer-focus-hook.el")

(defun ak-org-focus-in ()
  (message "no xcv."))

(defun ak-org-focus-out ()
  (message "xcv enable.")
  t)

(with-eval-after-load 'org
  ;;           C-y is not cua-paste but org-yank
  (define-key org-mode-map (kbd "C-y") 'org-yank)
  )

(add-hook 'org-mode-hook
	  (lambda()
	    (setq-local cua-enable-cua-keys nil)
	    (buffer-focus-in-callback 'ak-org-focus-in)
	    (buffer-focus-out-callback 'ak-org-focus-out)
	    ))

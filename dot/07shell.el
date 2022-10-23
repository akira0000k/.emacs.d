


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

(setq comint-password-prompt-regexp
      "\\(\\([Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(Enter \\|Repeat \\|Bad \\)?[Pp]assphrase\\)\\(, try again\\)?\\( for [^:]+\\)?:\\s *\\'"
      )




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

(define-key shell-mode-map  [f5]     #'(lambda()(interactive)(dirs)))
(define-key comint-mode-map [home]   'beginning-of-buffer)
(define-key comint-mode-map [end]    'end-of-buffer)
(define-key comint-mode-map [C-up]   #'(lambda()(interactive)(scroll-down 1)))
(define-key comint-mode-map [C-down] #'(lambda()(interactive)(scroll-up 1)))
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

;(setq comint-password-prompt-regexp
;      "\\(\\([Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(Enter \\|Repeat \\|Bad \\)?[Pp]assphrase\\)\\(, try again\\)?\\( for [^:]+\\)?:\\s *\\'"
;      )

(setq comint-password-prompt-regexp
   "\\(^ *\\|\\( SMB\\|'s\\|Bad\\|CVS\\|Current\\|Enter\\(?: \\(?:Auth\\|same\\|the\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Repeat\\|Retype\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|login\\) +.*\\)\\(?:adgangskode\\|contrasenya\\|contraseña\\|decryption key\\|encryption key\\|geslo\\|hasło\\|heslo\\|iphasiwedi\\|jelszó\\|lozinka\\|lösenord\\|mot de passe\\|mật khẩu\\|parola\\|pasahitza\\|pass phrase\\|passcode\\|passord\\|passphrase\\|passwor[dt]\\|pasvorto\\|pin\\|salasana\\|senha\\|slaptažodis\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'")

;; (package-initialize)
;; (setq package-archives
;;       '(("gnu" . "http://elpa.gnu.org/packages/")
;;         ("melpa" . "http://melpa.org/packages/")
;;         ("org" . "http://orgmode.org/elpa/")))

;;  ;; 作成するファイルやdirectoryに　グループ書き込み権限をつけaる
;;  ;; for check
;;  ;;(default-file-modes)  ;;=> #o755
;;  (set-default-file-modes #o775)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フレーム関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 起動時のフレーム設定
(setq initial-frame-alist
      (list
      '(top . 200)
      '(left . 500)
      '(width . 151)
      '(height . 62)))
(setq default-frame-alist initial-frame-alist)

;;;    M-x describe-theme    =>tab ..show themes available
;(load-theme 'deeper-blue t)
;;(load-theme 'manoj-dark t)
;;(load-theme 'misterioso t)
;;(load-theme 'tango-dark t)
;;;(load-theme 'tsdh-dark t)
;;(load-theme 'wheatgrass t)
;;;(load-theme 'wombat t)

;; emacs.app?  shell emacs?
(if (getenv "PWD")
    (message "shell start")
  (message "launch app")

  ;;(setenv  "PATH" (concat "/usr/local/bin:/Users/Akira/bin:/Users/Akira/go/bin:/usr/local/bin/go:" (getenv "PATH")))
  ;;====================================
  ;;  exec-path
  ;;====================================
  (load "~/.emacs.d/site-lisp/exec-path-from-shell.el")
  (add-to-list 'exec-path-from-shell-variables "A_DIRECTORY")
  (add-to-list 'exec-path-from-shell-variables "B_DIRECTORY")
  (add-to-list 'exec-path-from-shell-variables "C_DIRECTORY")
  (add-to-list 'exec-path-from-shell-variables "E_DIRECTORY")
  (add-to-list 'exec-path-from-shell-variables "LANG")
  (exec-path-from-shell-initialize)
  )

;;(if (string= (getenv "LANG") "ja_JP.UTF-8")
;;    (message "getenv LANG = ja_JP.UTF-8")
;;  (setenv "LANG" "ja_JP.UTF-8")
;;  (message "LANG was set to ja_JP.UTF-8"))


(or (setq a-directory (getenv "A_DIRECTORY")) (setq a-directory "~/data"))
(or (setq b-directory (getenv "B_DIRECTORY")) (setq b-directory "~/bin"))
(or (setq c-directory (getenv "C_DIRECTORY")) (setq c-directory "~/Documents"))
(or (setq e-directory (getenv "E_DIRECTORY")) (setq e-directory "~/Desktop"))


;; lsを GNU coreutil gls に変える
(setq insert-directory-program "/usr/local/bin/gls")


(load "~/.emacs.d/.emacs.el")



(if (not (string= window-system "ns"))
    ;;; -nw no window emacs
    (progn
      ;;(load-theme 'tango-dark t)  ;;background 111 nara warukunai ga...
      (custom-set-faces
       '(font-lock-function-name-face ((t (:foreground "blue" :weight semi-bold)))) ;;;for xterm-256color
       '(link ((t (:foreground "cyan" :underline t))))
       '(minibuffer-prompt ((t (:foreground "cyan"))))
       '(shadow ((t (:foreground "#32cd32")))) ;;;for xterm-256color
       )
      (message "emacs -nw"))
  ;;;else window emacs ;;;
  (load-theme 'deeper-blue t)
  (custom-set-faces
   '(mode-line-buffer-id ((t (:foreground "dark magenta" :weight bold))))
   '(region ((t (:extend t :background "dark red"))))
   )
  ;; (load-theme 'tango-dark t)
  ;; (custom-set-faces
  ;;  '(default ((t (:inherit nil :extend nil :stipple nil :background "#010101" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo"))))
  ;;  '(font-lock-function-name-face ((t (:foreground "#7a83ff"))))
  ;;  '(shadow ((t (:foreground "lime green"))))
  ;;  )
  (message "emacs Xwindow"))


;;;;;;;;;;;;;;;;;;;;;added by emacs;;;;;;;;;;;;;;;;;;;;;;
;;   default  '(search-whitespace-regexp "\\s-+")
(put 'scroll-left 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ange-ftp-ftp-program-args '("-i" "-n" "-g" "-v" "-e"))
 '(ange-ftp-ftp-program-name "/usr/local/Cellar/inetutils/2.0_1/bin/ftp")
 '(case-fold-search t)
 '(comint-password-prompt-regexp
   "\\(\\([Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(Enter \\|Repeat \\|Bad \\)?[Pp]assphrase\\)\\(, try again\\)?\\( for [^:]+\\)?:\\s *\\'")
 '(comint-process-echoes t)
 '(default-input-method "japanese")
 '(dired-dwim-target nil)
 '(search-whitespace-regexp "\\s-+")
 '(split-width-threshold nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

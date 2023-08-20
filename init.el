;; M-x package-refresh-contents RET
;; M-x package-list-package
;; M-x package-install RET magit RET
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; (package-refresh-contents)
;; ;; Installs packages
;; ;; myPackage contains a list of package names
;; (defvar myPackages
;;   '(
;;     markdown-mode
;;     markdown-preview-mode
;;     elpy
;;     )
;;   )
;; ;;Scans the list in myPackages
;; ;; If the package listed is not already installed, install it
;; (mapc #'(lambda (package)
;;  	  (unless (package-installed-p package)
;;  	    (package-install package)))
;;       myPackages)

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
      '(top . 20)
      '(left . 100)
      '(width . 151)
      '(height . 53)))
(setq default-frame-alist initial-frame-alist)

;;;    M-x describe-theme    =>tab ..show themes available
;;(load-theme 'deeper-blue      t)
;;(load-theme 'manoj-dark       t)
;;(load-theme 'misterioso       t)
;;(load-theme 'modus-vivendi    t)
;;(load-theme 'tango-dark       t)
;;(load-theme 'tsdh-dark        t)
;;(load-theme 'wheatgrass       t)
;;(load-theme 'wombat	        t)
;;;;(load-theme 'adwaita        t)
;;;;(load-theme 'dichromacy     t)
;;;;(load-theme 'leuven	        t)
;;;;(load-theme 'light-blue     t)
;;;;(load-theme 'modus-operandi t)
;;;;(load-theme 'tango	        t)
;;;;(load-theme 'tsdh-light     t)
;;;;(load-theme 'whiteboard     t)

;;====================================
;;  exec-path
;;====================================
(defun ak-setenv()
    (load "~/.emacs.d/site-lisp/exec-path-from-shell.el")
    (add-to-list 'exec-path-from-shell-variables "A_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "B_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "C_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "E_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "LANG")
    (add-to-list 'exec-path-from-shell-variables "LC_COLLATE")
    (exec-path-from-shell-initialize)
    )

;; emacs.app?  shell emacs?
(if (getenv "PWD")
    (message "shell start")
  (message "launch app")
  ;;(setenv  "PATH" (concat "/usr/local/bin:/Users/Akira/bin:/Users/Akira/go/bin:/usr/local/bin/go:" (getenv "PATH")))
  (ak-setenv)
  )
;;;; ls sort order error
;;(setenv "LC_COLLATE" "C")

;;(if (string= (getenv "LANG") "ja_JP.UTF-8")
;;    (message "getenv LANG = ja_JP.UTF-8")
;;  (setenv "LANG" "ja_JP.UTF-8")
;;  (message "LANG was set to ja_JP.UTF-8"))


(or (getenv "A_DIRECTORY") (setenv "A_DIRECTORY" (concat (getenv "HOME") "/Downloads")))
(or (getenv "B_DIRECTORY") (setenv "B_DIRECTORY" (concat (getenv "HOME") "/bin")))
(or (getenv "C_DIRECTORY") (setenv "C_DIRECTORY" (concat (getenv "HOME") "/Documents")))
(or (getenv "E_DIRECTORY") (setenv "E_DIRECTORY" (concat (getenv "HOME") "/Desktop")))


;;(load "~/.emacs.d/.emacs.el")
(load "~/.emacs.d/dot/.emacs.el")

;; Tramp
;; C-x d  /docker:user@container:
;; C-x d  /ftp:user@host:
;;;; (setq ange-ftp-ftp-program-args '("-i" "-n" "-g" "-v" "-e"))
;;;; (setq ange-ftp-ftp-program-name "/usr/local/bin/ftp")

;;;; ;; Mac OSX  lsを GNU coreutil gls に変える
;;;; (setq insert-directory-program "/usr/local/bin/gls")
;;;; ;; .zshrc  export PS1="%n@%m %~ %# "
;;;; (setq dirtrack-list '(" \\(.*\\) % " 1))

;;;; ;; linux in Docker
;;;; ;; .bashrc  PS1='$0@\u:\w\$ '
;;;; (setq shell-file-name "/bin/bash")
;;;; (setq dirtrack-list '(":\\(.*\\)[#\\$]" 1))

;;;; ;; lsでなく lisp 版を使う
;;;; (setq ls-lisp-use-insert-directory-program nil)
;;;; (require 'ls-lisp)

;; (setq markdown-command "markdown")
;; (setq markdown-command "markdown_py")
;; (setq markdown-command "pandoc")   ;; brew install pandoc

;; ;; VC (version control) is standard lisp package.
;; ;; Cancel .git check when no "git" command installed.
;; (setq vc-handled-backends nil)

;; VSCODE
;; Settings
;; Terminal > Integrated: Mac Option Is Meta...check
;; f1, f3, S-f3, f5   desabled
;; MacOSX opt+euin_ = "dead key". M-ee M-uu M-ii M-nn M-_a = éüîñà
(defun ak-vscode ()
  "vscode key setting"
  (interactive)
  (global-set-key (kbd "M-,") 'beginning-of-buffer)
  (global-set-key (kbd "M-.") 'end-of-buffer)
  (define-key input-decode-map (kbd "M-<") (kbd "M-S-,"))
  (define-key input-decode-map (kbd "M->") (kbd "M-S-."))
  (global-set-key (kbd "C-M-p") 'half-page-down)
  (global-set-key (kbd "C-M-n") 'half-page-up)
  ;;;; (define-key input-decode-map (kbd "¥") (kbd "\\"))
  (if (boundp 'cua--cua-keys-keymap)
      (global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)
    (message "cua boundp? no."))
  )

(defun ak-puttykey ()
  "PuTTY key setting"
  (interactive)
  (define-key input-decode-map (kbd "M-O q") [end])       ;; <kp-1>
  (define-key input-decode-map (kbd "M-O r") [down])      ;; <kp-2>
  (define-key input-decode-map (kbd "M-O s") [next])      ;; <kp-3>
  (define-key input-decode-map (kbd "M-O t") [left])      ;; <kp-4>
  (define-key input-decode-map (kbd "M-O v") [right])     ;; <kp-6>
  (define-key input-decode-map (kbd "M-O w") [home])      ;; <kp-7>
  (define-key input-decode-map (kbd "M-O x") [up])        ;; <kp-8>
  (define-key input-decode-map (kbd "M-O y") [prior])     ;; <kp-9>
  (define-key input-decode-map (kbd "M-O n") [deletechar])
  (define-key input-decode-map (kbd "M-[ 1 ; 2 ~") (kbd "S-<home>"))
  (define-key input-decode-map (kbd "M-[ 4 ; 2 ~") (kbd "S-<end>"))
  (global-set-key [home] 'beginning-of-buffer)
  (global-set-key [end]  'end-of-buffer)
  (ak-vscode)
  )
;;;; (if (not (string= window-system "ns"))
(if (not (display-graphic-p))
    ;;; -nw no window emacs
    (progn
      ;; for MAC OSX iTerm2 3.4.16  same as XWindow Emacs
      (load-theme 'deeper-blue t)
      (custom-set-faces
       '(font-lock-function-name-face ((t (:foreground "#7a83ff"))))
       '(mode-line-buffer-id ((t (:foreground "dark magenta" :weight bold))))
       '(region ((t (:extend t :background "dark red"))))
       )

      ;; ;; for debian   TERM=xterm emacs -nw
      ;; (custom-set-faces
      ;;  ;;'(font-lock-function-name-face ((t (:foreground "blue" :weight semi-bold)))) ;;;for xterm-256color
      ;;  '(help-key-binding ((t (:background "blue"))))
      ;;  '(link ((t (:foreground "cyan" :underline t))))
      ;;  '(magit-section-highlight ((t (:extend t :background "blue"))))
      ;;  '(minibuffer-prompt ((t (:foreground "cyan"))))
      ;;  ;;'(shadow ((t (:foreground "#32cd32")))) ;;;for xterm-256color
      ;;  '(smerge-markers ((t (:extend t :background "blue"))))
      ;;  '(region ((t (:extend t :background "dark red"))))
      ;;  )

      (menu-bar-mode -1)
      (if (string= (getenv "TERM_PROGRAM") "vscode")
	  (progn
	    ;;;;"terminal.integrated.macOptionIsMeta": true
	    (message "vscode")
	    (ak-vscode)
	    )
	)
      (if (string= (getenv "VT100") "yes")
	  (progn
	    ;;;; in screen start like this. TERM=vt100 VT100=yes emacs -nw
	    (message "vt100 screen")
	    (load "~/.emacs.d/site-lisp/pc-teraconf-21.el")
	    (custom-set-faces
	     '(region ((t (:extend t :background "dark red" :underline t))))
	     )
	    )
	)
      (if (string= (getenv "PUTTY") "yes")
	  (progn
	    (ak-puttykey)
	    (message "PuTTY terminal")))
      (message "emacs -nw"))
  ;;;else window emacs ;;;
  (load-theme 'deeper-blue t)
  ;;;;                                $ brew tap homebrew/cask-fonts
  ;;;;                                $ brew install font-hackgen-nerd
  (let ((installfont "HackGen Console NF-14"))
    (if (x-list-fonts installfont)
	(set-face-font 'default installfont)
      (message "%s font not installed" installfont)))
  (custom-set-faces
   '(font-lock-function-name-face ((t (:foreground "#7a83ff"))))
   '(mode-line-buffer-id ((t (:foreground "dark magenta" :weight bold))))
   '(region ((t (:extend t :background "dark red"))))
   )
  
  ;; (load-theme 'tango-dark t)
  ;; (custom-set-faces
  ;;  '(default ((t (:inherit nil :extend nil :stipple nil :background "#010101" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo"))))
  ;;  '(font-lock-function-name-face ((t (:foreground "#7a83ff"))))
  ;;  '(shadow ((t (:foreground "lime green"))))
  ;;  )
  ;;;; (define-key input-decode-map (kbd "¥") (kbd "\\"))  ;; macOS Monterey 12.5
  (setq initial-buffer-choice "./")  ;; macOS Ventura  image-type: Invalid image type ‘svg’
  (menu-bar-mode 1)
  (message "emacs Xwindow"))

;; face etc.
;; M-x list-faces-display
;; M-x describe-face

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
;;;;;;;;;;;;;;;;;;;;;added by emacs;;;;;;;;;;;;;;;;;;;;;;custom.el
(put 'scroll-left 'disabled nil)

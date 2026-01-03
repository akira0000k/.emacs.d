;;
;; How to add a timestamp to each entry in Emacs' *Messages* buffer?
;; https://emacs.stackexchange.com/questions/32150/how-to-add-a-timestamp-to-each-entry-in-emacs-messages-buffer
;;
(defun my/ad-timestamp-message (FORMAT-STRING &rest args)
  "Advice to run before `message\\=' that prepends a timestamp to each message.
	Activate this advice with:
	  (advice-add \\='message :before \\='my/ad-timestamp-message)
	Deactivate this advice with:
	  (advice-remove \\='message \\='my/ad-timestamp-message)"
  (if message-log-max
      (let ((deactivate-mark nil)
	    (inhibit-read-only t))
	(with-current-buffer "*Messages*"
	  (goto-char (point-max))
	  (if (not (bolp))
	      (newline))
	  (insert (format-time-string "[%F %T.%3N] "))))))
(advice-add 'message :before 'my/ad-timestamp-message)
(message "init.el loading")


;; Package init
(defun ak-package-init()
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ;; M-x package-refresh-contents RET
  (package-refresh-contents))

;; ;; (ak-package-init)
;; ;; ;; M-x package-list-packages RET
;; ;; (package-list-packages)
;; ;;  
;; ;; ;; M-x package-install RET magit RET
;; ;; (package-install 'magit)
;; ;;
;; ;; ;; M-x package-delete RET somepkg RET
;; ;; ;; M-x package-autoremove

;; Pre install packages
(setq myPackage
      '(
	markdown-mode
	))
;;Scans the list
;; If the package listed is not already installed, install it
(require 'package)
(let ((package-initp nil))
  (dolist (pk myPackage)
    (if (package-installed-p pk)
	(message "%s already installed" (symbol-name pk))
      (message "%s not installed" (symbol-name pk))
      (unless package-initp
	(setq package-initp t)
	(ak-package-init))
      (package-install pk)
      ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フレーム関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 起動時のフレーム設定
(setq initial-frame-alist
      (list
      '(top . 20)
      '(left . 100)
      '(width . 120)
      '(height . 40)))
(setq default-frame-alist initial-frame-alist)

;;;    M-x describe-theme    =>tab ..show themes available
;;(load-theme 'deeper-blue      t)
;;(load-theme 'manoj-dark       t)
;;(load-theme 'misterioso       t)
;;(load-theme 'modus-vivendi    t)
;;(load-theme 'tango-dark       t)
;;(load-theme 'leuven-dark      t)
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
    (load "~/.emacs.d/site-lisp/exec-path-from-shell")
    (add-to-list 'exec-path-from-shell-variables "A_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "B_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "C_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "E_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "Z_DIRECTORY")
    (add-to-list 'exec-path-from-shell-variables "LANG")
    (add-to-list 'exec-path-from-shell-variables "LC_COLLATE")
    (add-to-list 'exec-path-from-shell-variables "DICTIONARY")
    (add-to-list 'exec-path-from-shell-variables "DICPATH")
    (exec-path-from-shell-initialize)
    )
(defun ak-validstrp(str)
  (and str (> (length str) 0)))
;; emacs.app?  shell emacs?
(if (getenv "PWD")
    (message "started in diretory %s" (getenv "PWD"))
  (message "launch app")
  ;;(setenv  "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
  (ak-setenv)
  (and (ak-validstrp (getenv "Z_DIRECTORY"))
       (setq dired-default-directory (getenv "Z_DIRECTORY")))
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

;; ;; 作成するファイルやdirectoryに　グループ書き込み権限をつける
;; ;;(default-file-modes)  ;;=> #o755
;; (set-default-file-modes #o775)

(message "load .emacs.el")
(if (load "~/.emacs.d/.emacs.elc" t t t)
    (message "load .emacs.elc...done")
  (load "~/.emacs.d/dot/.emacs")
  (message "load dot/.emacs...done")
  (if (eq 1 (length command-line-args))
      (setq initial-buffer-choice "~/.emacs.d/dot"))
  )

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
  ;;;; (define-key input-decode-map (kbd "¥") (kbd "\\"))
  )

(defun ak-puttykey ()
  "PuTTY key setting"
  (interactive)
  ;;(define-key input-decode-map (kbd "M-O q") [end])       ;; <kp-1>
  ;;(define-key input-decode-map (kbd "M-O r") [down])      ;; <kp-2>
  ;;(define-key input-decode-map (kbd "M-O s") [next])      ;; <kp-3>
  ;;(define-key input-decode-map (kbd "M-O t") [left])      ;; <kp-4>
  ;;(define-key input-decode-map (kbd "M-O v") [right])     ;; <kp-6>
  ;;(define-key input-decode-map (kbd "M-O w") [home])      ;; <kp-7>
  ;;(define-key input-decode-map (kbd "M-O x") [up])        ;; <kp-8>
  ;;(define-key input-decode-map (kbd "M-O y") [prior])     ;; <kp-9>
  ;;(define-key input-decode-map (kbd "M-O n") [deletechar])
  (define-key input-decode-map (kbd "M-[ 1 ; 2 ~") (kbd "S-<home>"))
  (define-key input-decode-map (kbd "M-[ 4 ; 2 ~") (kbd "S-<end>"))
  (global-set-key [home] 'beginning-of-buffer)
  (global-set-key [end]  'end-of-buffer)
  ;;(ak-vscode)
  )


;; face etc.
;; M-x list-faces-display
;; M-x describe-face

(defun ak-theme-deeper-blue()
  (load-theme 'deeper-blue t)
  (message "load-theme deeper-blue")
  (set-face-attribute 'font-lock-function-name-face nil :foreground "#7a83ff")  ;;dired directory name
  (set-face-attribute 'region nil :extend t :background "dark red")  ;;selected region
  )
(defun ak-theme-tango-dark()
  (load-theme 'tango-dark t)
  (message "load-theme tango-dark")
  (set-face-attribute 'default nil :background "#131313" :foreground "#dddddd")  ;;back/foreground color
  (set-face-attribute 'font-lock-function-name-face nil :foreground "#7a83ff")  ;;dired directory name
  ;;(set-face-attribute 'shadow nil :foreground "lime green")  ;;dired backupfile~ name
  )
(defun ak-theme-manoj-dark()
  (load-theme 'manoj-dark t)
  (message "load-theme manoj-dark")
  (set-face-attribute 'region t :extend nil :background "blue3" :underline t)
  (set-face-attribute 'isearch t :background "palevioletred2" :foreground "brown4" :underline t :weight 'bold)
  (set-face-attribute 'lazy-highlight t :background "paleturquoise4" :underline t)
  (set-face-attribute 'show-paren-match t :background "steelblue3" :underline t)
  (set-face-attribute 'query-replace t :background "palevioletred2" :foreground "brown4" :weight 'bold)
  )
(defun ak-theme-misc()
  (message "ak-theme-misk")
  (set-face-attribute 'default nil :background "#000000" :foreground "#dddddd")  ;;back/foreground color
  (set-face-attribute 'font-lock-function-name-face nil :foreground "#7a83ff")  ;;dired directory name
  (set-face-attribute 'help-key-binding nil :background "blue")
  (set-face-attribute 'link nil :foreground "cyan" :underline t)
  (set-face-attribute 'minibuffer-prompt nil :foreground "cyan")
  (set-face-attribute 'shadow nil :foreground "#32cd32") ;;dired backupfile~ name
  (set-face-attribute 'region nil :extend t :background "dark red")  ;;selected region
  )

(message "window check")
;;;; (if (not (string= window-system "ns"))
(if (not (display-graphic-p))
    ;;; -nw no window emacs
    (progn
      (cond
       ((string= (getenv "SCREEN") "yes")
	;; in screen xterm env.  SCREEN=yes emacs -nw
	;; Selected region IS TRANSPARENT!
	;; MacOSX + screen-5.0.0(homeblew) + iTerm2 Transparency: 50%
	;;   Keep background colors opaque,  Use transparency.
	(message "load-theme wheatgrass")
	(load-theme 'wheatgrass t))
       ((string= (getenv "VT100") "yes")
	;; in screen start like this. TERM=vt100 VT100=yes emacs -nw
	;; MacOSX + screen + iTerm2 Transparency: 0%
	(message "vt100 screen")
	(ak-theme-manoj-dark)
	(load "~/.emacs.d/site-lisp/pc-teraconf-21.el"))
       ((string= (getenv "PUTTY") "yes")
	;; for PuTTY terminal start like this. PUTTY=yes emacs -nw
	(message "PuTTY terminal")
	(ak-puttykey)
	(ak-theme-misc))
       ((not (memq system-type '(darwin)))
	;; for debian   TERM=xterm emacs -nw
	(message "No Color setting for linux")
	)
       ((string= (getenv "PLAIN") "yes")
	(message "No Theme test"))
       ((string= (getenv "BLUE") "yes")
	;; for MAC OSX iTerm2 3.4.16  same as XWindow Emacs
	(ak-theme-deeper-blue))
       (t
	(ak-theme-tango-dark))
       )

      (if (string= (getenv "TERM_PROGRAM") "vscode")
	  (progn
	    ;;;;"terminal.integrated.macOptionIsMeta": true
	    (message "vscode")
	    (ak-vscode)
	    )
	)

      (menu-bar-mode -1)
      (message "emacs -nw"))
  ;;;else window emacs ;;;
  ;;;;                                $ brew tap homebrew/cask-fonts
  ;;;;                                $ brew install font-hackgen-nerd
  (let ((installfont "HackGen Console NF-18"))
    (if (x-list-fonts installfont)
	(set-face-font 'default installfont)
      (message "%s font not installed" installfont)))
  (cond
   (nil
    (ak-theme-deeper-blue))
   (t
    (ak-theme-tango-dark))
   )
  ;;;; (define-key input-decode-map (kbd "¥") (kbd "\\"))  ;; macOS Monterey 12.5
  ;; (setq initial-buffer-choice "./")  ;; macOS Ventura  image-type: Invalid image type ‘svg’
  (menu-bar-mode 1)
  (message "emacs Xwindow"))

;;;; https://www2.lib.uchicago.edu/keith/emacs/
;;;;              Table 50: Browse URL Browsers
;;;; |            M-x Command            |       Browser       |
;;;; | browse-url-default-macosx-browser | Mac OS open command |
(when (memq system-type '(darwin))
  ;;(require 'dired)
  ;;(define-key dired-mode-map "W" 'browse-url-of-dired-file)
  (defun browse-url-of-dired-file ()
    "In Dired, ask a WWW browser to display the file named on this line."
    (interactive)
    (let ((tem (dired-get-filename t t)))
      (if (not tem)
	  (error "No file on this line")
	(let ((filepath (expand-file-name tem)))
	  ;;(message "dired W %s" filepath)
	  (start-process (concat "open " filepath) nil "open" filepath)
	  ))))
  )


;; Read custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))
;; package-selected-packages contains a list of packages installed manually. see ./custom.el
;; Update package-selected-packages. If empty, add non-dependent packages.
(let ((need-save nil))
  (unless package-selected-packages
    (setq package-selected-packages (package--find-non-dependencies))
    (when package-selected-packages
      (setq need-save t)
      (message "non dependent package list was made."))
    )
  ;; myPackage member is added as manually installed.
  (dolist (pk myPackage)
    (unless (member pk package-selected-packages)
      (setq need-save t)
      (push pk package-selected-packages)
      (message "%s added to selected package list." (symbol-name pk))
      ))
  (when need-save
    (customize-save-variable 'package-selected-packages package-selected-packages)
    )
)

(message "init.el ...done")
(advice-remove 'message 'my/ad-timestamp-message)
;;;;;;;;;;;;;;;;;;;;;added by emacs;;;;;;;;;;;;;;;;;;;;;;
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)




;; ------ 07buffer.el ------

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
  (let ((buflist (get-buffer "*Buffer List*")))
    (if buflist
	(if (get-buffer-window buflist)
	    ;; exists in same frame, refresh as C-x C-b
	    (list-buffers)
	  ;;else
	  (when (get-buffer-window-list buflist nil t)
	    ;; in other frame.
	    (list-buffers-noselect)
	    ))
      )))

;; avoid warning to redefined advice.
(setq ad-redefinition-action 'accept)

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    ;;; old "defadvice" style.
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)

;; kill current buffer.
;; kill top buffer of bufferlist and show "next" buffer.
(defun ak-kill-current-buffer()
  (interactive)
  (if (minibufferp)
      (abort-recursive-edit)
    (if (string-match "^\\*Buffer List\\*" (buffer-name))
	(kill-buffer)
      (let ((cb (current-buffer)))
	(ak-next-buffer)
	(ak-last-buffer)
	(kill-buffer cb)
	(list-buffers-if-exist)))))
(global-set-key [remap kill-current-buffer] 'ak-kill-current-buffer)
(global-set-key [remap kill-buffer] 'ak-kill-current-buffer)

;; kill buffer from menu, Close.
(defun ak-kill-this-buffer ()
  "Menu: File >Close, affecting buffer list imediately."
  ;;(message "kill this buffer done")
  (list-buffers-if-exist))
(advice-add 'kill-this-buffer :after #'ak-kill-this-buffer)

(defun ak-quit-window (&optional kill window)
  "Quit window and change buffer-list."
  ;;(message "quit window done")
  (list-buffers-if-exist))
(advice-add 'quit-window :after #'ak-quit-window)

(defun ak-bury-buffer (&optional buffer-or-name)
  "Bury buffer and change buffer-list."
  ;;(message "bury buffer done")
  (list-buffers-if-exist))
(advice-add 'bury-buffer :after #'ak-bury-buffer)

(defun ak-switch-to-buffer (buffer-or-name &optional norecord force-same-window)
  "Switch window and change buffer-list."
  ;;(message "switch to buffer done")
  (list-buffers-if-exist))
(advice-add 'switch-to-buffer :after #'ak-switch-to-buffer)

(defun ak-find-file (filename &optional wildcards)
  "Find-File and change buffer-list."
  ;;(message "find file done")
  (list-buffers-if-exist))
(advice-add 'find-file :after #'ak-find-file)

;;(setq ad-redefinition-action 'accept)
(defun ak-shell (&optional buffer file-name)
  "M-x shell"
  (list-buffers-if-exist))
(advice-add 'shell :after #'ak-shell)

(defun ak-dired (dirname &optional switches)
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(advice-add 'dired :after #'ak-dired)

(defun ak-dired-other-window (dirname &optional switches)
  "Dired other Window and change buffer-list."
  (list-buffers-if-exist))
(advice-add 'dired-other-window :after #'ak-dired-other-window)

(defun ak-info (&optional file-or-node buffer)
  "Enter Info, the documentation browser."
  (list-buffers-if-exist))
(advice-add 'info :after #'ak-info)

;; s-^ kill-some-buffers use it.  see files.el
(defun ak-before-kill-buffer-ask (buffer)
  "Show buffer."
  (switch-to-buffer buffer))
(advice-add 'kill-buffer-ask :before #'ak-before-kill-buffer-ask)


;; Auto Revert Interval 60 if Buffer Menu focused.

(with-eval-after-load 'autorevert
  (message "autorevert after load")
  (defvar auto-revert-interval-default nil)
  (defun ak-buffer-menu-focus-in ()
    (unless auto-revert-interval-default
      (setq auto-revert-interval-default auto-revert-interval))
    (setq auto-revert-interval 60)
    ;;(message "in  auto-revert-interval %d" auto-revert-interval)
    (auto-revert-set-timer)
    )
  (defun ak-buffer-menu-focus-out ()
    (setq auto-revert-interval auto-revert-interval-default)
    ;;(message "out auto-revert-interval %d" auto-revert-interval)
    (auto-revert-set-timer)
    t)

  (autoload 'buffer-focus-in-callback  "~/.emacs.d/site-lisp/buffer-focus-hook")
  (add-hook 'Buffer-menu-mode-hook
	    (lambda()
	      (buffer-focus-in-callback 'ak-buffer-menu-focus-in)
	      (buffer-focus-out-callback 'ak-buffer-menu-focus-out)
	      (add-hook 'kill-buffer-hook 'ak-buffer-menu-focus-out nil 'local)
	      ))
  ;;;;check exact revert timing
  ;;(setq auto-revert-use-notify nil)
)




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

;;(defun list-buffers-if-exist()
;;  (and (get-buffer "*Buffer List*") (get-buffer-window (get-buffer "*Buffer List*")) (list-buffers)))
(defun list-buffers-if-exist()
  (let ((buflist (get-buffer "*Buffer List*")))
    (if buflist
	(if (get-buffer-window buflist)
	    (list-buffers)
	  ;;else
	  (if (get-buffer-window-list buflist nil t)
	      (when (fboundp 'auto-revert-set-timer)
		;; Update Buffer List on other frame
		(let ((orgint auto-revert-interval))
		  (setq auto-revert-interval 0.1)
		  (auto-revert-set-timer)
		  (setq auto-revert-interval orgint)))
	    )))
    ))

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)
;; (defun ak-kill-buffer()
;;   (interactive)
;;   (kill-buffer)
;;   (list-buffers-if-exist))
;; (global-set-key [remap kill-buffer] 'ak-kill-buffer)

(defun ak-kill-current-buffer()
  (interactive)
  ;; enabling focus-out hook of org-mode
  (if (string= major-mode "org-mode")
      (if (fboundp 'ak-org-focus-out)
	  (ak-org-focus-out)))
  (kill-current-buffer)
  (list-buffers-if-exist))
(global-set-key [remap kill-current-buffer] 'ak-kill-current-buffer)
(global-set-key [remap kill-this-buffer] 'ak-kill-current-buffer)

(setq ad-redefinition-action 'accept)

;;(defadvice quit-window (after AK-quit-window )
;;  "Quit window and change buffer-list."
;;  (list-buffers-if-exist))
;;(ad-activate 'quit-window)
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

(defun ak-info (&optional file-or-node buffer)
  "Enter Info, the documentation browser."
  (list-buffers-if-exist))
(advice-add 'info :after #'ak-info)

;; s-^ kill-some-buffers use it.  see files.el
(defun ak-before-kill-buffer-ask (buffer)
  "Show buffer."
  (switch-to-buffer buffer))
(advice-add 'kill-buffer-ask :before #'ak-before-kill-buffer-ask)

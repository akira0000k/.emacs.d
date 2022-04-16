


;; ------ 06buffer.el ------

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
  (and (get-buffer "*Buffer List*") (get-buffer-window (get-buffer "*Buffer List*")) (list-buffers)))

;;;;buffer delete in *Buffer List* ddddd x works only 1 buffer.
;;;;    ;;; see --> buff-list.el
;;;;    (defadvice kill-buffer (after AK-kill-buffer )
;;;;      "Kill buffer and change buffer-list."
;;;;      (list-buffers-if-exist))
;;;;    (ad-activate 'kill-buffer)
(defun ak-kill-buffer()
  (interactive)
  (kill-buffer)
  (list-buffers-if-exist))

(defadvice quit-window (after AK-quit-window )
  "Quit window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'quit-window)

(defadvice bury-buffer (after AK-bury-buffer )
  "Quit window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'bury-buffer)

(defadvice switch-to-buffer (after AK-switch-to-buffer )
  "Switch window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'switch-to-buffer)

(defadvice delete-window (after AK-delete-window )
  "Delete window and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'delete-window)

(defadvice find-file (after AK-find-file )
  "Find-File and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'find-file)

;; (defadvice view-filee (after AK-view-file )
;;   "View-File and change buffer-list."
;;   (list-buffers-if-exist))
;; (ad-activate 'view-filee)

(defadvice shell (after AK-shell)
  "M-x shell"
  (list-buffers-if-exist))
(ad-activate 'shell)

(defadvice dired-find-file-hexl (after AK-dired-find-file-hexl )
  "Find-File-Hexl and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'dired-find-file-hexl)

(defadvice dired (after AK-dired )
  "Dired and change buffer-list."
  (list-buffers-if-exist))
(ad-activate 'dired)

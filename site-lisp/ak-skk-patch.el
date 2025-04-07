;;198
(defun skk-kill-emacs-without-saving-jisyo (&optional query)
  "個人辞書を保存せずに Emacs を終了する。"
  (interactive "P")
  ;; format を引数に持たせた場合は、skk-yes-or-no-p を使うとかえって冗長にな
  ;; る。
  ;;(when (yes-or-no-p
  ;;       (if skk-japanese-message-and-error
  ;;           "個人辞書を保存せずに Emacs を終了します。良いですか？ "
  ;;         "Do you really wish to kill Emacs without saving Jisyo? "))
    (let ((buff (skk-get-jisyo-buffer skk-jisyo 'nomsg)))
      (remove-hook 'kill-emacs-hook 'skk-save-jisyo)
      (when buff
        (set-buffer buff)
        (set-buffer-modified-p nil)
        (kill-buffer buff))
      (save-buffers-kill-emacs query))
  ;; )
  )

;;1835
(defun skk-henkan-show-candidates ()
  "変換した候補群をエコーエリアに表示する。"
  (skk-save-point
   (let* ((max-candidates skk-henkan-number-to-display-candidates)
          (candidate-keys ; 表示用のキーリスト
           (mapcar (lambda (c)
                     (when (or (memq c '(?\C-g skk-start-henkan-char))
                               (skk-key-binding-member
                                (skk-char-to-unibyte-string c)
                                '(skk-previous-candidate)))
                       (skk-error "`%s' に無効なキーが指定されています"
                                  "Illegal key in `%s'"
                                  "skk-henkan-show-candidates-keys"))
                     (skk-char-to-unibyte-string (upcase c)))
                   skk-henkan-show-candidates-keys))
          key-num-alist ; 候補選択用の連想リスト
          (key-num-alist1 ; key-num-alist を組み立てるための作業用連想リスト。
           ;; 逆さまにしておいて、表示する候補の数が少なかったら先
           ;; 頭から幾つか削る。
           (let (alist)
             (dotimes (i max-candidates alist)
               (push (cons (nth i skk-henkan-show-candidates-keys)
                           i)
                     alist))))
          (nth-henkan (- skk-show-candidates-nth-henkan-char 1))
          (loop 0)
          inhibit-quit
          (echo-keystrokes 0)
          henkan-list
          new-one
          reverse
          n)
     ;; Emacs 19.28 だと Overlay を消しておかないと、次に insert される
     ;; skk-henkan-key に何故か Overlay がかかってしまう。
     (when skk-use-face
       (skk-henkan-face-off))
     (delete-region skk-henkan-start-point
                    skk-henkan-end-point)
     (while loop
       (cond
        (reverse
         (setq loop (1- loop)
               henkan-list (nthcdr (+ nth-henkan (* loop max-candidates))
                                   skk-henkan-list)
               reverse nil))

        (skk-exit-show-candidates
         ;; 候補が尽きてしまって、skk-henkan-show-candidates ->
         ;; skk-henkan-in-minibuff -> skk-henkan
         ;; -> skk-henkan-show-candidates の順で、再びこの関数が呼ばれ
         ;; たときは、ここで henkan-list と loop を計算する。
         (setq henkan-list (nthcdr skk-henkan-count skk-henkan-list)
               loop (car skk-exit-show-candidates))
         (setq skk-exit-show-candidates nil))

        (t
         ;; skk-henkan-show-candidates-keys の最終のキーに対応する候補
         ;; が出てくるまでサーチを続ける。
         (while (and skk-current-search-prog-list
                     (null (nthcdr (+ nth-henkan max-candidates (* loop max-candidates))
                                   skk-henkan-list)))
           ;; 新規に候補が得られた時のみ skk-henkan-list-filter を呼ぶ。
           ;; skk-look や skk-server-completion-search を利用した郵便番号からの
           ;; 変換時などのように、数値を含み且つ大量の候補がある時の速度改善。
           (let ((cands (skk-search)))
             (when cands
               (setq skk-henkan-list
                     (skk-nunion skk-henkan-list
                                 cands))
               (skk-henkan-list-filter))))
         (setq henkan-list (nthcdr (+ nth-henkan (* loop max-candidates))
                                   skk-henkan-list))))
       (save-window-excursion
         (setq n (skk-henkan-show-candidate-subr candidate-keys henkan-list))
         (when (> n 0)
           (condition-case nil
               (let* ((char (read-key-sequence nil))
		      key
		      num)
		 ;;(message "char :%s" char)
		 (if (stringp char)
		     (setq char (string-to-char char))
		   (setq char nil))
	         (setq key (this-command-keys-vector))
		 ;;(message "char-> :%s" char)
		 ;;(message "key--> :%s" key)
		 
                 ;; clear out candidates in echo area
                 (message "")
                 (if (and (null char)
                          (null key))
                     nil;;(skk-unread-event event)
		   ;;else
                   (setq key-num-alist (nthcdr (- max-candidates n)
                                               key-num-alist1))
                   (when (and key-num-alist
                              char)
                     (setq num (cdr (or (assq char
                                              key-num-alist)
                                        (assq (if (skk-lower-case-p char)
                                                  (upcase char)
                                                (downcase char))
                                              key-num-alist)))))
                   (cond
                    (num
                     (setq skk-henkan-count (+ nth-henkan (* loop max-candidates) num))
                     (setq new-one (nth num henkan-list)
                           skk-kakutei-flag t
                           loop nil))

                    ((or (eq char skk-start-henkan-char) ; SPC
                         (skk-key-binding-member key
                                                 '(skk-nicola-self-insert-rshift)
                                                 skk-j-mode-map))
                     ;;
                     (if (or skk-current-search-prog-list
                             (nthcdr max-candidates henkan-list))
                         (setq loop (1+ loop))
                       ;; 候補が尽きた。この関数から抜ける。
                       (let ((last-showed-index (+ nth-henkan (* loop max-candidates))))
                         (setq skk-exit-show-candidates
                               ;; cdr 部は、辞書登録に入る前に最後に表示し
                               ;; た候補群の中で最初の候補を指すインデクス
                               (cons loop last-showed-index))
                         ;; 辞書登録に入る。skk-henkan-count は
                         ;; skk-henkan-list の最後の候補の次 (存在しない
                         ;; --- nil)を指す。
                         (setq skk-henkan-count (+ last-showed-index n))
                         (setq loop nil)))) ;;end SPC

                    ((eq char skk-force-registration-mode-char);;46 period(.)
                     (let ((last-showed-index (+ nth-henkan (* loop max-candidates))))
                       (setq skk-exit-show-candidates
                             ;; cdr 部は、辞書登録に入る前に最後に表示し
                             ;; た候補群の中で最初の候補を指すインデクス
                             (cons loop last-showed-index))
                       (setq skk-henkan-count last-showed-index)
                       (setq loop nil)))

                    ((eq char skk-show-candidates-toggle-display-place-char);;6 C-f
                     (setq skk-show-candidates-always-pop-to-buffer
                           (not skk-show-candidates-always-pop-to-buffer)))

                    ((skk-key-binding-member key
                                             '(skk-previous-candidate
                                               skk-delete-backward-char
                                               skk-undo)
                                             skk-j-mode-map)
                     (cl-case loop
                       (0
                        ;; skk-henkan-show-candidates を呼ぶ前の
                        ;; 状態に戻す。
                        (skk-escape-from-show-candidates nth-henkan))
                       (t
                        ;; 一つ前の候補群をエコーエリアに表示する。
                        (setq reverse t))))

                    ((eq char skk-annotation-toggle-display-char);;94 ^
                     (skk-annotation-toggle-display-p))

                    ((skk-key-binding-member key skk-quit-commands
                                             skk-j-mode-map)
                     ;;
                     (signal 'quit nil))

                    (t
                     (skk-message "`%s' は無効なキーです！"
                                  "`%s' is not valid here!!"
                                  (or (key-description key)
                                      (key-description char)))
                     (sit-for 1)
                     );;t
		    
                    ) ;;end cond
		   ) ;;end if
		 ) ;;end let
             (quit
              ;; skk-previous-candidate へ
              (skk-escape-from-show-candidates 0)))))) ; end of while loop
     ;;
     (or (cdr-safe new-one)
         new-one))))

;; (defun whatis (arg)
;;   (string-join (list
;; 		(when (characterp arg) "character ")
;; 		(when (stringp arg) "string ")
;; 		(when (commandp arg) "command ")
;; 		)))
;;2444
(defun skk-previous-candidate (&optional arg)
  "▼モードであれば、一つ前の候補を表示する。
▼モード以外ではカレントバッファにタイプした文字を挿入する。
確定辞書による確定の直後に呼ぶと確定をアンドゥし、見出しに対する次候補を表示する。
最後に確定したときの候補はスキップされる。"
  (interactive "*p")
  (skk-with-point-move
   (cond
    
    ((not (eq skk-henkan-mode 'active))
     ;; (message "condA-noactive")
     ;; (message "last-command:%s %s" last-command (whatis last-command))
     ;; (message "last-command-event:%s %s" last-command-event (whatis last-command-event))
     ;; (if (> (minibuffer-depth) 0)
     ;;  	 (message "in MiniBuffer.")
     ;;   (message "Out of minibuffer."))
     ;; (message "Minibuffer prompt=%s" (minibuffer-prompt))
     ;; (message "minibuffer prompt width=%s" (minibuffer-prompt-width))
     ;; (message "Current Point=%s  Max=%s" (point) (point-max))
     (let (char key)
       (if (characterp last-command-event)
	   (setq char last-command-event)
	 (setq char nil))
       (setq key (this-command-keys-vector))
       ;; (message "this-command-keys-vector:%s %s" key (whatis key))
       ;; (message "char-> :%s" char)
       ;; (message "key--> :%s" key)

       (cond

	((eq last-command 'skk-kakutei-henkan)
	 (message "(skk-undo-kakutei-subr)");;
	 (skk-undo-kakutei-subr))
	
	((eq char 120)
	 ;; (message "x event");;x
	 (skk-kana-input arg))

	((and (minibuffer-prompt) (= (point-max) (+ (minibuffer-prompt-width) 1)))
	 (exit-minibuffer))
	
	;; C-p S-SPC M-DEL up
	((equal key (kbd "<up>"))
	 ;; (message "<up> event")
	 ;; (message "(skk-emulate-original-map arg)")
	 (skk-emulate-original-map arg))
	(t
	 ;; (message "(skk-kana-input arg)")
	 (skk-kana-input arg))

	) ;;end cond
       ) ;;end let
     ) ;;end not
    
    ((string= skk-henkan-key "")
     (message "condB-blankkey");;
     nil)
    
    (t
     ;;(message "condC-t");;
     (let ((mark (unless (eobp)
                   (skk-save-point
                    (forward-char 1)
                    (point-marker))))
           pair)
       (skk-save-point
        (cl-case skk-henkan-count
          (0
           (when skk-okuri-char
             ;; roman prefix for okurigana should be removed.
             (setq skk-henkan-key (substring skk-henkan-key 0 -1)))
           (when skk-katakana
             (setq skk-henkan-key
                   (skk-hiragana-to-katakana skk-henkan-key)))
           (setq skk-henkan-count -1)
           (setq skk-henkan-in-minibuff-flag nil
                 skk-henkan-list nil
                 skk-henkan-okurigana nil
                 skk-okuri-char nil
                 skk-okuri-index-min -1
                 skk-okuri-index-max -1
                 skk-okurigana nil
                 skk-prefix "")
           (when (skk-numeric-p)
             (skk-num-initialize))
           ;; Emacs 19.28 だと Overlay を消しておかないと、次に insert され
           ;; る skk-henkan-key に何故か Overlay がかかってしまう。
           (when skk-use-face
             (skk-henkan-face-off))
           (delete-region skk-henkan-start-point skk-henkan-end-point)
           (goto-char skk-henkan-end-point)
           (insert-and-inherit skk-henkan-key)
           (skk-change-marker-to-white))
          (t
           (setq skk-henkan-count (1- skk-henkan-count))
           (setq pair (skk-insert-new-word (skk-get-current-candidate))))))
       ;;
       (if mark
           (progn
             (goto-char mark)
             (skk-set-marker mark nil)
             (backward-char 1))
         (goto-char (point-max)))
       ;;
       (when skk-show-annotation
         (skk-annotation-find-and-show pair))
       ;;
       (when (and skk-abbrev-mode
                  (= skk-henkan-count -1))
         (skk-abbrev-mode-on))
       )) ;;end t
    
    ) ;;end cond
   
   ;; verbose message
   (skk-henkan-on-message)
   ) ;;end skk-with-point-move
  ) ;;end defun

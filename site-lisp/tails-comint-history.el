;;これは、shell-mode など M-p、M-n でコマンドラインヒストリを遡ったりしたい時に便利なものです。 
;;例えば、M-x shell として 
;;      % ls -l
;;      total 12
;;      % date
;;      1997年09月29日(月) 16時17分02秒 JST
;;      % l
;;と入力したとします。この時点で M-p を入力すると、標準では 
;;      % date
;;となりますが、tails-comint-histrory.el を使っていれば 
;;      % ls -l
;;となってくれます。つまり最初の一文字が l であるようなヒストリを検索して表示してくれるわけです。 
;;つかうには、~/.emacs に (load-library "tails-comint-histrory") と書いておきます。 

(require 'shell)
(define-key comint-mode-map [?\M-p] 'tails-comint-previous-input)
(define-key comint-mode-map [?\M-n] 'tails-comint-next-input)
(define-key shell-mode-map [?\M-p] 'tails-comint-previous-input)
(define-key shell-mode-map [?\M-n] 'tails-comint-next-input)

(make-variable-buffer-local 'tails-comint-history-prefix)
(make-variable-buffer-local 'tails-comint-history-index)

(defun tails-comint-previous-input ()
  (interactive)
  (tails-comint-history 1))

(defun tails-comint-next-input ()
  (interactive)
  (tails-comint-history -1))

(defun tails-comint-history (direction)
  (let ((len (ring-length comint-input-ring))
	(ppos (process-mark (get-buffer-process (current-buffer)))))
    (if (not (eq last-command 'tails-comint-history))
	(progn
	  (setq tails-comint-history-prefix (buffer-substring ppos (point)))
	  (setq tails-comint-history-index nil)))
    (setq tails-comint-history-index (if (numberp tails-comint-history-index)
					 (+ tails-comint-history-index direction)
				       (if (= direction 1) 0 (1- len))))
    (message tails-comint-history-prefix)
    (let ((prefix-len (length tails-comint-history-prefix)))
      (while (not (or (and (not (and (>= tails-comint-history-index 0)
				     (< tails-comint-history-index len)))
			   (progn
			     (setq tails-comint-history-index nil)
			     (ding)
			     ;;(kill-region ppos (point-max))
			     (delete-region ppos (point-max))
			     (goto-char (point-max))
			     (insert tails-comint-history-prefix)
			     t))
		      (let ((element (ring-ref comint-input-ring tails-comint-history-index)))
			(and (<= prefix-len (length element))
			     (string= tails-comint-history-prefix (substring element 0 prefix-len))
			     (progn
			       ;;(kill-region ppos (point-max))
			       (delete-region ppos (point-max))
			       (goto-char (point-max))
			       (insert element)
			       t)))))
	(setq tails-comint-history-index (+ tails-comint-history-index direction)))
  (setq this-command 'tails-comint-history))))

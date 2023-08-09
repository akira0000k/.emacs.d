
;; ------ 09org.el ------

(global-set-key (kbd "C-c l") 'org-store-link)
;; (setq org-startup-with-inline-images t)

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)


;;+++++++++++++++++++++++
(setq org-todo-keywords
      '((sequence "SOMEDAY" "TODO" "DOING" "|" "DONE" "CANCELLED"))
      ;;'((sequence "TODO" "|" "DONE")) ;;;; default
      )
;;
;; or, in org file
;;#+TODO: TODO DOING | DONE CANCELLED

;; org-todo
;; http://emacs.rubikitch.com/sd1502-org-mode/
;;
;; org-captureで2種類のメモを扱うようにする
(setq org-capture-templates
      '(("t" "New TODO" entry
         (file+headline "~/org/todo.org" "やること") "* TODO %U これやろう%?\n\n")
        ("m" "Memo" entry
         (file+headline "~/org/memo.org" "メモ") "* %U なんのメモ?%?\n関連ファイル=%F")
	))
;; %T <active timestamp>    as C-c .
;; %U [inactive timestamp]  as C-c !

;; org-agendaでaを押したら予定表とTODOリストを表示
(setq org-agenda-custom-commands
      '(
	("a" "Agenda and TODO" ((agenda "")(alltodo "")))
	))
;; org-agendaで扱うファイル/ディレクトリは複数可
(setq org-agenda-files '(
			 "~/org/todo.org"
			 "~/org/todos/"
			 "~/org/idol/"
			 "~/org/"
			 ))

;; TODOリストにアクティブな日付がついているTODOを表示しない
(setq org-agenda-todo-ignore-with-date t)
;; 今日から予定を表示させる
(setq org-agenda-start-on-weekday nil)

;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook #'(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;; DONEの時刻を記録
(setq org-log-done 'time)

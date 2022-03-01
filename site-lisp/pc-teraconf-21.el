;   modified teraterm keyboard.cnf
;
;   /xterm    KOSMAX24-both.CNF 2015.06.30
;

;;;;;;;;;;;;;;;;; TERM=xterm --> screen ;;;;;;;;;;;;;;;;;;
(if (boundp 'input-decode-map)
    (setq target-map 'input-decode-map)
  (setq target-map 'global-map)
  )

(progn
  ;; xterm home end
  (define-key (eval target-map) "\eOH"  [home])
  (define-key (eval target-map) "\eOF"  [end])
  ;; vt100 home end <= find select
  (define-key (eval target-map) [find]   [home])
  (define-key (eval target-map) [select] [end])
  (define-key (eval target-map) "\e[1~" [home])   ;vt100  <find> to  <home>  (NumLock-off 7)
  (define-key (eval target-map) "\e[4~" [end])    ;screen <select> to <end>  (NumLock-off 1)

;;  (define-key (eval target-map) "\e[3~" (kbd "<deletechar>"))
  (define-key (eval target-map) "\e[3;5~" (kbd "C-<delete>"))

  
  (define-key (eval target-map) "\eO2A" [S-up])
  (define-key (eval target-map) "\eO2B" [S-down])
  (define-key (eval target-map) "\eO2C" [S-right])
  (define-key (eval target-map) "\eO2D" [S-left])

  (define-key (eval target-map) "\eO5A" [C-up])
  (define-key (eval target-map) "\eO5B" [C-down])
  (define-key (eval target-map) "\eO5C" [C-right])
  (define-key (eval target-map) "\eO5D" [C-left])

  (define-key (eval target-map) "\e[1;6C" [C-S-right])
  (define-key (eval target-map) "\e[1;6D" [C-S-left])

  (define-key (eval target-map) "\eO5H" [C-home])
  (define-key (eval target-map) "\eO5F" [C-end])
  (define-key (eval target-map) "\eO2H" [S-home])
  (define-key (eval target-map) "\eO2F" [S-end])
  (define-key (eval target-map) "\e[1;6H" [C-S-home])
  (define-key (eval target-map) "\e[1;6F" [C-S-end])

  (define-key (eval target-map) "\e[5;5~" [C-prior])
  (define-key (eval target-map) "\e[6;5~" [C-next])
  (define-key (eval target-map) "\e[5;2~" [S-prior])
  (define-key (eval target-map) "\e[6;2~" [S-next])

  (define-key (eval target-map) "\e[27;5;9~" [C-tab])
  (define-key (eval target-map) "\e[27;6;9~" [C-S-tab])

  (define-key (eval target-map) "\e[27;5;44~" (kbd "C-,"))
  (define-key (eval target-map) "\e[27;5;46~" (kbd "C-."))

  (define-key (eval target-map) "\e[27;5;13~" (kbd "<C-return>"))

  (if (> emacs-major-version 21)
      (define-key (eval target-map) "\eOP" (kbd "<f1>"))
    (define-key (eval target-map) "\eOP" 'help-for-help))
  (define-key (eval target-map) "\eOQ" (kbd "<f2>"))
  (define-key (eval target-map) "\eOR" (kbd "<f3>"))
  (define-key (eval target-map) "\eOS" (kbd "<f4>"))
  (define-key (eval target-map) "\eO2P" (kbd "<S-f1>"))
  (define-key (eval target-map) "\eO2Q" (kbd "<S-f2>"))
  (define-key (eval target-map) "\eO2R" (kbd "<S-f3>"))
  (define-key (eval target-map) "\eO2S" (kbd "<S-f4>"))
  (define-key (eval target-map) "\e[15;2~" (kbd "<S-f5>"))
  (define-key (eval target-map) "\e[17;2~" (kbd "<S-f6>"))
  (define-key (eval target-map) "\e[18;2~" (kbd "<S-f7>"))
  (define-key (eval target-map) "\e[19;2~" (kbd "<S-f8>"))
  (define-key (eval target-map) "\e[20;2~" (kbd "<S-f9>"))
  (define-key (eval target-map) "\e[21;2~" (kbd "<S-f10>"))
  (define-key (eval target-map) "\e[23;2~" (kbd "<S-f11>"))
  (define-key (eval target-map) "\e[24;2~" (kbd "<S-f12>"))
  )

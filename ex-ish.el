;;; -*- lexical-binding: t; -*-
;; iSH extra setting

;; auto revert mode setting: see-->custom.el
;;;; (custom-set-variables
;;;;  ;; custom-set-variables was added by Custom.
;;;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;;;  ;; Your init file should contain only one such instance.
;;;;  ;; If there is more than one, they won't work right.
;;;;  '(global-auto-revert-mode t)
;;;;  )

;; for poor filesystem.
(setq delete-by-moving-to-trash nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; change slow search threashold.
;; Documentation:
;; Highest terminal speed at which to use "slow" style incremental search.
;; This is the style where a one-line window is created to show the line
;; that the search has reached.
(setq search-slow-speed 200) ;; default: 1200

;; give arrows to extra feature.
(keymap-global-set "<left>"  'ak-cursor-top2)
(keymap-global-set "<right>" 'ak-cursor-bottom)
(keymap-global-set "<up>" 'ak-line-up)
(keymap-global-set "<down>" 'ak-line-down)

;; goto filetop, fileend
(keymap-global-set "M-," 'beginning-of-buffer) ;;was xref-pop-marker-stack
(keymap-global-set "M-." 'end-of-buffer)       ;;was xref-find-definitions

;; function keys Meta-number
(keymap-set input-decode-map "M-1" "<f1>")
(keymap-set input-decode-map "M-2" "<f2>")
(keymap-set input-decode-map "M-3" "<f3>")
(keymap-set input-decode-map "M-4" "<f4>")
(keymap-set input-decode-map "M-5" "<f5>")
(keymap-set input-decode-map "M-6" "<f6>")
(keymap-set input-decode-map "M-7" "<f7>")
(keymap-set input-decode-map "M-8" "<f8>")
(keymap-set input-decode-map "M-9" "<f9>")
(keymap-set input-decode-map "M-0" "<f10>")
(keymap-set input-decode-map "M--" "<f11>")
(keymap-set input-decode-map "M-'" "<f12>") ;; (M-^)
;; ⁄€‹›ﬁﬂ‡°·‚—
(keymap-set input-decode-map "⁄" "S-<f1>")
(keymap-set input-decode-map "€" "S-<f2>")
(keymap-set input-decode-map "‹" "S-<f3>")
(keymap-set input-decode-map "›" "S-<f4>")
(keymap-set input-decode-map "ﬁ" "S-<f5>")
(keymap-set input-decode-map "ﬂ" "S-<f6>")
(keymap-set input-decode-map "‡" "S-<f7>")
(keymap-set input-decode-map "°" "S-<f8>")
(keymap-set input-decode-map "·" "S-<f9>")
(keymap-set input-decode-map "‚" "S-<f10>")
(keymap-set input-decode-map "—" "S-<f11>")
(keymap-set input-decode-map "±" "S-<f12>") ;;was delete-indentation
;; change Yensign to backslash
(keymap-set input-decode-map "¥" "\\")
;; use backslash(opt+¥) instead of M-^
(keymap-set input-decode-map "\\" "M-^") ;; delete-indentation

;; copy and paste
;; because of cua C-x, C-c trouble-> use C-w, C-r, C-y instead.
(keymap-global-set "C-r" 'kill-ring-save)
;; test  C-k, C-l, C-y
(keymap-global-set "C-l" 'ak-copy-line)

;; cua-mode
(when (boundp 'cua-global-keymap)
  (keymap-set cua-global-keymap "C-r" 'cua-copy-region)
  )
(when (boundp 'cua--cua-keys-keymap)
  (keymap-set input-decode-map "◊" "M-V") ;;iSH
  )
(setq cua-enable-cua-keys nil)

;; dired
(with-eval-after-load 'dired
  (keymap-set dired-mode-map "M-." nil)  ;; see global
  (keymap-set dired-mode-map "C-b" nil)  ;; just backward-char
  (keymap-set dired-mode-map "b" 'dired-up-directory)
)

;; shell mode
(with-eval-after-load 'shell
  (keymap-set shell-mode-map "M-p"       nil) ;; see global
  (keymap-set shell-mode-map "M-n"       nil) ;; sse global
  )

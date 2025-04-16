;;; skk-setup.el --- initial setup for SKK  -*- emacs-lisp -*-

;; Copyright (C) 2000 NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>

;; Author: NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>
;; Maintainer: SKK Development Team
;; URL: https://github.com/skk-dev/ddskk
;; Keywords: japanese, mule, input method

;; This file is part of Daredevil SKK.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

;;; Autoloads.


;;; Key bindings.
;;(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
;;(global-set-key "\C-xt" 'skk-tutorial)

;;; Dictionaries.
(defvar skk-large-jisyo "@DIC@")
(defvar skk-aux-large-jisyo "@AUXDIC@")
(defvar skk-tut-file "@TUT@")

;;; Isearch setting.
(defun skk-isearch-setup-maybe ()
  (require 'skk-vars)
  (when (or (eq skk-isearch-mode-enable 'always)
            (and (boundp 'skk-mode)
                 skk-mode
                 skk-isearch-mode-enable))
    (skk-isearch-mode-setup)))

(defun skk-isearch-cleanup-maybe ()
  (require 'skk-vars)
  (when (and (featurep 'skk-isearch)
             skk-isearch-mode-enable)
    (skk-isearch-mode-cleanup)))

(add-hook 'isearch-mode-hook #'skk-isearch-setup-maybe)
(add-hook 'isearch-mode-end-hook #'skk-isearch-cleanup-maybe)

(provide 'skk-setup)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; skk-setup.el ends here

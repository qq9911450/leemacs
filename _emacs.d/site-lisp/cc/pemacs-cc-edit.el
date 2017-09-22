;;; edit.el --- Auxillary tools for editing in CC-mode

;; Copyright (C) 2013  Adam Jiang

;; Author: Adam Jiang <jiang.adam@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'google-c-style)
;; set google-c-style as default when cc-mode is open
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; set width of the line to 79 charactors
(add-hook 'c-mode-common-hook
	  '(lambda () (setq-default fill-column 79)))

;; define caplab-c-style
(defconst caplab-c-style
  '("Google"
    (c-basic-offset . 4)
    (c-offsets-alist . (((innamespace . 0))))))
(defun caplab-set-style ()
  (c-add-style "caplab" caplab-c-style))
(add-hook 'c++-mode-hook 'caplab-set-style)

;; treat .cc .cpp file as c++ source code
;;(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
;;(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(require 'protobuf-mode)
;; define le-protobuf-style
(defconst le-protobuf-style
  '((c-basic-offset . 2)
       (indent-tabs-mode . nil)))
(add-hook 'protobuf-mode-hook
	  (lambda () (c-add-style "le-style" le-protobuf-style t)))

;; treat .proto file as c-mode
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))

(require 'cuda-mode)

;;; +++ set linux kernel code style +++
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook (lambda ()
                                (c-add-style "linux-tabs-only"
                                             '("linux" (c-offsets-alist
                                                        (arglist-cont-nonempty
                                                         c-lineup-gcc-asm-reg
                                                         c-lineup-arglist-tabs-only))))))
(add-hook 'c-mode-hook (lambda ()
                         (let ((filename (buffer-file-name)))
                           ;; Enable kernel mode for the appropriate files
                           (when (and filename
				      (or
                                      (string-match (expand-file-name "/media/le/0e5449a6-84ca-4aea-b133-288481e5d912/sw/tx1-android/kernel/")
                                                    filename)
				      (string-match (expand-file-name "/media/le/0e5449a6-84ca-4aea-b133-288481e5d912/project/sw/tx1-android/kernel/")
                                                    filename)
				      (string-match (expand-file-name "/media/le/0e5449a6-84ca-4aea-b133-288481e5d912/sw/ninjia-android/kernel/")
                                                    filename)
				      (string-match (expand-file-name "/media/le/0e5449a6-84ca-4aea-b133-288481e5d912/sw/project/ninjia-android/kernel/")
                                                    filename))
				      )
                             (setq indent-tabs-mode t)
                             (setq show-trailing-whitespace t)
                             (c-set-style "linux-tabs-only")))))
;;; --- set linux kernel code style ---


(provide 'pemacs-cc-edit)
;;; edit.el ends here

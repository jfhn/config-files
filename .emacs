(setq custom-file "~/.emacs.custom.el")

;; (setq-default debug-on-error t)

(scroll-bar-mode 0) ; Disable visible scrollbar
(tool-bar-mode   0) ; Disable toolbar
(tooltip-mode    0) ; Disable tooltips
(menu-bar-mode   0) ; Disable menubar
(setq-default inhibit-splash-screen)
;; Disable ring bell
(setq-default ring-bell-function 'ignore)

(global-visual-line-mode t)

(setq-default whitespace-display-mappings
	      '((tab-mark 9 [187 9] [92 9])))

(setq backup-directory-alist '(("." . "~/EmacsBackups")))

(global-whitespace-mode 1)
(setq-default show-trailing-whitespace)

(set-face-attribute 'fixed-pitch nil :font "Iosevka Fixed" :height 160)
(set-face-attribute 'default nil :font "Iosevka Fixed" :height 160)

;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives
	     '(("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Download the package repositories if there is none on the machine
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

;; Ensure that all packages are downloaded and installed before they are runned
(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package evil)
(evil-mode 1)

;; (use-package magit)

;; TODO: Bind C-a to increase number in normal mode
;; TODO: Bind C-x to decrease number in normal mode
;; TODO: Bind C-u to half page up in normal mode

(use-package undo-fu)
(evil-set-undo-system 'undo-fu)

(use-package smex)

(ido-mode)
(ido-everywhere)
(keymap-global-set "M-x" 'smex)

(use-package zenburn-theme)

(load-theme 'zenburn)

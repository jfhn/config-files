;;; package --- Summary
;;; Commentary:

;; Open the command log buffer with: clm/open-...

;;; Code:

;;
;; Packages
;;

;; Initialize package resources
(require 'package)

;; Setup package repositories to pull packages from
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

;; Initialize the package system and prepare it to be used
(package-initialize)

;; Download the package repositories if there is none on the machine
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Ensure that all packages are downloaded and installed before they are runned
(setq use-package-always-ensure t)

;; Themes
(use-package jetbrains-darcula-theme)
(use-package subatomic-theme)
(use-package gruber-darker-theme)

;; Better UX
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.5))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package all-the-icons)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key]      . helpful-key))

;; Misc
(use-package command-log-mode)
(use-package counsel
  :bind (("M-x"     . counsel-M-x)
         ("C-x b"   . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r"     . counsel-minibuffer-history)))

(use-package rainbow-delimiters
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package latex-preview-pane)

(use-package fixmee)
;(setq-default fixmee-mode 1)

;; Modeline configurations
(setq-default doom-modeline-height 10)
;(setq doom-modeline-icon nil)
(setq-default doom-modeline-indent-info t)

(setq-default doom-modeline-height 1)
(set-face-attribute 'mode-line nil :family "Consolas" :height 1)
(set-face-attribute 'mode-line-inactive nil :family "Consolas" :height 1)


;;
;; Languages
;;

;; C
;(setq c-tab-always-indent nil)
(setq-default c-basic-offset 8)

;; Lua
(use-package lua-mode)
(setq-default lua-indent-level 8)
(setq-default lua-indent-nested-block-content-align nil)

;; LaTeX
(use-package pdf-tools)
(pdf-tools-install)

;;
;; UI Configuration
;;

;; Disable startup message
(setq inhibit-startup-message t)

;; Disable useless bars
(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode   -1) ; Disable toolbar
(tooltip-mode    -1) ; Disable tooltips
(menu-bar-mode   -1) ; Disable menubar
(set-fringe-mode 10)

;; Set font
(set-face-attribute 'default nil :font "Consolas" :height 140)
;(set-face-attribute 'default nil :font "JetBrains Mono" :height 120)

;; Set theme
;(load-theme 'misterioso)
;(load-theme 'tango-dark)
;(load-theme 'jetbrains-darcula t)
;(load-theme 'subatomic t)
(load-theme 'gruber-darker t)

; Not needed for gruber-darker
;(set-face-foreground 'mode-line "white")
;(set-face-background 'mode-line "black")

;; Set line wrap
(global-visual-line-mode t)

(setq-default column-number-mode t)

;; Disable ring bell
(setq-default ring-bell-function 'ignore)

(global-whitespace-mode)
(setq-default whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#737373")))))

(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9])))

;;
;; Variables
;;

(setq-default text-scale-mode-amount 0)
(setq custom-tab-width 4)

;(setq-default c-basic-offset custom-tab-width)


;;
;; Custom functions
;;

;; TODO: Tweak values
(defun get-scroll-height ()
  (if (= 0 text-scale-mode-amount)
      2
    (* 2 text-scale-mode-amount)))

(defun calc-scroll-height ()
  (max 1 (/ (1- (window-height (selected-window))) (get-scroll-height))))

(defun scroll-fast-up ()
  (interactive)
  (scroll-down (calc-scroll-height))
  (move-to-window-line nil))

(defun scroll-fast-down ()
  (interactive)
  (scroll-up (calc-scroll-height))
  (move-to-window-line nil))

(defun save-and-trim ()
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(defun open-cmd-buffer ()
  (interactive)
  (clm/open-command-log-buffer))

(defun disable-tabs ()
  (setq indent-tabs-mode nil))

(defun enable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))



;;
;; Keybindings
;;

(global-unset-key (kbd "C-x C-s"))
(global-unset-key (kbd "C-x b"))
(global-unset-key (kbd "C-x C-c"))

;; Editing
(global-set-key (kbd "C-z")       'undo)
(global-set-key (kbd "C-v")       'yank)
(global-set-key (kbd "C-y")       'kill-ring-save)
(global-set-key (kbd "<backtab>") 'indent-according-to-mode)

;; Scrolling
(global-set-key (kbd "M-<up>")   'scroll-fast-up)
(global-set-key (kbd "M-<down>") 'scroll-fast-down)

;; Windows (not the OS)
(global-set-key (kbd "C-c C-v")    'split-window-right)

;; Misc
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-s")      'save-and-trim)
(global-set-key (kbd "C-f")      'swiper)
(global-set-key (kbd "C-b")      'counsel-switch-buffer)
(global-set-key (kbd "C-c C-c")  'compile)


;;
;; Hooks
;;

(add-hook 'prog-mode-hook       'enable-tabs)

(add-hook 'lisp-mode-hook       'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;;; newinit.el ends here

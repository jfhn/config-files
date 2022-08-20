;;; package --- Summary
;;; Commentary:

;; Open the command log buffer with: clm/open-...

;;; Code:

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment 'utf-8)

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
(setq use-package-always-ensure t
      use-package-always-defer t)

;; Themes
(use-package jetbrains-darcula-theme)
(use-package subatomic-theme)
(use-package gruber-darker-theme)
(use-package obsidian-theme)
(use-package monokai-theme)
(use-package naysayer-theme)
(use-package mindre-theme)
(use-package solarized-theme)
(use-package zenburn-theme)
(use-package gruvbox-theme)

;; Better UX
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.5))

(use-package ivy
  :diminish
  :bind (("C-f" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1))

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
         ("C-b"     . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r"     . counsel-minibuffer-history)))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

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

(use-package org)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("0" "1" "2" "3" "4" "5" "6")))

(use-package multiple-cursors
  ;; :straight t
  :ensure   t
  :bind (("C-M-s" . set-rectangular-region-anchor)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)
         ("C-c C-SPC" . mc/edit-lines)
         ))

(use-package autothemer)

;; Auto Completion
(use-package company)

;; Modeline configurations
(setq-default doom-modeline-height 10)
;(setq doom-modeline-icon nil)
(setq-default doom-modeline-indent-info t)

(setq-default doom-modeline-height 20)

(use-package dash)

;; Setup backup directory
(setq backup-directory-alist '(("." . "~/EmacsBackups")))


;;
;; Programming Languages
;;

;; Lua
(use-package lua-mode)
  ;:hook (lua-mode . lsp-deferred))
(setq-default lua-indent-level 8)
(setq-default lua-indent-nested-block-content-align nil)

;; Haskell
(use-package haskell-mode)
(setq-default haskell-indentation-left-offset 4)

;; Go
(use-package go-mode)

;; Kotlin
(use-package kotlin-mode)
(setq-default kotlin-tab-width 4)

;; F#
(use-package fsharp-mode)

;; Markdown
(use-package markdown-mode)

;; LaTeX
(use-package auctex)
(use-package company-auctex)

;; (use-package latex
;;   :config
;;   (setq-default TeX-master nil) ; Asks for master document
;;   ;; Enable PDF preview
;;   (setq TeX-view-program-selection '((output-pdf "pdf-tools")))
;;   (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
;;   ;; Enable reftex
;;   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;   (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource")))

(use-package latex-preview-pane
  :requires latex
  :config
  (add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode))

(use-package golden-ratio
  :requires (latex latex-preview-pane)
  :config
  ;; Enable golden ratio for LaTeX preview
  (add-hook 'LaTeX-mode-hook (lambda () (golden-ratio-mode 1))))

;; Yaml
(use-package yaml-mode)

;; Scala
(use-package scala-mode
  :mode "\\.scala")

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-metals
  :ensure t
  :custom
  ;; Metals claims to support range formatting by default but it supports range
  ;; formatting of multiline strings only. You might want to disable it so that
  ;; emacs can use indentation provided by scala-mode.
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  ;;:hook (scala-mode . lsp-deferred))
  )

;; TypeScript
(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 4))

;; Rust
; (use-package rust-mode)
(require 'rust-mode)

;; Julia
(use-package julia-mode)

;; IDE Support

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Use company-capf as a completion provider.
;;
;; To Company-lsp users:
;;   Company-lsp is no longer maintained and has been removed from MELPA.
;;   Please migrate to company-capf.
(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

;; Use the Debug Adapter Protocol for running tests and debugging
;; Posframe is a pop-up tool that must be manually installed for dap-mode
(use-package posframe)

(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))

;; PDF Support
(use-package pdf-tools)


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

;; Set theme
;(load-theme 'misterioso)
;(load-theme 'tango-dark)
;(load-theme 'jetbrains-darcula t)
;(load-theme 'subatomic t)
;(load-theme 'obsidian t)
(load-theme 'gruber-darker t)
;(load-theme 'monokai t)
;(load-theme 'zenburn t)

; Not needed for gruber-darker
;(set-face-foreground 'mode-line "white")
;(set-face-background 'mode-line "black")

;; Set line wrap
(global-visual-line-mode t)

(setq-default column-number-mode t)

;; Disable ring bell
(setq-default ring-bell-function 'ignore)

(setq-default whitespace-style '(face spaces tabs space-mark tab-mark trailing))
(setq-default whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183]   [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (tab-mark   9  [124 9] [92 9])
          ))
(setq-default global-whitespace-mode t)

(load-file "~/dev/stuff/ligature.el/ligature.el")
(use-package ligature
  :load-path "~/dev/stuff/ligature.el"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))


;;
;; Variables
;;

(setq-default text-scale-mode-amount 0)
(setq-default custom-tab-width 4)

(setq-default c-default-style "linux"
              c-basic-offset custom-tab-width)

(if (eq system-type 'windows-nt)
    (setq-default build-script-name "build.bat")
  (setq-default build-script-name "build.sh"))


;;
;; Custom functions
;;

;; Scroll
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

;; Indentation
(defun disable-tabs ()
  (interactive)
  (setq indent-tabs-mode nil))

(defun enable-tabs ()
  (interactive)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(defun change-tab-width (width)
  (interactive "nTab Width: ")
  (if (and (>= width 0) (<= width 8))
      (set-tab-width width)
    (message "Tab width has to be between 0 and 8 but is %d" width)))

(defun set-tab-width (width)
  (setq-default custom-tab-width width)
  (setq-default c-basic-offset width)
  (setq-default lua-indent-level width)
  (setq-default tab-width width)
  (reload-buffer))

;; Compilation
(defun compile-with-build-script ()
  (interactive)
  (if (file-exists-p build-script-name)
      (compile build-script-name)
    (cd "..")))

;; Misc
(defun save-and-trim ()
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(defun open-cmd-buffer ()
  (interactive)
  (clm/open-command-log-buffer))

(defun reload-buffer ()
  (interactive)
  (save-and-trim)
  (revert-buffer :ignore-auto :noconfirm))

(defun user:align-regexp (beg end regexp &optional group spacing repeat)
  (interactive
   (append
    (list (region-beginning) (region-end))
    (if current-prefix-arg
        (list (read-string "Complex align using regexp: "
                           "\\(\\s-*\\)" 'align-regexp-history)
              (string-to-number
               (read-string
                "Parenthesis group to modify (justify if negative): " "1"))
              (string-to-number
               (read-string "Amount of spacing (or column if negative): "
                            (number-to-string align-default-spacing)))
              (y-or-n-p "Repeat throughout line? "))
      (list (concat "\\(\\s-*\\)"
                    (read-string "Align regexp: "))
            1 align-default-spacing nil))))
  (let ((were-tabs-enabled indent-tabs-mode))
    (if (eq were-tabs-enabled t)
        (disable-tabs)
      ())
    (align-regexp beg end regexp group spacing repeat)
    (if (eq were-tabs-enabled t)
        (enable-tabs)
      ())))


(defvar available-fonts '(("Consolas"        . (150 medium))
                          ("Cascadia Code"   . (140 medium))
                          ("Source Code Pro" . (140 bold))
                          ("Iosevka SS06"    . (150 medium))
                          ("Courier New"     . (150 bold))
                          ("Lucida Console"  . (140 normal))))

(defun switch-font (font)
  (interactive
   (list (completing-read "Select a font: " (mapcar 'car available-fonts))))
  (set-font (assoc font available-fonts)))

(defun set-font (font-data)
  (set-face-attribute 'fixed-pitch nil :font (nth 0 font-data) :height (nth 1 font-data) :weight (nth 2 font-data))
  (set-face-attribute 'default nil :font (nth 0 font-data) :height (nth 1 font-data) :weight (nth 2 font-data))
  (set-face-attribute 'mode-line nil :family (car font-data) :height 120)
  (set-face-attribute 'mode-line-inactive nil :family (car font-data) :height 120))

(defun change-background-opacity (alpha)
  (interactive "nOpacity: ")
  (if (and (>= alpha 0) (<= alpha 100))
      (set-background-opacity alpha)
    (message "Opacity has to be between 0 and 100 but is %d." alpha)))

(defun set-background-opacity (alpha)
  (set-frame-parameter (selected-frame) 'alpha alpha)
  (add-to-list 'default-frame-alist 'alpha alpha))

(defun change-theme (theme)
  "Switch to another theme."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar #'symbol-name
                                     (custom-available-themes))))))
  (load-theme theme t)
  (disable-theme (car (last custom-enabled-themes))) ; Disable old theme
  (let ((bg-color (face-attribute 'default :background)))
    (message bg-color)
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(font-lock-type-face ((t (:italic t))))
     '(font-lock-comment-face ((t (:italic t))))
     '(font-lock-keyword-face ((t (:bold t))))))
  (if (eq global-whitespace-mode t)
      (show-whitespaces)
    ()))

(defun show-whitespaces ()
  (interactive)
  (let ((bg-color (face-attribute 'default :background)))
    (message bg-color)
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     `(whitespace-space ((t (:foreground "#737373" :background ,bg-color))))
     `(whitespace-tab ((t (:foreground "#737373" :background ,bg-color))))))
  (global-whitespace-mode 1))

(defun hide-whitespaces ()
  (interactive)
  (global-whitespace-mode 0))

;; This is a preparation for evil integration
(defun set-emacs-keybindings ()
  (interactive)
  (global-unset-key (kbd "C-x C-s"))
  (global-unset-key (kbd "C-x b"))
  (global-unset-key (kbd "C-x C-c"))
  (global-unset-key (kbd "C-b"))

  ;; Editing
  (global-set-key (kbd "C-z")       'undo)
  (global-set-key (kbd "C-v")       'yank)
  (global-set-key (kbd "C-y")       'kill-ring-save)

  ;; Scrolling
  (global-set-key (kbd "M-<up>")   'scroll-fast-up)
  (global-set-key (kbd "M-<down>") 'scroll-fast-down)

  ;; Windows (not the OS)
  (global-set-key (kbd "C-c C-v")    'split-window-right)

  ;; Misc
  (global-set-key (kbd "<escape>")  'keyboard-escape-quit)
  (global-set-key (kbd "C-s")       'save-and-trim)
  (global-set-key (kbd "C-f")       'swiper)
  (global-set-key (kbd "C-M-f")     'isearch-forward-regexp)
  (global-set-key (kbd "C-b")       'counsel-ibuffer)
  (global-set-key (kbd "M-m")       'compile-with-build-script)
  (global-set-key (kbd "<backtab>") 'tab-to-tab-stop))

(set-font (assoc "Cascadia Code" available-fonts))
(set-background-opacity 90)
(set-emacs-keybindings)
(show-whitespaces)
(global-flycheck-mode nil)
(global-company-mode t)

;;
;; Hooks
;;

(add-hook 'prog-mode-hook       'enable-tabs)

(add-hook 'lisp-mode-hook       'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)
(add-hook 'haskell-mode         'disable-tabs)
(add-hook 'fsharp-mode          'disable-tabs)
(add-hook 'java-mode            'disable-tabs)
(add-hook 'scala-mode           'disable-tabs)

;;; newinit.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f028e1985041fd072fa9063221ee9c9368a570d26bd6660edbd00052d112e8bb" default))
 '(package-selected-packages
   '(gruvbox-theme markdown-mode fsharp-mode kotlin-mode go-mode haskell-mode lua-mode autothemer multiple-cursors doom-modeline magit counsel-projectile projectile ivy-rich counsel helpful all-the-icons ivy which-key use-package ucs-utils subatomic-theme string-utils smartrep s rainbow-delimiters pkg-info obsidian-theme latex-preview-pane jetbrains-darcula-theme gruber-darker-theme command-log-mode)))

(find-file "~/dev/todo.org")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-space ((t (:foreground "#737373" :background "#181818"))))
 '(whitespace-tab ((t (:foreground "#737373" :background "#181818")))))

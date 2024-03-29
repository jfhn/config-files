;;; package --- Summary
;;; Commentary:

;; Open the command log buffer with: clm/open-...

;;; Code:

(setq-default debug-on-error t)

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
(use-package sublime-themes)

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
;(setq-default doom-modeline-height 10)
;(setq doom-modeline-icon nil)
;(setq-default doom-modeline-indent-info t)

;(setq-default doom-modeline-height 20)

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

;; Agda
;; (use-package agda-mode)
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

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
  ;;:hook (scala-mode . user/disable-tabs))
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

(use-package flycheck)

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
  :init (global-company-mode)
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

; (global-whitespace-mode 1)

; (load-file "~/dev/stuff/ligature.el/ligature.el")
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
(defun user/calc-scroll-height ()
  (format-message "window height = %d" (- (window-height (selected-window)) 2))
  (format-message "text scale    = %.2f" (expt 1.2 text-scale-mode-amount))
  (let ((actual-height (/ (- (window-height (selected-window)) 2)
                          (expt 1.2 text-scale-mode-amount))))
    (truncate (/ actual-height 2))))

(defun user/scroll-half-page-up ()
  "Scrolls a half page up."
  (interactive)
  (scroll-down (user/calc-scroll-height))
  (move-to-window-line nil))

(defun user/scroll-half-page-down ()
  (interactive)
  (scroll-up (user/calc-scroll-height))
  (move-to-window-line nil))

;; Indentation
(defun user/disable-tabs ()
  (interactive)
  (setq indent-tabs-mode nil))

(defun user/enable-tabs ()
  (interactive)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(defun user/change-tab-width (width)
  (interactive "nTab Width: ")
  (if (and (>= width 0) (<= width 8))
      (user/set-tab-width width)
    (message "Tab width has to be between 0 and 8 but is %d" width)))

(defun user/set-tab-width (width)
  (setq-default custom-tab-width width)
  (setq-default c-basic-offset width)
  (setq-default lua-indent-level width)
  (setq-default tab-width width)
  (user/reload-buffer))

;; Compilation
(defun user/compile-with-build-script ()
  (interactive)
  (if (file-exists-p build-script-name)
      (compile build-script-name)
    (cd "..")))

;; Misc
(defun user/trim-and-save ()
  "Trims trailing whitespaces and saves the current buffer."
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(defun user/open-cmd-buffer ()
  "Opens the command log buffer."
  (interactive)
  (clm/open-command-log-buffer))

(defun user/reload-buffer ()
  (interactive)
  (user/trim-and-save)
  (revert-buffer :ignore-auto :noconfirm))

(defun user/align-regexp (beg end regexp &optional group spacing repeat)
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
        (user/disable-tabs)
      ())
    (align-regexp beg end regexp group spacing repeat)
    (if (eq were-tabs-enabled t)
        (user/enable-tabs)
      ())))


(defvar user/available-fonts '(("Consolas"                . (140 medium))
                               ("Consolas ligaturized v2" . (140 medium))
                               ("Cascadia Code"           . (140 medium))
                               ("Source Code Pro"         . (140 bold))
                               ("Iosevka Term SS02"       . (150 medium))
                               ("Courier New"             . (150 bold))
                               ("Lucida Console"          . (140 normal))
                               ("Fira Code"               . (120 medium))
                               ("Ubuntu Mono"             . (160 medium))
                               ("Ubuntu Mono Ligaturized" . (150 medium))))

(defun user/change-font (font)
  (interactive
   (list (completing-read "Select a font: " (mapcar 'car user/available-fonts))))
  (user/set-font (assoc font user/available-fonts)))

(defun user/set-font (font-data)
  (set-face-attribute 'fixed-pitch nil :font (nth 0 font-data) :height (nth 1 font-data) :weight (nth 2 font-data))
  (set-face-attribute 'default nil :font (nth 0 font-data) :height (nth 1 font-data) :weight (nth 2 font-data))
  (set-face-attribute 'mode-line nil :family (car font-data) :height 1)
  (set-face-attribute 'mode-line-inactive nil :family (car font-data) :height 1))

(defun user/change-background-opacity (alpha)
  (interactive "nOpacity: ")
  (if (and (>= alpha 0) (<= alpha 100))
      (user/set-background-opacity alpha)
    (format-message "Opacity has to be between 0 and 100 but is %d." alpha)))

(defun user/set-background-opacity (alpha)
  (set-frame-parameter (selected-frame) 'alpha alpha)
  (add-to-list 'default-frame-alist (cons 'alpha alpha)))

(defun user/change-theme (theme)
  "Switch to another theme."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar #'symbol-name
                                     (custom-available-themes))))))
  (user/set-theme theme))

(defun user/disable-all-themes ()
  (while (not (null custom-enabled-themes))
    (disable-theme (car custom-enabled-themes))))

(defun user/set-theme (theme)
  (user/disable-all-themes)
  (load-theme theme t)
  (format-message "Load theme %s" theme)
  (custom-set-faces
   '(font-lock-type-face ((t (:italic t))))
   '(font-lock-comment-face ((t (:italic t))))
   '(font-lock-keyword-face ((t (:bold t :italic t)))))
  (if (eq global-whitespace-mode t)
      (user/show-whitespaces)
    ()))

(defun user/jblow-theme ()
  (interactive)
  (user/disable-all-themes)
  ;; New theme
  (custom-set-faces
   '(default ((t (:foreground "#d3b58d" :background "#041818"))))
   '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
   '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
   '(font-lock-builtin-face ((t nil)))
   '(font-lock-comment-face ((t (:foreground "#3fdf1f"))))
   '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
   '(font-lock-keyword-face ((t (:foreground "white"))))
   '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
   '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))
   '(font-lock-warning-face ((t (:foreground "#504038"))))
   '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
   '(mode-line ((t (:inverse-video t))))
   '(region ((t (:background "blue"))))
   '(widget-field-face ((t (:foreground "white"))) t)
   '(widget-single-line-field ((t (:background "darkgray"))) t)))

(defun user/show-whitespaces ()
  (interactive)
  (let ((bg-color (face-attribute 'default :background)))
    (custom-set-faces
     `(whitespace-space ((t (:foreground "#737373" :background ,bg-color))))
     `(whitespace-tab ((t (:foreground "#737373" :background ,bg-color))))))
  (global-whitespace-mode 1))

(defun user/hide-whitespaces ()
  (interactive)
  (global-whitespace-mode 0))

;; This is a preparation for evil integration
(defun user/set-emacs-keybindings ()
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
  (global-set-key (kbd "M-<up>")   'user/scroll-half-page-up)
  (global-set-key (kbd "M-<down>") 'user/scroll-half-page-down)

  ;; Windows (not the OS)
  (global-set-key (kbd "C-c C-v")    'split-window-right)

  ;; Misc
  (global-set-key (kbd "<escape>")  'keyboard-escape-quit)
  (global-set-key (kbd "C-s")       'user/trim-and-save)
  (global-set-key (kbd "C-f")       'swiper)
  (global-set-key (kbd "C-M-f")     'isearch-forward-regexp)
  (global-set-key (kbd "C-b")       'counsel-ibuffer)
  (global-set-key (kbd "M-m")       'user/compile-with-build-script)
  (global-set-key (kbd "<backtab>") 'tab-to-tab-stop)
  (global-set-key (kbd "M-<f4>")    'save-buffers-kill-emacs))


;;
;; Hooks
;;

(defun user/on-lua-mode ()
  (setq-default lua-indent-level custom-tab-width))

(defun user/on-haskell-mode ()
  (user/disable-tabs)
  (interactive-haskell-mode)
  (haskell-indent-mode)
  (haskell-doc-mode))

(add-hook 'prog-mode-hook       'user/enable-tabs)

(add-hook 'lisp-mode-hook       'user/disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'user/disable-tabs)
(add-hook 'haskell-mode-hook    'user/on-haskell-mode)
(add-hook 'fsharp-mode-hook     'user/disable-tabs)
(add-hook 'java-mode-hook       'user/disable-tabs)
(add-hook 'scala-mode-hook      'user/disable-tabs)
(add-hook 'lua-mode-hook        'user/on-lua-mode)

;;
;; Actual configuration
;;

(user/set-font (assoc "Iosevka Term SS02" user/available-fonts))
(user/set-theme 'gruber-darker)
(user/set-emacs-keybindings)
(setq-default global-flycheck-mode nil)
(setq-default global-company-mode t)
(toggle-frame-fullscreen)
(user/set-background-opacity 90)
(user/show-whitespaces)

(find-file "~/dev/todo.org")
;(calendar)
;(other-window 1)

;;; newinit.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("03e26cd42c3225e6376d7808c946f7bed6382d795618a82c8f3838cd2097a9cc" "f028e1985041fd072fa9063221ee9c9368a570d26bd6660edbd00052d112e8bb" default))
 '(package-selected-packages
   '(sublime-themes emacs-color-themes gruvbox-theme markdown-mode fsharp-mode kotlin-mode go-mode haskell-mode lua-mode autothemer multiple-cursors doom-modeline magit counsel-projectile projectile ivy-rich counsel helpful all-the-icons ivy which-key use-package ucs-utils subatomic-theme string-utils smartrep s rainbow-delimiters pkg-info obsidian-theme latex-preview-pane jetbrains-darcula-theme gruber-darker-theme command-log-mode)))
(put 'upcase-region 'disabled nil)

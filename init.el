;; Do not show the start up screen
(setq inhibit-startup-message t)

;; Only show the editor and nothing else
; (scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(global-visual-line-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)

(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

; (setq-default custom-tab-width 4)
; (setq-default tab-width 4)
(setq default-tab-width 4)

(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Disable backup files
(setq-default make-backup-files nil)

;; Set default font
(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 120       ; 12px
                    :weight 'normal
                    :width 'normal)

; Bright-red TODO
; (setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
; (make-face 'font-lock-fixme-face)
; (make-face 'font-lock-review-face )
; (make-face 'font-lock-important-face)
; (make-face 'font-lock-note-face)
; (make-face 'font-lock-param-face)
; (make-face 'font-lock-return-face)
; (mapc (lambda (mode)
;	 (font-lock-add-keywords
;	  mode
;	  '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
;	    ("\\<\\(REVIEW\\)" 1 'font-lock-review-face t)
;	    ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
;	    ("\\<\\(NOTE\\)" 1 'font-lock-note-face t)
;	    ("\\<\\(@param\\)" 1 'font-lock-param-face t)
;	    ("\\<\\(@return\\)" 1 'font-lock-return-face t))))
;	fixme-modes)
; (modify-face 'font-lock-fixme-face "Red" nil nil t t nil nil nil)
; (modify-face 'font-lock-review-face "Orange" nil nil t t nil nil nil)
; (modify-face 'font-lock-important-face "Yellow" nil nil t t nil nil nil)
; (modify-face 'font-lock-note-face "Green" nil nil t t nil nil nil)
; (modify-face 'font-lock-param-face "Light Green" nil nil t nil t nil nil)
; (modify-face 'font-lock-return-face "Light Green" nil nil t nil t nil nil)

; Smooth scroll
(setq scroll-step 3)

; Clock
(display-time)

; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
         ("\\.hin$"    . c++-mode)
         ("\\.cin$"    . c++-mode)
         ("\\.inl$"    . c++-mode)
         ("\\.rdc$"    . c++-mode)
         ("\\.h$"      . c++-mode)
         ("\\.c$"      . c++-mode)
         ("\\.cc$"     . c++-mode)
         ("\\.c8$"     . c++-mode)
	 ("\\.cs$"     . c++-mode)
         ("\\.txt$"    . indented-text-mode)
         ("\\.emacs$"  . emacs-lisp-mode)
         ("\\.gen$"    . gen-mode)
         ("\\.ms$"     . fundamental-mode)
         ("\\.m$"      . objc-mode)
         ("\\.mm$"     . objc-mode)
	 ("\\.hs$"     . haskell-mode)
	 ("\\.scala$"  . scala-mode)
	 ("\\.kt$"     . kotlin-mode)
         ) auto-mode-alist))

(setq-default c-basic-offset 4)

;; -------------------------------------------------
;; KEY BINDINGS
;; -------------------------------------------------

;; Set the ESC key to the same as C-g
; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Split window horizontally
(global-set-key (kbd "C-x C-v") 'split-window-horizontally)

;; Switch save-buffer and
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-x C-s") 'isearch-forward)

;; C-x o to switch to the other window

;; TODO: C-b as build command


;; -------------------------------------------------
;; PACKAGES
;; -------------------------------------------------

;; Initialize package manager
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package) (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5f824cddac6d892099a91c3f612fcf1b09bb6c322923d779216ab2094375c5ee" default))
 '(global-command-log-mode t)
 '(package-selected-packages
   '(kotlin-mode scala-mode gruber-darker-theme command-log-mode use-package))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#d3b58d" :background "#042327"))))
 '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(font-lock-builtin-face ((t nil)))
 '(font-lock-comment-face ((t (:foreground "#3fdf1f"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "#c8d4ed"))))
 '(font-lock-keyword-face ((t (:foreground "white"))))
 '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))
 '(font-lock-waring-face ((t (:foreground "#504038"))))
 '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
 '(mode-line ((t (:inverse-video t))))
 '(region ((t (:background "blue"))))
 '(widget-field-face ((t (:foreground "white"))) t)
 '(widget-single-line-field-face ((t (:background "darkgray"))) t))

;; Enable command logging buffer
(use-package command-log-mode)

;; Set colour scheme
; (load-theme 'gruber-darker)
; (load-theme 'tango-dark)

;; JON BLOWS THEME


;; Custom i Night theme from VS-Code
;(custom-set-faces
; '(default ((t (:foreground "#dbdbdb" :background "#111111"))))
; '(font-lock-builtin-face ((t nil)))
; '(font-lock-comment-face ((t (:foreground "#696979"))))
; '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "#dbdbdb" :italic :weight))))
; '(font-lock-keyword-face ((t (:italic :weight :bold :weight))))
; '(font-lock-string-face ((t (:foreground "#a8a8b1"))))
; '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#dbdbdb"))))
; '(font-lock-waring-face ((t (:foreground "#dbdbdb"))))
; '(font-lock-type-face ((t (:foreground "#ffc400" :bold :weight))))
; '(font-lock-constant-face ((t (:foreground "#dbdbdb"))))
; '(font-lock-preprocessor-face ((t (:italic :weight :bold :weight))))
; '(region ((t (:background "#3d269c"))))
; '(widget-single-line-field-face ((t (:background "darkgray"))) t))
;(set-cursor-color "#7d46fc")

; (global-hl-line-mode 1)
; (set-face-background 'hl-line "midnight blue")

;; -*- lexical-binding: t; -*-

;; --------------------
;; Appearence
;; --------------------

;; font
(set-face-attribute 'default nil
                    :family "Maple Mono NF CN"
                    :height 160)

;; line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-hl-line-mode 1)

;; ruler
(setq-default fill-column 100)
(setq-default display-fill-column-indicator-character ?│)
(global-display-fill-column-indicator-mode 1)

(setq show-paren-delay 0
      show-paren-highlight-openparen nil)
(show-paren-mode 1)

;; cursor
(blink-cursor-mode -1)

;; --------------------
;; Editing
;; --------------------

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; newline at end of file
(setq require-final-newline t)

(delete-selection-mode 1)

;; --------------------
;; IO
;; --------------------

;; back up and auto save, see: early-init.el

;; persitent state
(savehist-mode 1)     ;; mini-buffer history
(recentf-mode 1)      ;; recent-opened file
(save-place-mode 1)   ;; cursor position

;; auto reload if edited by other processes
(global-auto-revert-mode 1)

;; smooth scroll
(setq scroll-conservatively 101)

;; disable bell
(setq ring-bell-function 'ignore)

;; --------------------
;; MISC
;; --------------------

;; encoding
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; --------------------
;; Packages
;; --------------------

(setq use-package-always-ensure t)
(setq package-archives '(("gnu"    . "https://mirrors.cernet.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.cernet.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.cernet.edu.cn/elpa/melpa/")))
(package-initialize)

(use-package rose-pine-theme
  :ensure nil
  :no-require t
  :init
  (add-to-list 'custom-theme-load-path
               (expand-file-name "themes" user-emacs-directory))
  :config
  (load-theme 'rose-pine t))

(use-package dired
  :ensure nil)

(use-package wdired
  :ensure nil
  :after dired)

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

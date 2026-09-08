;; -*- lexical-binding: t; -*-

;; --------------------
;; Appearence
;; --------------------

;; font
(set-face-attribute 'default nil
                    :family "Maple Mono NF CN"
                    :height 200)

;; line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-hl-line-mode 1)

;; ruler
(setq-default fill-column 100)
(setq-default display-fill-column-indicator-character ?│)
(global-display-fill-column-indicator-mode 1)

;; paren
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

(setq scroll-margin 4)

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
(pixel-scroll-precision-mode 1)

;; disable bell
(setq ring-bell-function 'ignore)

;; --------------------
;; Keymaps
;; --------------------

(defun mcz/split-left ()
  (interactive)
  (select-window (split-window nil nil 'left)))

(defun mcz/split-right ()
  (interactive)
  (select-window (split-window nil nil 'right)))

(defun mcz/split-above ()
  (interactive)
  (select-window (split-window nil nil 'above)))

(defun mcz/split-below ()
  (interactive)
  (select-window (split-window nil nil 'below)))

(define-prefix-command 'mcz/window-map)
(keymap-global-set "C-w" 'mcz/window-map)

(keymap-set mcz/window-map "h" #'mcz/split-left)
(keymap-set mcz/window-map "l" #'mcz/split-right)
(keymap-set mcz/window-map "k" #'mcz/split-above)
(keymap-set mcz/window-map "j" #'mcz/split-below)

(keymap-global-set "C-h" #'windmove-left)
(keymap-global-set "C-l" #'windmove-right)
(keymap-global-set "C-k" #'windmove-up)
(keymap-global-set "C-j" #'windmove-down)

;; --------------------
;; MISC
;; --------------------

;; encoding
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; --------------------
;; Packages
;; --------------------
(setq package-archives '(("gnu"    . "https://mirror.nju.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirror.nju.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirror.nju.edu.cn/elpa/melpa/")))
(package-initialize)

(use-package rose-pine-theme
  :no-require t
  :init
  (add-to-list 'custom-theme-load-path
               (expand-file-name "themes" user-emacs-directory))
  :config
  (load-theme 'rose-pine t))

(use-package dired)

(use-package wdired
  :after dired)

(setq use-package-always-ensure t)

(use-package magit
  :bind
  (("C-x g" . magit-status)))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-global-set-key 'normal
                       (kbd "U") #'evil-redo)
  (evil-global-set-key 'normal
                       (kbd "C-w h") #'mcz/split-left)
  (evil-global-set-key 'normal
                       (kbd "C-w l") #'mcz/split-right)
  (evil-global-set-key 'normal
                       (kbd "C-w j") #'mcz/split-up)
  (evil-global-set-key 'normal
                       (kbd "C-w k") #'mcz/split-down)
  :custom
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-undo-system 'undo-redo)
  (evil-shift-width 2))

(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-resize t)
  (vertico-cycle t)
  :bind
  (:map vertico-map
              ("<up>" . previous-history-element)
              ("<down>" . next-history-element)
              ("<tab>" . vertico-next)
              ("<backtab>" . vertico-previous)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package consult
  :bind
  (("C-c f" . consult-fd)
   ("C-c b" . consult-buffer)
   ("C-c /" . consult-ripgrep)))

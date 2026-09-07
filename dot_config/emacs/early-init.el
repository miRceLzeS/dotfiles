;; -*- lexical-binding: t; -*-

;; --------------------
;; Custom path
;; --------------------

(defconst custom-emacs-data-dir  "~/.local/share/emacs/")
(defconst custom-emacs-state-dir "~/.local/state/emacs/")
(defconst custom-emacs-cache-dir "~/.cache/emacs/")

(dolist (dir (list custom-emacs-data-dir
                   custom-emacs-state-dir
                   custom-emacs-cache-dir
                   (concat custom-emacs-data-dir "elpa/")
                   (concat custom-emacs-cache-dir "eln-cache/")
                   (concat custom-emacs-cache-dir "backups/")
                   (concat custom-emacs-cache-dir "auto-save/")))
  (make-directory dir t))

;; package
(setq package-user-dir
      (concat custom-emacs-data-dir "elpa/"))

;; native compilation cache
(startup-redirect-eln-cache
  (concat custom-emacs-cache-dir "eln-cache/"))

;; backup
(setq backup-directory-alist
      `(("." . ,(concat custom-emacs-cache-dir "backups/"))))

;; auto-save
(setq auto-save-file-name-transforms
      `((".*" ,(concat custom-emacs-cache-dir "auto-save/") t)))

(setq auto-save-list-file-prefix
      (concat custom-emacs-cache-dir "auto-save-list/.saves-"))

(make-directory
  (concat custom-emacs-cache-dir "auto-save/")
  t)

(make-directory
  (concat custom-emacs-cache-dir "auto-save-list/")
  t)

(setq savehist-file
      (concat custom-emacs-state-dir "history")

      recentf-save-file
      (concat custom-emacs-state-dir "recentf")

      save-place-file
      (concat custom-emacs-state-dir "places")

      bookmark-default-file
      (concat custom-emacs-state-dir "bookmarks"))

;; custom.el
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file :noerror :nomessage)

;; --------------------
;; UI
;; --------------------

(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

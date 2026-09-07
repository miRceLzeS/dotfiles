;;; rose-pine-theme.el --- Minimal Rosé Pine theme -*- lexical-binding: t; -*-

(deftheme rose-pine
          "Rosé Pine theme.")

(let ((base       "#191724")
      (surface    "#1f1d2e")
      (overlay    "#26233a")
      (muted      "#6e6a86")
      (subtle     "#908caa")
      (text       "#e0def4")
      (love       "#eb6f92")
      (gold       "#f6c177")
      (rose       "#ebbcba")
      (pine       "#31748f")
      (foam       "#9ccfd8")
      (iris       "#c4a7e7")
      (highlight  "#403d52"))

  (custom-theme-set-faces
    'rose-pine

    ;; Basic
    `(default
       ((t (:background ,base :foreground ,text))))

    `(cursor
       ((t (:background ,rose))))

    `(fringe
       ((t (:background ,base :foreground ,muted))))

    `(region
       ((t (:background ,highlight))))

    `(highlight
       ((t (:background ,overlay))))

    `(shadow
       ((t (:foreground ,muted))))

    `(link
       ((t (:foreground ,foam :underline t))))

    `(link-visited
       ((t (:foreground ,iris :underline t))))

    `(error
       ((t (:foreground ,love :weight bold))))

    `(warning
       ((t (:foreground ,gold :weight bold))))

    `(success
       ((t (:foreground ,foam :weight bold))))

    ;; Font lock
    `(font-lock-builtin-face
       ((t (:foreground ,love))))

    `(font-lock-comment-face
       ((t (:foreground ,muted :slant italic))))

    `(font-lock-comment-delimiter-face
       ((t (:foreground ,muted))))

    `(font-lock-constant-face
       ((t (:foreground ,foam))))

    `(font-lock-function-name-face
       ((t (:foreground ,rose))))

    `(font-lock-keyword-face
       ((t (:foreground ,pine))))

    `(font-lock-number-face
       ((t (:foreground ,gold))))

    `(font-lock-string-face
       ((t (:foreground ,gold))))

    `(font-lock-type-face
       ((t (:foreground ,foam))))

    `(font-lock-variable-name-face
       ((t (:foreground ,text))))

    `(font-lock-warning-face
       ((t (:foreground ,love :weight bold))))

    ;; Minibuffer / completion
    `(minibuffer-prompt
       ((t (:foreground ,pine :weight bold))))

    `(completions-common-part
       ((t (:foreground ,foam :weight bold))))

    `(completions-first-difference
       ((t (:foreground ,love))))

    ;; Mode line
    `(mode-line
       ((t (:background ,surface
                        :foreground ,text
                        :box nil))))

    `(mode-line-inactive
       ((t (:background ,base
                        :foreground ,muted
                        :box nil))))

    `(mode-line-buffer-id
       ((t (:foreground ,rose :weight bold))))

    ;; Line numbers
    `(line-number
       ((t (:foreground ,muted :background ,base))))

    `(line-number-current-line
       ((t (:foreground ,text
                        :background ,base
                        :weight bold))))

    ;; Search
    `(isearch
       ((t (:foreground ,base
                        :background ,gold
                        :weight bold))))

    `(lazy-highlight
       ((t (:foreground ,text
                        :background ,overlay))))

    `(match
       ((t (:foreground ,base
                        :background ,foam))))

    ;; Parentheses
    `(show-paren-match
       ((t (:foreground ,base
                        :background ,rose
                        :weight bold))))

    `(show-paren-mismatch
       ((t (:foreground ,base
                        :background ,love
                        :weight bold))))

    ;; Dired
    `(dired-directory
       ((t (:foreground ,foam :weight bold))))

    `(dired-symlink
       ((t (:foreground ,iris))))

    `(dired-marked
       ((t (:foreground ,rose :weight bold))))

    ;; Diff
    `(diff-added
       ((t (:foreground ,foam))))

    `(diff-removed
       ((t (:foreground ,love))))

    `(diff-changed
       ((t (:foreground ,gold))))

    `(diff-header
       ((t (:foreground ,subtle
                        :background ,surface))))

    `(diff-file-header
       ((t (:foreground ,text
                        :background ,overlay
                        :weight bold))))

    ;; Misc
    `(vertical-border
       ((t (:foreground ,overlay))))

    `(window-divider
       ((t (:foreground ,overlay))))

    `(trailing-whitespace
       ((t (:background ,love))))))

(provide-theme 'rose-pine)


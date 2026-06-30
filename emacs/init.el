;;; init.el --- Minimal evil-based Emacs config -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Vim keybindings in Emacs, rolled by hand instead of via a framework.
;; The whole "Vim experience" is four packages:
;;
;;   evil            - the Vim emulation (normal/insert/visual states, motions)
;;   evil-collection - Vim keys in dired, magit, help, *Messages*, etc.
;;   general         - clean `SPC' leader-key definitions (Doom-style)
;;   which-key       - popup of available keys (built into Emacs 30)
;;
;; Everything below that is a small pile of sane built-in defaults and a
;; leader map bound only to *built-in* commands, so nothing here breaks if
;; you never install another package. Add more under the marked sections.
;;
;; Layout:
;;   early-init.el  - UI/startup tuning (runs first)
;;   init.el        - this file
;;   themes/        - the github-dark-colorblind theme (ported from nvim)

;;; Code:

;;; ----------------------------------------------------------------------------
;;; Package bootstrap
;;; ----------------------------------------------------------------------------

(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; `use-package' ships with Emacs 29+; install it only as a fallback.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t        ; auto-install declared packages
      use-package-expand-minimally t)

;;; ----------------------------------------------------------------------------
;;; Sane built-in defaults
;;; ----------------------------------------------------------------------------

;; Encoding everywhere.
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; Behaviour.
(setq-default indent-tabs-mode nil      ; spaces, not tabs
              tab-width 4
              fill-column 80)
(setq use-short-answers t               ; y/n instead of yes/no
      ring-bell-function #'ignore       ; no audible bell
      scroll-conservatively 101         ; don't recenter when scrolling off-screen
      scroll-margin 3
      sentence-end-double-space nil
      require-final-newline t
      enable-recursive-minibuffers t)

;; Keep the config directory tidy: backups, auto-saves and lockfiles out of the
;; way, and the machine-generated custom.el out of init.el (and out of git).
(let ((backup-dir    (expand-file-name "backups/"   user-emacs-directory))
      (autosave-dir  (expand-file-name "auto-save/" user-emacs-directory)))
  (make-directory backup-dir   t)
  (make-directory autosave-dir t)
  (setq backup-directory-alist         `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,autosave-dir t))
        create-lockfiles nil
        backup-by-copying t
        delete-old-versions t
        version-control t
        kept-new-versions 6
        kept-old-versions 2))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil 'nomessage))

;; Persist minibuffer history, recent files, and cursor position between sessions.
;; Set the vars BEFORE enabling recentf: the default `recentf-auto-cleanup' of
;; `mode' runs a stat-everything cleanup at mode-enable, which can hang on remote
;; (TRAMP) paths — `never' only helps if it's set first.
(setq recentf-max-saved-items 200
      recentf-auto-cleanup 'never)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)

;; Editor niceties.
(setq display-line-numbers-type t)      ; absolute; set to `relative' for vim-style
;; Numbers in code/prose buffers only — not dired, *Help*, terminals, images, etc.
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)             ; reload files changed on disk
(setq global-auto-revert-non-file-buffers t)
(winner-mode 1)                         ; undo/redo window layout changes
(delete-selection-mode 1)               ; typing replaces the active region

;; Font — ported from the previous Doom config (JetBrainsMono Nerd Font, large).
;; `:height' is in 1/10 pt; bump or drop it to taste. Applied per-frame so it
;; also reaches GUI frames spawned later by `emacsclient' under a daemon (where
;; `display-graphic-p' is nil at init time). No-op on TTY/--batch or if the font
;; isn't installed.
(defun my/set-default-font (&optional frame)
  "Set the default font on FRAME when it is graphical and the font exists."
  (when (and (display-graphic-p frame)
             (find-font (font-spec :family "JetBrainsMono Nerd Font")))
    (set-face-attribute 'default frame
                        :family "JetBrainsMono Nerd Font" :height 180)))
(add-hook 'after-make-frame-functions #'my/set-default-font)
(my/set-default-font)                   ; the initial (non-daemon) frame

;;; ----------------------------------------------------------------------------
;;; Evil — the actual Vim emulation
;;; ----------------------------------------------------------------------------

(use-package evil
  :init
  ;; MUST be set before evil loads so evil-collection can take over the rest.
  (setq evil-want-keybinding nil
        evil-want-integration t
        evil-want-C-u-scroll t          ; C-u scrolls (like Vim) instead of prefix-arg
        evil-want-Y-yank-to-eol t
        evil-undo-system 'undo-redo     ; built-in undo-redo (Emacs 28+); C-r redoes
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-search-module 'evil-search)
  :config
  (evil-mode 1))
;; Note: `j'/`k' move by logical lines (pure Vim). Use `gj'/`gk' to move by
;; visual (wrapped) lines — both are bound out of the box by evil.

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;; ----------------------------------------------------------------------------
;;; which-key — discoverable keybinding popup (built-in on Emacs 30)
;;; ----------------------------------------------------------------------------

(use-package which-key
  :ensure nil                           ; bundled with Emacs 30; don't fetch from ELPA
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode 1))

;;; ----------------------------------------------------------------------------
;;; Leader key (SPC) via general
;;; ----------------------------------------------------------------------------

(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal insert visual motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")            ; reach the leader from insert/other states via
                                       ; M-SPC (SPC still self-inserts there). M-SPC, not
                                       ; C-SPC, keeps set-mark free — but note some desktops
                                       ; grab Alt+SPC (KDE/GNOME); rebind there if it's eaten.

  (my/leader
    "SPC" '(project-find-file       :which-key "find file in project")
    ":"   '(execute-extended-command :which-key "M-x")
    ";"   '(eval-expression         :which-key "eval")
    "."   '(find-file               :which-key "find file")
    ","   '(switch-to-buffer        :which-key "switch buffer")
    "!"   '(shell-command           :which-key "shell command")
    "u"   '(universal-argument      :which-key "C-u")

    ;; buffers
    "b"   '(:ignore t :which-key "buffer")
    "bb"  '(switch-to-buffer        :which-key "switch")
    "bd"  '(kill-current-buffer     :which-key "kill")
    "bn"  '(next-buffer             :which-key "next")
    "bp"  '(previous-buffer         :which-key "prev")
    "br"  '(revert-buffer           :which-key "revert")
    "bs"  '(scratch-buffer          :which-key "scratch")

    ;; files
    "f"   '(:ignore t :which-key "file")
    "ff"  '(find-file               :which-key "find")
    "fs"  '(save-buffer             :which-key "save")
    "fS"  '(write-file              :which-key "save as")
    "fr"  '(recentf-open-files      :which-key "recent")
    "fR"  '(rename-visited-file     :which-key "rename")

    ;; windows
    "w"   '(:ignore t :which-key "window")
    "wv"  '(split-window-right      :which-key "split right")
    "ws"  '(split-window-below      :which-key "split below")
    "wd"  '(delete-window           :which-key "delete")
    "wo"  '(delete-other-windows    :which-key "only")
    "ww"  '(other-window            :which-key "other")
    "wh"  '(windmove-left           :which-key "left")
    "wj"  '(windmove-down           :which-key "down")
    "wk"  '(windmove-up             :which-key "up")
    "wl"  '(windmove-right          :which-key "right")
    "w="  '(balance-windows         :which-key "balance")
    "wu"  '(winner-undo             :which-key "undo layout")
    "wU"  '(winner-redo             :which-key "redo layout")

    ;; search
    "s"   '(:ignore t :which-key "search")
    "ss"  '(isearch-forward         :which-key "in buffer")
    "so"  '(occur                   :which-key "occur")
    "sp"  '(project-find-regexp     :which-key "in project")

    ;; project (built-in project.el)
    "p"   '(:ignore t :which-key "project")
    "pp"  '(project-switch-project   :which-key "switch")
    "pf"  '(project-find-file        :which-key "find file")
    "pb"  '(project-switch-to-buffer :which-key "buffer")
    "pg"  '(project-find-regexp      :which-key "grep")
    "pd"  '(project-dired            :which-key "dired")

    ;; code
    "c"   '(:ignore t :which-key "code")
    "cc"  '(comment-line            :which-key "comment line")
    "cd"  '(comment-dwim            :which-key "comment dwim")

    ;; git (built-in vc; swap to magit once you install it)
    "g"   '(:ignore t :which-key "git")
    "gg"  '(vc-dir                  :which-key "vc-dir")
    "gb"  '(vc-annotate             :which-key "blame")

    ;; toggles
    "t"   '(:ignore t :which-key "toggle")
    "tl"  '(display-line-numbers-mode :which-key "line numbers")
    "tw"  '(visual-line-mode        :which-key "word wrap")
    "tt"  '(my/load-theme           :which-key "load theme")

    ;; help
    "h"   '(:ignore t :which-key "help")
    "hf"  '(describe-function       :which-key "function")
    "hv"  '(describe-variable       :which-key "variable")
    "hk"  '(describe-key            :which-key "key")
    "hm"  '(describe-mode           :which-key "mode")
    "ho"  '(describe-symbol         :which-key "symbol")

    ;; quit / restart
    "q"   '(:ignore t :which-key "quit")
    "qq"  '(save-buffers-kill-terminal :which-key "quit")
    "qr"  '(restart-emacs           :which-key "restart")))

;;; ----------------------------------------------------------------------------
;;; Theme — github-dark-colorblind (a 1:1 port of the nvim colorscheme)
;;; ----------------------------------------------------------------------------

;; The theme is generated with autothemer, so it needs that package available.
(use-package autothemer)

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/" user-emacs-directory))
(setq custom-safe-themes t)             ; personal config: don't prompt on load
(load-theme 'github-dark-colorblind t)

;; `SPC t t' switch: disable the current theme first so themes don't stack into
;; a muddy mix (bare `load-theme' layers them).
(defun my/load-theme (theme)
  "Disable all enabled themes, then load THEME."
  (interactive
   (list (intern (completing-read
                  "Theme: " (mapcar #'symbol-name (custom-available-themes))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

;;; ----------------------------------------------------------------------------
;;; Add your own packages / bindings below.
;;; ----------------------------------------------------------------------------
;; Popular next steps (all play nicely with the leader map above):
;;   vertico + orderless + marginalia + consult  - completion UI
;;   magit                                        - then rebind "gg" -> magit-status
;;   corfu + cape                                 - in-buffer completion
;; The ported theme already styles all of these.

(provide 'init)
;;; init.el ends here

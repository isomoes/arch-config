;;; github-dark-colorblind-theme.el --- GitHub Dark (colorblind) -*- lexical-binding: t; no-byte-compile: t; -*-

;; Author: isomoes (generated)
;; Requires: autothemer
;; SPDX-License-Identifier: MIT

;;; Commentary:
;;
;; A 1:1 Emacs port of the nvim `github_dark_colorblind' colorscheme
;; (projekt0n/github-nvim-theme).  The palette below is the *resolved*
;; output dumped from a headless Neovim running that exact scheme, so the
;; colors match the terminal/nvim setup precisely.
;;
;; Distinctive colorblind traits vs. plain github-dark:
;;   - keywords / statements are ORANGE (#ec8e2c), not red
;;   - types are light ORANGE (#fdac54)
;;   - git / diff use BLUE for additions (#58a6ff) and ORANGE for
;;     deletions (#d47616) instead of green / red.
;;
;; nvim styles reproduced:  comments italic, keywords bold,
;; types bold+italic (see `github-theme' opts in astroui.lua).
;;
;; This file is self-contained; it only needs `autothemer' (already a
;; Doom package).  Drop it in $DOOMDIR/themes/ and set
;;   (setq doom-theme 'github-dark-colorblind)

;;; Code:

(require 'autothemer)

(autothemer-deftheme
 github-dark-colorblind
 "GitHub Dark (colorblind) — ported from nvim github_dark_colorblind."

 ((((class color) (min-colors #xFFFFFF))   ; 24-bit / GUI
   ((class color) (min-colors #xFF)))       ; 256-color terminal

  ;; ── Backgrounds & neutrals ──────────────────────────────────────────
  (gh-bg          "#0d1117" "#0d1117")  ; Normal bg
  (gh-bg-alt      "#04070d" "#010409")  ; floats / popups / pmenu
  (gh-bg-hl       "#161b22" "#1c2128")  ; CursorLine / hl-line
  (gh-bg-hl2      "#171b22" "#1c2128")  ; ColorColumn / Folded / TabLine
  (gh-fg          "#c9d1d9" "#c9d1d9")  ; default text / variables
  (gh-fg-dim      "#8b949e" "#8b949e")  ; comments / inactive
  (gh-gray        "#6e7681" "#6e7681")  ; line numbers / fringe
  (gh-border      "#30363d" "#30363d")  ; window separators

  ;; ── Accents ─────────────────────────────────────────────────────────
  (gh-blue        "#79c0ff" "#79c0ff")  ; constants / numbers / operators
  (gh-blue-br     "#58a6ff" "#58a6ff")  ; info / links / git-add
  (gh-blue-lt     "#a5d6ff" "#a5d6ff")  ; strings
  (gh-purple      "#d2a8ff" "#d2a8ff")  ; functions / directories
  (gh-orange      "#ec8e2c" "#ec8e2c")  ; keywords / statements
  (gh-orange-lt   "#fdac54" "#fdac54")  ; types
  (gh-orange-dk   "#d47616" "#d47616")  ; errors / git-delete
  (gh-yellow      "#d29922" "#d29922")  ; warnings / git-change
  (gh-green       "#b3f6c0" "#b3f6c0")  ; success / ok

  ;; ── UI fills ────────────────────────────────────────────────────────
  (gh-visual      "#2f547f" "#2f547f")  ; Visual selection / region
  (gh-search      "#8d7230" "#8d7230")  ; Search highlight
  (gh-sel         "#1c3d6a" "#1c3d6a")  ; PmenuSel
  (gh-paren       "#1e4273" "#1e4273")  ; MatchParen
  (gh-diff-add    "#101f37" "#101f37")  ; diff add bg
  (gh-diff-chg    "#231e14" "#231e14")  ; diff change bg
  (gh-diff-del    "#271d14" "#271d14")  ; diff delete bg
  (gh-statusbar   "#3f76b6" "#3f76b6")) ; nvim StatusLine bar

  ;; ────────────────────────────────────────────────────────────────────
  ;; Faces
  ;; ────────────────────────────────────────────────────────────────────
  (;; ── Base / editor ──────────────────────────────────────────────────
    (default                           (:background gh-bg :foreground gh-fg))
    (cursor                            (:background gh-blue-br :foreground gh-bg))
    (fringe                            (:background gh-bg :foreground gh-gray))
    (region                            (:background gh-visual :extend t))
    (secondary-selection               (:background gh-sel :extend t))
    (highlight                         (:background gh-sel :foreground gh-fg))
    (hl-line                           (:background gh-bg-hl :extend t))
    (cursor-line                       (:background gh-bg-hl :extend t))
    (lazy-highlight                    (:background gh-search :foreground gh-fg))
    (isearch                           (:background gh-orange :foreground gh-bg-hl))
    (isearch-fail                      (:background gh-orange-dk :foreground gh-bg))
    (match                             (:background gh-blue :foreground gh-bg))
    (shadow                            (:foreground gh-gray))
    (link                              (:foreground gh-blue-br :underline t))
    (link-visited                      (:foreground gh-purple :underline t))
    (custom-link                       (:foreground gh-blue-br :underline t))
    (button                            (:foreground gh-blue-br :underline t))
    (error                             (:foreground gh-orange-dk :weight 'bold))
    (warning                           (:foreground gh-yellow :weight 'bold))
    (success                           (:foreground gh-blue-br :weight 'bold))
    (escape-glyph                      (:foreground gh-blue))
    (homoglyph                         (:foreground gh-blue))
    (trailing-whitespace               (:background gh-orange-dk))
    (nobreak-space                     (:foreground gh-gray))
    (nobreak-hyphen                    (:foreground gh-gray))
    (tooltip                           (:background gh-bg-alt :foreground gh-fg))
    (header-line                       (:background gh-bg-hl2 :foreground gh-fg))
    (minibuffer-prompt                 (:foreground gh-blue-br :weight 'bold))

    ;; ── Line numbers ──────────────────────────────────────────────────
    (line-number                       (:background gh-bg :foreground gh-gray))
    (line-number-current-line          (:background gh-bg :foreground gh-fg :weight 'bold))
    (linum                             (:inherit 'line-number))
    (fill-column-indicator             (:foreground gh-bg-hl2))

    ;; ── Window chrome ─────────────────────────────────────────────────
    (vertical-border                   (:foreground gh-border))
    (window-divider                    (:foreground gh-border))
    (window-divider-first-pixel        (:foreground gh-border))
    (window-divider-last-pixel         (:foreground gh-border))
    (mode-line                         (:background gh-bg-hl :foreground gh-fg
                                        :box (:line-width 1 :color gh-border)))
    (mode-line-active                  (:inherit 'mode-line))
    (mode-line-inactive                (:background gh-bg :foreground gh-gray
                                        :box (:line-width 1 :color gh-border)))
    (mode-line-highlight               (:foreground gh-blue-br))
    (mode-line-buffer-id               (:foreground gh-fg :weight 'bold))

    ;; ── Tabs ──────────────────────────────────────────────────────────
    (tab-bar                           (:background gh-bg-alt :foreground gh-fg-dim))
    (tab-bar-tab                       (:background gh-bg :foreground gh-fg :weight 'bold))
    (tab-bar-tab-inactive              (:background gh-bg-alt :foreground gh-fg-dim))
    (tab-line                          (:background gh-bg-alt :foreground gh-fg-dim))

    ;; ── Parens ────────────────────────────────────────────────────────
    (show-paren-match                  (:background gh-paren :foreground gh-fg :weight 'bold))
    (show-paren-match-expression       (:background gh-paren :foreground gh-fg))
    (show-paren-mismatch               (:background gh-orange-dk :foreground gh-bg :weight 'bold))

    ;; ── Font lock (used by treesit on Emacs 29+ too) ──────────────────
    (font-lock-comment-face                (:foreground gh-fg-dim :slant 'italic))
    (font-lock-comment-delimiter-face      (:foreground gh-fg-dim :slant 'italic))
    (font-lock-doc-face                    (:foreground gh-fg-dim :slant 'italic))
    (font-lock-doc-markup-face             (:foreground gh-blue))
    (font-lock-string-face                 (:foreground gh-blue-lt))
    (font-lock-keyword-face                (:foreground gh-orange :weight 'bold))
    (font-lock-builtin-face                (:foreground gh-blue))
    (font-lock-function-name-face          (:foreground gh-purple))
    (font-lock-function-call-face          (:foreground gh-purple))
    (font-lock-variable-name-face          (:foreground gh-fg))
    (font-lock-variable-use-face           (:foreground gh-fg))
    (font-lock-type-face                   (:foreground gh-orange-lt :weight 'bold :slant 'italic))
    (font-lock-constant-face               (:foreground gh-blue))
    (font-lock-number-face                 (:foreground gh-blue))
    (font-lock-property-name-face          (:foreground gh-blue))
    (font-lock-property-use-face           (:foreground gh-blue))
    (font-lock-operator-face               (:foreground gh-blue))
    (font-lock-punctuation-face            (:foreground gh-fg))
    (font-lock-bracket-face                (:foreground gh-fg))
    (font-lock-delimiter-face              (:foreground gh-fg))
    (font-lock-misc-punctuation-face       (:foreground gh-fg))
    (font-lock-escape-face                 (:foreground gh-blue-lt :weight 'bold))
    (font-lock-regexp-grouping-construct   (:foreground gh-orange :weight 'bold))
    (font-lock-regexp-grouping-backslash   (:foreground gh-blue-lt))
    (font-lock-preprocessor-face           (:foreground gh-orange))
    (font-lock-negation-char-face          (:foreground gh-orange))
    (font-lock-warning-face                (:foreground gh-orange-dk :weight 'bold))
    (elisp-shorthand-font-lock-face        (:foreground gh-fg))

    ;; ── tree-sitter (elisp-tree-sitter / :tools tree-sitter) ──────────
    (tree-sitter-hl-face:comment           (:foreground gh-fg-dim :slant 'italic))
    (tree-sitter-hl-face:doc               (:foreground gh-fg-dim :slant 'italic))
    (tree-sitter-hl-face:string            (:foreground gh-blue-lt))
    (tree-sitter-hl-face:string.special    (:foreground gh-blue-lt))
    (tree-sitter-hl-face:escape            (:foreground gh-blue-lt :weight 'bold))
    (tree-sitter-hl-face:keyword           (:foreground gh-orange :weight 'bold))
    (tree-sitter-hl-face:operator          (:foreground gh-blue))
    (tree-sitter-hl-face:label             (:foreground gh-orange))
    (tree-sitter-hl-face:constant          (:foreground gh-blue))
    (tree-sitter-hl-face:constant.builtin  (:foreground gh-blue :weight 'bold))
    (tree-sitter-hl-face:number            (:foreground gh-blue))
    (tree-sitter-hl-face:boolean           (:foreground gh-blue))
    (tree-sitter-hl-face:function          (:foreground gh-purple))
    (tree-sitter-hl-face:function.call     (:foreground gh-purple))
    (tree-sitter-hl-face:function.builtin  (:foreground gh-blue))
    (tree-sitter-hl-face:function.macro    (:foreground gh-orange))
    (tree-sitter-hl-face:function.special  (:foreground gh-purple))
    (tree-sitter-hl-face:method            (:foreground gh-purple))
    (tree-sitter-hl-face:method.call       (:foreground gh-purple))
    (tree-sitter-hl-face:type              (:foreground gh-orange-lt :weight 'bold :slant 'italic))
    (tree-sitter-hl-face:type.builtin      (:foreground gh-orange :weight 'bold :slant 'italic))
    (tree-sitter-hl-face:type.parameter    (:foreground gh-orange-lt))
    (tree-sitter-hl-face:constructor       (:foreground gh-orange-lt))
    (tree-sitter-hl-face:variable          (:foreground gh-fg))
    (tree-sitter-hl-face:variable.builtin  (:foreground gh-blue))
    (tree-sitter-hl-face:variable.parameter (:foreground gh-fg))
    (tree-sitter-hl-face:variable.special  (:foreground gh-blue))
    (tree-sitter-hl-face:property          (:foreground gh-blue))
    (tree-sitter-hl-face:attribute         (:foreground gh-blue))
    (tree-sitter-hl-face:tag               (:foreground gh-blue-lt))
    (tree-sitter-hl-face:punctuation       (:foreground gh-fg))
    (tree-sitter-hl-face:punctuation.bracket   (:foreground gh-fg))
    (tree-sitter-hl-face:punctuation.delimiter (:foreground gh-fg))
    (tree-sitter-hl-face:punctuation.special   (:foreground gh-orange))

    ;; ── Diagnostics: flymake / flycheck / lsp / eglot ─────────────────
    (flymake-error                     (:underline (:color gh-orange-dk :style 'wave)))
    (flymake-warning                   (:underline (:color gh-yellow :style 'wave)))
    (flymake-note                      (:underline (:color gh-blue-br :style 'wave)))
    (flycheck-error                    (:underline (:color gh-orange-dk :style 'wave)))
    (flycheck-warning                  (:underline (:color gh-yellow :style 'wave)))
    (flycheck-info                     (:underline (:color gh-blue-br :style 'wave)))
    (flycheck-fringe-error             (:foreground gh-orange-dk))
    (flycheck-fringe-warning           (:foreground gh-yellow))
    (flycheck-fringe-info              (:foreground gh-blue-br))
    (compilation-error                 (:foreground gh-orange-dk :weight 'bold))
    (compilation-warning               (:foreground gh-yellow))
    (compilation-info                  (:foreground gh-blue-br))
    (compilation-mode-line-fail        (:foreground gh-orange-dk))
    (compilation-mode-line-run         (:foreground gh-yellow))
    (compilation-mode-line-exit        (:foreground gh-blue-br))

    (lsp-face-highlight-textual        (:background gh-bg-hl))
    (lsp-face-highlight-read           (:background gh-bg-hl))
    (lsp-face-highlight-write          (:background gh-bg-hl :weight 'bold))
    (lsp-headerline-breadcrumb-path-face          (:foreground gh-fg-dim))
    (lsp-headerline-breadcrumb-symbols-face       (:foreground gh-fg))
    (eglot-highlight-symbol-face       (:background gh-bg-hl :weight 'bold))
    (eldoc-highlight-function-argument (:foreground gh-orange-lt :weight 'bold))

    ;; ── diff-mode / ediff ─────────────────────────────────────────────
    (diff-added                        (:foreground gh-blue-br :background gh-diff-add :extend t))
    (diff-removed                      (:foreground gh-orange-dk :background gh-diff-del :extend t))
    (diff-changed                      (:foreground gh-yellow :background gh-diff-chg :extend t))
    (diff-indicator-added              (:foreground gh-blue-br :background gh-diff-add))
    (diff-indicator-removed            (:foreground gh-orange-dk :background gh-diff-del))
    (diff-indicator-changed            (:foreground gh-yellow :background gh-diff-chg))
    (diff-refine-added                 (:foreground gh-blue-br :background gh-sel :weight 'bold))
    (diff-refine-removed               (:foreground gh-orange-dk :background gh-diff-del :weight 'bold))
    (diff-refine-changed               (:foreground gh-yellow :background gh-diff-chg :weight 'bold))
    (diff-context                      (:foreground gh-fg-dim))
    (diff-hunk-header                  (:foreground gh-purple :background gh-bg-hl2 :extend t))
    (diff-function                     (:foreground gh-purple :background gh-bg-hl2))
    (diff-file-header                  (:foreground gh-fg :weight 'bold))
    (diff-header                       (:foreground gh-fg-dim :background gh-bg-hl2))
    (ediff-current-diff-A             (:background gh-diff-del :extend t))
    (ediff-current-diff-B             (:background gh-diff-add :extend t))
    (ediff-current-diff-C             (:background gh-diff-chg :extend t))
    (ediff-fine-diff-A                (:background gh-diff-del :foreground gh-orange-dk :weight 'bold))
    (ediff-fine-diff-B                (:background gh-diff-add :foreground gh-blue-br :weight 'bold))
    (ediff-fine-diff-C                (:background gh-diff-chg :foreground gh-yellow :weight 'bold))

    ;; ── Magit ─────────────────────────────────────────────────────────
    (magit-section-heading             (:foreground gh-orange-lt :weight 'bold))
    (magit-section-highlight           (:background gh-bg-hl :extend t))
    (magit-section-heading-selection   (:foreground gh-orange :weight 'bold))
    (magit-diff-added                  (:foreground gh-blue-br :background gh-diff-add :extend t))
    (magit-diff-added-highlight        (:foreground gh-blue-br :background gh-sel :extend t))
    (magit-diff-removed                (:foreground gh-orange-dk :background gh-diff-del :extend t))
    (magit-diff-removed-highlight      (:foreground gh-orange-dk :background gh-diff-del :weight 'bold :extend t))
    (magit-diff-context                (:foreground gh-fg-dim :extend t))
    (magit-diff-context-highlight      (:foreground gh-fg :background gh-bg-hl :extend t))
    (magit-diff-hunk-heading           (:foreground gh-fg-dim :background gh-bg-hl2 :extend t))
    (magit-diff-hunk-heading-highlight (:foreground gh-fg :background gh-border :extend t))
    (magit-diff-hunk-heading-selection (:foreground gh-orange-lt :background gh-border :extend t))
    (magit-diff-lines-heading          (:foreground gh-bg :background gh-blue-br :extend t))
    (magit-diffstat-added              (:foreground gh-blue-br))
    (magit-diffstat-removed            (:foreground gh-orange-dk))
    (magit-blame-heading               (:foreground gh-fg :background gh-bg-hl2 :extend t))
    (magit-blame-hash                  (:foreground gh-purple))
    (magit-blame-name                  (:foreground gh-orange-lt))
    (magit-blame-date                  (:foreground gh-fg-dim))
    (magit-hash                        (:foreground gh-fg-dim))
    (magit-tag                         (:foreground gh-yellow :weight 'bold))
    (magit-branch-local                (:foreground gh-blue))
    (magit-branch-remote               (:foreground gh-blue-br))
    (magit-branch-current              (:foreground gh-blue :weight 'bold :box 1))
    (magit-head                        (:foreground gh-blue))
    (magit-refname                     (:foreground gh-fg-dim))
    (magit-log-author                  (:foreground gh-orange-lt))
    (magit-log-date                    (:foreground gh-fg-dim))
    (magit-log-graph                   (:foreground gh-fg-dim))
    (magit-process-ok                  (:foreground gh-blue-br :weight 'bold))
    (magit-process-ng                  (:foreground gh-orange-dk :weight 'bold))
    (magit-bisect-good                 (:foreground gh-blue-br))
    (magit-bisect-bad                  (:foreground gh-orange-dk))
    (magit-bisect-skip                 (:foreground gh-yellow))
    (magit-cherry-equivalent           (:foreground gh-purple))
    (magit-cherry-unmatched            (:foreground gh-blue))
    (magit-reflog-commit               (:foreground gh-blue-br))
    (magit-reflog-amend                (:foreground gh-purple))
    (magit-reflog-merge                (:foreground gh-blue-br))
    (magit-reflog-checkout             (:foreground gh-blue))
    (magit-reflog-reset                (:foreground gh-orange-dk))
    (magit-reflog-rebase               (:foreground gh-purple))
    (magit-reflog-cherry-pick          (:foreground gh-blue-br))
    (magit-signature-good              (:foreground gh-blue-br))
    (magit-signature-bad               (:foreground gh-orange-dk :weight 'bold))

    ;; ── Git gutter / diff-hl ──────────────────────────────────────────
    (git-gutter:added                  (:foreground gh-blue-br))
    (git-gutter:deleted                (:foreground gh-orange-dk))
    (git-gutter:modified               (:foreground gh-yellow))
    (git-gutter-fr:added               (:foreground gh-blue-br))
    (git-gutter-fr:deleted             (:foreground gh-orange-dk))
    (git-gutter-fr:modified            (:foreground gh-yellow))
    (diff-hl-insert                    (:foreground gh-blue-br :background gh-blue-br))
    (diff-hl-delete                    (:foreground gh-orange-dk :background gh-orange-dk))
    (diff-hl-change                    (:foreground gh-yellow :background gh-yellow))

    ;; ── VC / change-log ───────────────────────────────────────────────
    (vc-up-to-date-state               (:foreground gh-fg-dim))
    (vc-edited-state                   (:foreground gh-yellow))
    (vc-locally-added-state            (:foreground gh-blue-br))
    (vc-removed-state                  (:foreground gh-orange-dk))
    (vc-conflict-state                 (:foreground gh-orange-dk :weight 'bold))
    (vc-missing-state                  (:foreground gh-orange-dk))
    (smerge-upper                      (:background gh-diff-del :extend t))
    (smerge-lower                      (:background gh-diff-add :extend t))
    (smerge-base                       (:background gh-diff-chg :extend t))
    (smerge-markers                    (:foreground gh-fg-dim :background gh-bg-hl2 :extend t))

    ;; ── Completion: vertico / corfu / company / orderless / consult ───
    (vertico-current                   (:background gh-bg-hl :extend t))
    (vertico-group-title               (:foreground gh-purple :weight 'bold))
    (vertico-group-separator           (:foreground gh-border :strike-through t))
    (corfu-default                     (:background gh-bg-alt :foreground gh-fg))
    (corfu-current                     (:background gh-sel :foreground gh-fg))
    (corfu-bar                         (:background gh-blue-br))
    (corfu-border                      (:background gh-border))
    (corfu-annotations                 (:foreground gh-fg-dim))
    (company-tooltip                   (:background gh-bg-alt :foreground gh-fg))
    (company-tooltip-selection         (:background gh-sel :weight 'bold))
    (company-tooltip-common            (:foreground gh-blue-br :weight 'bold))
    (company-tooltip-annotation        (:foreground gh-fg-dim))
    (company-tooltip-scrollbar-thumb   (:background gh-visual))
    (company-tooltip-scrollbar-track   (:background gh-bg-hl2))
    (company-preview                   (:foreground gh-fg-dim))
    (company-preview-common            (:foreground gh-blue-br))
    (company-scrollbar-bg              (:background gh-bg-hl2))
    (company-scrollbar-fg              (:background gh-visual))
    (orderless-match-face-0            (:foreground gh-blue-br :weight 'bold))
    (orderless-match-face-1            (:foreground gh-purple :weight 'bold))
    (orderless-match-face-2            (:foreground gh-orange-lt :weight 'bold))
    (orderless-match-face-3            (:foreground gh-blue-lt :weight 'bold))
    (completions-common-part           (:foreground gh-blue-br :weight 'bold))
    (completions-first-difference      (:foreground gh-orange :weight 'bold))
    (completions-annotations           (:foreground gh-fg-dim :slant 'italic))
    (consult-file                      (:foreground gh-fg))
    (consult-line-number               (:foreground gh-gray))
    (consult-async-running             (:foreground gh-orange))
    (marginalia-key                    (:foreground gh-orange))
    (marginalia-documentation          (:foreground gh-fg-dim :slant 'italic))
    (marginalia-file-name              (:foreground gh-fg-dim))
    (marginalia-size                   (:foreground gh-blue))
    (marginalia-number                 (:foreground gh-blue))
    (marginalia-modified               (:foreground gh-yellow))

    ;; ── Search frameworks: ivy / swiper / anzu / isearch counts ──────
    (ivy-current-match                 (:background gh-bg-hl :foreground gh-fg :weight 'bold :extend t))
    (ivy-minibuffer-match-face-1       (:foreground gh-fg-dim))
    (ivy-minibuffer-match-face-2       (:foreground gh-blue-br :weight 'bold))
    (ivy-minibuffer-match-face-3       (:foreground gh-purple :weight 'bold))
    (ivy-minibuffer-match-face-4       (:foreground gh-orange-lt :weight 'bold))
    (swiper-match-face-1               (:background gh-bg-hl))
    (swiper-match-face-2               (:background gh-sel :weight 'bold))
    (swiper-line-face                  (:background gh-bg-hl :extend t))
    (anzu-mode-line                    (:foreground gh-orange :weight 'bold))

    ;; ── which-key ─────────────────────────────────────────────────────
    (which-key-key-face                (:foreground gh-orange :weight 'bold))
    (which-key-group-description-face  (:foreground gh-purple))
    (which-key-command-description-face (:foreground gh-fg))
    (which-key-separator-face          (:foreground gh-fg-dim))
    (which-key-note-face               (:foreground gh-fg-dim))

    ;; ── hl-todo / comments keywords ──────────────────────────────────
    (hl-todo                           (:foreground gh-bg :background gh-blue-br :weight 'bold))

    ;; ── rainbow delimiters ───────────────────────────────────────────
    (rainbow-delimiters-depth-1-face   (:foreground gh-fg))
    (rainbow-delimiters-depth-2-face   (:foreground gh-blue))
    (rainbow-delimiters-depth-3-face   (:foreground gh-purple))
    (rainbow-delimiters-depth-4-face   (:foreground gh-orange-lt))
    (rainbow-delimiters-depth-5-face   (:foreground gh-blue-lt))
    (rainbow-delimiters-depth-6-face   (:foreground gh-orange))
    (rainbow-delimiters-depth-7-face   (:foreground gh-blue-br))
    (rainbow-delimiters-depth-8-face   (:foreground gh-yellow))
    (rainbow-delimiters-depth-9-face   (:foreground gh-fg-dim))
    (rainbow-delimiters-unmatched-face (:foreground gh-orange-dk :weight 'bold))
    (rainbow-delimiters-mismatched-face (:foreground gh-orange-dk :weight 'bold))

    ;; ── dired / treemacs ──────────────────────────────────────────────
    (dired-directory                   (:foreground gh-purple :weight 'bold))
    (dired-header                      (:foreground gh-blue-br :weight 'bold))
    (dired-symlink                     (:foreground gh-blue-lt))
    (dired-mark                        (:foreground gh-orange))
    (dired-marked                      (:foreground gh-orange :weight 'bold))
    (dired-flagged                     (:foreground gh-orange-dk :weight 'bold))
    (dired-ignored                     (:foreground gh-fg-dim))
    (treemacs-root-face                (:foreground gh-purple :weight 'bold))
    (treemacs-directory-face           (:foreground gh-purple))
    (treemacs-file-face                (:foreground gh-fg))
    (treemacs-git-added-face           (:foreground gh-blue-br))
    (treemacs-git-modified-face        (:foreground gh-yellow))
    (treemacs-git-renamed-face         (:foreground gh-purple))
    (treemacs-git-ignored-face         (:foreground gh-fg-dim))
    (treemacs-git-untracked-face       (:foreground gh-blue-br))
    (treemacs-git-conflict-face        (:foreground gh-orange-dk :weight 'bold))

    ;; ── Directory / title / messages ─────────────────────────────────
    (dired-broken-symlink              (:foreground gh-orange-dk :weight 'bold))
    (info-title-1                      (:foreground gh-blue-br :weight 'bold))
    (info-menu-star                    (:foreground gh-orange))

    ;; ── org-mode ──────────────────────────────────────────────────────
    (org-level-1                       (:foreground gh-blue-br :weight 'bold :height 1.3))
    (org-level-2                       (:foreground gh-purple :weight 'bold :height 1.15))
    (org-level-3                       (:foreground gh-orange-lt :weight 'bold :height 1.05))
    (org-level-4                       (:foreground gh-blue))
    (org-level-5                       (:foreground gh-blue-lt))
    (org-level-6                       (:foreground gh-orange))
    (org-level-7                       (:foreground gh-yellow))
    (org-level-8                       (:foreground gh-fg))
    (org-document-title                (:foreground gh-blue-br :weight 'bold :height 1.4))
    (org-document-info                 (:foreground gh-fg-dim))
    (org-headline-done                 (:foreground gh-fg-dim :strike-through t))
    (org-todo                          (:foreground gh-orange-dk :weight 'bold))
    (org-done                          (:foreground gh-blue-br :weight 'bold))
    (org-checkbox                      (:foreground gh-orange))
    (org-code                          (:foreground gh-blue-lt :background gh-bg-hl2))
    (org-verbatim                      (:foreground gh-blue-lt))
    (org-block                         (:background gh-bg-hl2 :extend t))
    (org-block-begin-line              (:foreground gh-fg-dim :background gh-bg-hl2 :extend t))
    (org-block-end-line                (:foreground gh-fg-dim :background gh-bg-hl2 :extend t))
    (org-table                         (:foreground gh-blue))
    (org-link                          (:foreground gh-blue-br :underline t))
    (org-date                          (:foreground gh-blue :underline t))
    (org-tag                           (:foreground gh-fg-dim))
    (org-special-keyword               (:foreground gh-orange))
    (org-drawer                        (:foreground gh-fg-dim))
    (org-meta-line                     (:foreground gh-fg-dim :slant 'italic))
    (org-ellipsis                      (:foreground gh-fg-dim :underline nil))
    (org-quote                         (:foreground gh-fg-dim :slant 'italic :background gh-bg-hl2 :extend t))
    (org-agenda-date                   (:foreground gh-blue-br))
    (org-agenda-date-today             (:foreground gh-blue-br :weight 'bold))
    (org-agenda-structure              (:foreground gh-purple :weight 'bold))
    (org-scheduled                     (:foreground gh-blue))
    (org-scheduled-today               (:foreground gh-blue-br))
    (org-warning                       (:foreground gh-orange-dk :weight 'bold))

    ;; ── markdown ──────────────────────────────────────────────────────
    (markdown-header-face-1            (:foreground gh-blue-br :weight 'bold :height 1.3))
    (markdown-header-face-2            (:foreground gh-purple :weight 'bold :height 1.15))
    (markdown-header-face-3            (:foreground gh-orange-lt :weight 'bold))
    (markdown-header-face-4            (:foreground gh-blue))
    (markdown-bold-face               (:foreground gh-fg :weight 'bold))
    (markdown-italic-face             (:foreground gh-fg :slant 'italic))
    (markdown-link-face              (:foreground gh-blue-br :underline t))
    (markdown-url-face              (:foreground gh-blue-lt))
    (markdown-code-face            (:foreground gh-blue-lt :background gh-bg-hl2 :extend t))
    (markdown-inline-code-face   (:foreground gh-blue-lt :background gh-bg-hl2))
    (markdown-pre-face          (:foreground gh-blue-lt))
    (markdown-list-face         (:foreground gh-orange))
    (markdown-blockquote-face   (:foreground gh-fg-dim :slant 'italic))

    ;; ── doom-modeline (subset) ────────────────────────────────────────
    (doom-modeline-buffer-modified     (:foreground gh-orange-dk :weight 'bold))
    (doom-modeline-buffer-path         (:foreground gh-fg-dim))
    (doom-modeline-buffer-file         (:foreground gh-fg :weight 'bold))
    (doom-modeline-project-dir         (:foreground gh-purple :weight 'bold))
    (doom-modeline-info                (:foreground gh-blue-br))
    (doom-modeline-warning             (:foreground gh-yellow))
    (doom-modeline-urgent              (:foreground gh-orange-dk))
    (doom-modeline-bar                 (:background gh-blue-br))
    (doom-modeline-bar-inactive        (:background gh-border))
    (doom-modeline-evil-normal-state   (:foreground gh-blue-br :weight 'bold))
    (doom-modeline-evil-insert-state   (:foreground gh-blue :weight 'bold))
    (doom-modeline-evil-visual-state   (:foreground gh-purple :weight 'bold))
    (doom-modeline-evil-replace-state  (:foreground gh-orange-dk :weight 'bold))
    (doom-modeline-evil-operator-state (:foreground gh-orange :weight 'bold))
    (doom-modeline-evil-motion-state   (:foreground gh-blue-lt :weight 'bold))
    (doom-modeline-evil-emacs-state    (:foreground gh-yellow :weight 'bold))

    ;; ── Terminal / ansi colors ────────────────────────────────────────
    (ansi-color-black                  (:foreground gh-bg :background gh-bg))
    (ansi-color-red                    (:foreground gh-orange-dk :background gh-orange-dk))
    (ansi-color-green                  (:foreground gh-blue-br :background gh-blue-br))
    (ansi-color-yellow                 (:foreground gh-yellow :background gh-yellow))
    (ansi-color-blue                   (:foreground gh-blue :background gh-blue))
    (ansi-color-magenta                (:foreground gh-purple :background gh-purple))
    (ansi-color-cyan                   (:foreground gh-blue-lt :background gh-blue-lt))
    (ansi-color-white                  (:foreground gh-fg :background gh-fg))

    ;; ── misc ──────────────────────────────────────────────────────────
    (tab-bar-tab-group-current         (:foreground gh-blue-br :weight 'bold))
    (highlight-numbers-number          (:foreground gh-blue))
    (highlight-quoted-symbol           (:foreground gh-blue-lt))
    (highlight-quoted-quote            (:foreground gh-orange))
    (highlight-indent-guides-character-face (:foreground gh-border))
    (highlight-indent-guides-top-character-face (:foreground gh-gray))
    (whitespace-tab                    (:foreground gh-bg-hl2))
    (whitespace-space                  (:foreground gh-bg-hl2))
    (whitespace-trailing               (:background gh-orange-dk))
    (whitespace-line                   (:background gh-bg-hl2))
    (evil-ex-substitute-replacement    (:foreground gh-blue-br :strike-through nil))
    (evil-ex-substitute-matches        (:background gh-search :foreground gh-fg))
    (evil-ex-lazy-highlight            (:background gh-search :foreground gh-fg))
    (pulse-highlight-start-face        (:background gh-sel))
    (next-error                        (:inherit 'region))
    (Info-quoted                       (:foreground gh-blue-lt))
    (widget-field                      (:background gh-bg-hl2 :foreground gh-fg))
    (custom-state                      (:foreground gh-blue-br))
    (custom-changed                    (:foreground gh-yellow))
    (custom-invalid                    (:foreground gh-orange-dk :weight 'bold)))

 ;; ── Set a few faces / vars not exposed by the spec ──────────────────
 (custom-theme-set-variables
  'github-dark-colorblind
  '(ansi-color-names-vector
    ["#0d1117" "#d47616" "#58a6ff" "#d29922"
     "#79c0ff" "#d2a8ff" "#a5d6ff" "#c9d1d9"])))

(provide-theme 'github-dark-colorblind)

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide 'github-dark-colorblind-theme)
;;; github-dark-colorblind-theme.el ends here

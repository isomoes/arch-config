;;; early-init.el --- Pre-init UI and startup tuning -*- lexical-binding: t; -*-

;; Loaded before package.el and before the first frame is drawn (Emacs 27+).
;; Keep this tiny: only things that must happen early belong here.

;;; Code:

;; Raise the GC threshold during startup so init does fewer collections, then
;; drop it back to a sane runtime value once we're up. Cuts startup time.
(setq gc-cons-threshold (* 64 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; We call `package-initialize' ourselves in init.el; don't do it twice.
(setq package-enable-at-startup nil)

;; First launch async-native-compiles every freshly installed package. Some
;; packages (notably general.el) emit cosmetic "not known to be defined"
;; warnings during that compile — they're harmless. Keep them in the log
;; buffer instead of popping up *Warnings* on every startup.
(setq native-comp-async-report-warnings-errors 'silent)

;; Safety net: Emacs prefers the legacy ~/.emacs.d / ~/.emacs over this XDG dir.
;; If one of those ever reappears it would silently shadow this whole config, so
;; warn loudly if we're not actually loading from ~/.config/emacs.
(unless (string-suffix-p "/.config/emacs/" user-emacs-directory)
  (warn "Emacs is NOT loading ~/.config/emacs (user-emacs-directory=%s) — check for a stray ~/.emacs.d or ~/.emacs"
        user-emacs-directory))

;; Strip UI chrome before the first frame paints (avoids a visible flicker).
;; Setting these via `default-frame-alist' is cleaner than calling the *-mode
;; functions and works for every new frame, including the daemon's.
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Don't let GUI elements / font changes implicitly resize the frame.
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; Quieter, faster startup.
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name
      initial-scratch-message nil
      package-quickstart nil)

(provide 'early-init)
;;; early-init.el ends here

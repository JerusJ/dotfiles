;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;
;;
(setq user-full-name "Jesse Rusak"
      user-mail-address "rusak.jesse@gmail.com")

;; Fonts
(cond
  ((string-equal system-type "gnu/linux")
        (setq doom-font (font-spec :family "3270Medium Nerd Font" :size 34 :weight 'normal)
                doom-variable-pitch-font (font-spec :family "3270Medium Nerd Font" :size 34))))
(cond
  ((string-equal system-type "darwin")
        (setq doom-font (font-spec :family "M+ 2m" :size 16 :weight 'normal)
                doom-variable-pitch-font (font-spec :family "M+ 2m" :size 16))))
(cond
  ((string-equal system-type "windows-nt")
        (setq doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'normal)
              doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20))))

;; line-spacing is a buffer-local variable, so we'll need to use 'setq-default'
;; (setq-default line-spacing 0.5)

(setq doom-theme 'doom-material-dark)

;; Big performance decrease with line numbers :(
;; (setq display-line-numbers-type nil)

;; Org
(setq org-directory "~/org/")
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-file-type 'weekly)
(require 'ox-confluence)

;; Syntax Highlighting
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\*.hcl\'" . hcl-mode))

;; Mac Rebindings
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(setq vterm-shell "/usr/local/bin/zsh")

;; Forge Configuration for Private VCS

;; Deft
(setq deft-directory "~/notes"
      deft-extensions '("org")
      deft-rerusive t)

;; Company
;; Inspiration: https://github.com/iocanel/dotfiles/blob/master/.config/emacs/config.org
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay 10)                         ; increase delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-tooltip-align-annotations t)           ; aligns annotation to the right hand side
(setq company-dabbrev-downcase nil)                  ; don't downcase)

;; Projectile
(setq projectile-project-search-path '(("~/code" . 5)))

;; Python
(setq py-python-command "python3")
;; (setq lsp-pyright-typechecking-mode "strict")

;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Tramp
;; Make tramp not horrifically slow with dired
;; See: https://github.com/seagle0128/doom-modeline/issues/32#issuecomment-427622373
;; NOTE: you will also need SSH config (to not log in EVERY single time for dired buffer changes),
;; see: https://github.com/doomemacs/doomemacs/issues/3909#issuecomment-786596887
(after! tramp
  (setq tramp-inline-compress-start-size 1000)
  (setq tramp-copy-size-limit 10000)
  (setq vc-handled-backends '(Git))
  (setq tramp-verbose 1)
  (setq tramp-default-method "scp")
  (setq tramp-use-ssh-controlmaster-options nil)
  (setq projectile--mode-line "Projectile")
  (setq tramp-verbose 1))

(defun my-cache-project-root (orig-fn &rest args)
  (if (local-variable-p 'my-project-root)
      my-project-root
    (setq-local my-project-root (apply orig-fn args))))
(advice-add 'doom-modeline-project-root :around #'my-cache-project-root)

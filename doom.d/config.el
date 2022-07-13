;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
;;
(setq user-full-name "Jesse Rusak"
      user-mail-address "rusak.jesse@gmail.com")

;; Fonts
(cond
  ((string-equal system-type "gnu/linux")
        (setq doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'semibold)
                doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20))))
(cond
  ((string-equal system-type "darwin")
        (setq doom-font (font-spec :family "Source Code Pro" :size 18 :weight 'normal)
                doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 18))))
(cond
  ((string-equal system-type "windows-nt")
        (setq doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'normal)
              doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20))))

;; line-spacing is a buffer-local variable, so we'll need to use 'setq-default'
;; (setq-default line-spacing 0.5)
;; (setq-default cursor-type 'right-edge)

(setq doom-theme 'doom-gruvbox)

;; Big performance decrease with line numbers :(
(setq display-line-numbers-type nil)

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
(with-eval-after-load 'forge
  (push '("gitlab.ad.catalogic.us" "gitlab.ad.catalogic.us/api/v4" "gitlab.ad.catalogic.us" forge-gitlab-repository) forge-alist))

;; Deft
(setq deft-directory "~/org"
      deft-extensions '("org")
      deft-rerusive t)

;; Org-Jira
(setq jiralib-url "https://jira.catalogicsoftware.com")

;; Company
;; Inspiration: https://github.com/iocanel/dotfiles/blob/master/.config/emacs/config.org
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay 0)                          ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-tooltip-align-annotations t)           ; aligns annotation to the right hand side
(setq company-dabbrev-downcase nil)                  ; don't downcase)

;; Projectile
(setq projectile-project-search-path '(("~/code" . 5)))

;; Python
(setq py-python-command "python3")
;; (setq lsp-pyright-typechecking-mode "strict")


;;
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Kubernetes
(use-package kubernetes
  :defer
  :commands (kubernetes-overview))
;; (use-package kubernetes-evil
;;   :defer
;;   :after kubernetes)
(setq kubernetes-poll-frequency 3600
      kubernetes-redraw-frequency 3600)
(map! :leader
      (:prefix "o"
        :desc "Kubernetes" "K" 'kubernetes-overview))

;; Tramp
;; Make tramp not horrifically slow with dired
;; See: https://github.com/hlissner/doom-emacs/issues/3909#issuecomment-786596887
;; See: https://github.com/seagle0128/doom-modeline/issues/32#issuecomment-427622373
(defun my-cache-project-root (orig-fn &rest args)
  (if (local-variable-p 'my-project-root)
      my-project-root
    (setq-local my-project-root (apply orig-fn args))))
(advice-add 'doom-modeline-project-root :around #'my-cache-project-root)

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

(setq user-full-name "Jesse Rusak"
      user-mail-address "rusak.jesse@gmail.com")

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-frame-parameter nil 'undecorated t)

;; Big monitor
;; always split vertically for big monitor
(setq split-width-threshold 0)
(setq split-height-threshold nil)
(set-popup-rules! '(("*compilation*" :side right :size 0.50 :select t :quit nil)))

;; Fonts
(cond
  ((string-equal system-type "gnu/linux")
        (setq doom-font (font-spec :family "DroidSansM Nerd Font" :size 17 :weight 'normal)
                doom-variable-pitch-font (font-spec :family "DroidSansM Nerd Font" :size 17))))
(cond
  ((string-equal system-type "darwin")
        (setq doom-font (font-spec :family "Dank Mono" :size 17 :weight 'normal)
                doom-variable-pitch-font (font-spec :family "Dank Mono" :size 17))))
(cond
  ((string-equal system-type "windows-nt")
        (setq doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'normal)
              doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20))))

(setq doom-theme 'doom-gruvbox)

;; Big performance decrease with line numbers :(
;; (setq display-line-numbers-type nil)
(setq display-line-numbers 'relative)

;; Org
(setq org-directory "~/org/")
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-file-type 'weekly)

;; Syntax Highlighting
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\hcl\'" . terraform-mode))

;; Mac Rebindings
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; Company
;; I want this: https://stackoverflow.com/questions/64466550/auto-insert-and-cycle-through-completions-in-emacs-company-mode
;; =====================================================================
(setq company-idle-delay nil              ; Disable auto completion
      company-tooltip-limit 0             ; No tooltips
      company-echo-delay 0                ; No delay
      company-dabbrev-downcase nil        ; Don't downcase completions
      company-require-match 'never        ; Don't require match, allowing free typing
      company-frontends nil)              ; Disable all frontends for no pop-ups

(defun my-cycle-through-completions ()
  "Insert the selected candidate or the first if none are selected."
  (interactive)
  (if company-selection
      (company-complete-selection)
    (company-complete-number 1)))

(global-set-key (kbd "TAB") 'my-cycle-through-completions)
;; =====================================================================

;; Projectile
(setq projectile-project-search-path '(("~/code" . 3)))

;; Python
;; (setq lsp-pyright-typechecking-mode "strict")
(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))

(setq dap-python-debugger 'debugpy)

;; Rust
;; Sometimes this defaults to RLS, which we do not want, ever.
(setq lsp-rust-server 'rust-analyzer)
(setq rustic-lsp-server 'rust-analyzer)

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

;; Mode line
(setq doom-modeline-height 0)
(setq doom-modeline-bar-width 0)

;; https://gist.github.com/stammw/803e23b4e13c82373127ebe7fa161228
;; Always compile from project root, and save all files
(defun save-all-and-compile ()
  "Automate compile workflow."
  (interactive)
  (save-some-buffers 1)
  (if (get-buffer-process "*compilation*")
      (kill-compilation))
  (projectile-compile-project 'projectile-project-compilation-cmd))
(defun save-all-and-recompile ()
  "Automate compile workflow."
  (interactive)
  (save-some-buffers 1)
  (if (get-buffer-process "*compilation*")
      (kill-compilation))
  (recompile))


;; Keybindings
(map!
        :m "<f6>" #'save-all-and-compile
        :m "<f5>" #'save-all-and-recompile
)

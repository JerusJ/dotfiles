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

(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo")
      auth-source-cache-expiry nil) ; default is 7200 (2h)

;; ===============================
;; Theming
;; ===============================
(setq doom-modeline-height 0)
(setq doom-modeline-bar-width 0)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Big monitor
;; always split vertically for big monitor
(setq split-width-threshold 0)
(setq split-height-threshold nil)
(set-popup-rules! '(("*compilation*" :side right :size 0.50 :select t :quit nil)))

;; Fonts
(cond
 ((string-equal system-type "gnu/linux")
  (setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 22 :weight 'normal)
        doom-variable-pitch-font (font-spec :family "IosevkaTerm Nerd Font" :size 22))))
(cond
 ((string-equal system-type "darwin")
  (setq doom-font (font-spec :family "Monaco" :size 17 :weight 'normal)
        doom-variable-pitch-font (font-spec :family "Monaco" :size 17))))
(cond
 ((string-equal system-type "windows-nt")
  (setq doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'normal)
        doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20))))

(setq doom-theme 'doom-gruvbox)

;; Big performance decrease with line numbers :(
;; (setq display-line-numbers-type nil)
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

;;
(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to lose work, I certainly don't
      show-paren-mode t                           ; Show the matching parenthesis - something is disabling to being explicit
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      ;; scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2)

;; Like tmux rotate layout
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)

;; ===============================
;; Org
;; ===============================
(setq org-directory "~/vaults/vaults-work")
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-file-type 'weekly)
(use-package! org
  :mode ("\\.org\\'" . org-mode)
  :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

;; ===============================
;; Syntax Highlighting
;; ===============================
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\hcl\'" . terraform-mode))
(add-to-list 'auto-mode-alist '("\\Tiltfile\'" . bazel-starlark-mode))
(add-to-list 'auto-mode-alist '("\\jsonnet\'" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\pem\'" . x509-mode))
(add-to-list 'auto-mode-alist '("\\key\'" . x509-mode))
(add-to-list 'auto-mode-alist '("\\crt\'" . x509-mode))
(add-to-list 'auto-mode-alist '("\\cert\'" . x509-mode))
(add-to-list 'auto-mode-alist '("\\ca\'" . x509-mode))

;; ===============================
;; Modifiers
;; ===============================
(setq x-super-keysym 'meta) ;; For I3/AwesomeWM to avoid accidental hits
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; ===============================
;; Projectile
;; ===============================
(setq projectile-project-search-path '(("~/code" . 3)))
(projectile-add-known-project "~/dotfiles")
(projectile-add-known-project "~/org")

(defun my-proj-relative-buf-name ()
  (ignore-errors
    (rename-buffer
     (file-relative-name buffer-file-name (projectile-project-root)))))

(add-hook 'find-file-hook #'my-proj-relative-buf-name)

;; Python
;; (setq lsp-pyright-typechecking-mode "strict")
(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))

(setq dap-python-debugger 'debugpy)

(setq jsonnet-command 'tk)

;; ===============================
;; Rust
;; ===============================
;; Sometimes this defaults to RLS, which we do not want, ever.
(setq lsp-rust-server 'rust-analyzer)
(setq rustic-lsp-server 'rust-analyzer)

;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; ===============================
;; Tramp
;; ===============================
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

;; ===============================
;; Kubernetes
;; ===============================
(setq k8s-site-docs-url "https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/")
(setq k8s-site-docs-version "v1.27")

;; ===============================
;; Compilation
;; ===============================
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

(map!
 :m "<f6>" #'save-all-and-compile
 :m "<f5>" #'save-all-and-recompile
 )

(use-package! jsonnet-mode
  :mode "\\.jsonnet\\'"
  :defer t
  :config
  ;; Electric indentation triggers
  (set-electric! 'jsonnet-mode :chars '(?\n ?: ?{ ?}))
  ;; Use Tanka’s CLI for evaluation
  (setq jsonnet-command "tk")
  (setq jsonnet-command-options '("show", "."))
  ;; Point to your kubernetes/ root for imports
  (setq jsonnet-library-search-directories '("kubernetes/"))
  ;; Enable SMIE-based indentation
  (setq jsonnet-use-smie t))

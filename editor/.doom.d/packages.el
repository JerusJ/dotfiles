;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Additional Syntax
(package! systemd)

;; Documentation
;; Org
(package! toc-org)

;; PDF
(package! pdf-tools)

;; Markdown
;; NOTE: this should be a part of :lang markdown but
;; it's not being installed, so we'll do it implicitly.
(package! markdown-toc)

;; Latex
(package! lsp-latex)

;; Ruby
(package! rbenv)

;; Go
(package! go-dlv)

;; Vagrant
(package! vagrant)
(package! vagrant-tramp)

;; Misc
(package! salt-mode)
(package! json-navigator)

;; Kubernetes
(package! k8s-mode)

;; Bazel
(package! bazel)

;; Jsonnet
(package! jsonnet-mode)

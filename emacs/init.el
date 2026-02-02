(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(indent-tabs-mode nil)
 ;;'(js-indent-level 2)
 '(org-agenda-files '("~/notes/tasks.org"))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Org mode stuff
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-agenda-include-diary t)

;; package manager
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(use-package vertico
  :ensure
  :init (vertico-mode))

(use-package orderless
  :ensure
  :custom
  (completion-styles '(orderless basic)))

(use-package consult
  :ensure
  :bind (("C-c f" . consult-fd)))

(use-package markdown-mode
  :mode "\\.md\\'")

;; Javascript and Typescript
(use-package typescript-mode
  :ensure
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))

(use-package js-mode
  :mode "\\.js\\'"
  :config
  (setq js-basic-offset 2))

(use-package js-jsx-mode
  :mode "\\.js\\'"
  :config
  (setq js-basic-offset 2))

;; (use-package js2-mode
;;   :ensure
;;   :mode "\\.js\\'"
;;   :config
;;   (setq js2-basic-offset 2))

(use-package lsp-mode
  :ensure t
  :hook ((typescript-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         (js-mode . lsp-deferred))
  :commands lsp-deferred
  :bind ((:map lsp-mode-map
               ("C-c r" . lsp-rename)
               ("C-c a" . lsp-execute-code-action)
               ("C-c d" . lsp-find-definition)
               ("C-c i" . lsp-find-implementation)))
  :config
  (setq lsp-headerline-breadcrumb-enable nil))

(use-package apheleia
  :ensure t
  :config
    (setf (alist-get 'prettier-json apheleia-formatters)
      '("prettier" "--stdin-filepath" filepath))
  )

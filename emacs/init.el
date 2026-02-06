
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(package-selected-packages
   '(elfeed-org elfeed vertico typescript-mode orderless magit lsp-mode consult apheleia)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Org mode stuff
(setq org-agenda-include-diary t)
(setq org-directory "~/notes")
(setq org-default-notes-file (concat org-directory "/2026-DevJournal.org"))
(setq org-agenda-files (list (concat org-directory "/2026-DevJournal.org") (concat org-directory "/tasks.org")))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; package manager
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;; for GUI
(global-unset-key (kbd "C-z"))

;; vertico, orderless, and consult are supposedly combinging to make my
;; fuzzy search kinda work
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

;; Programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Javascript and Typescript
(use-package typescript-mode
  :ensure
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))

(use-package js-mode
  :mode "\\.js\\'"
  :config
  (setq js-indent-level 2))

(use-package js-jsx-mode
  :mode "\\.js\\'"
  :config
  (setq js-indent-level 2))

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

(use-package elfeed
  :ensure t)

(use-package elfeed-org
  :ensure t
  :after elfeed
  :custom
  (rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))

(with-eval-after-load 'elfeed
  (elfeed-org))

;; My keybinds

;; Looks like org-mode pollutes the C-c namespace with a
;; bunch of bindings so I'm making myself a prefix of
;; C-c M-j...
(global-set-key (kbd "C-c M-j r") 'elfeed)

;; Setting some registers
(set-register ?e (cons 'file "~/projects/dotfiles/emacs/init.el"))
(set-register ?t (cons 'file "~/notes/tasks.org"))

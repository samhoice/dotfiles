
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(org-agenda-files
   '("~/notes/tasks.org" "/home/jon/notes/2026-DevJournal.org"))
 '(package-selected-packages '(helm magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Org mode stuff
(setq org-directory "~/notes")
(setq org-default-notes-file (concat org-directory "/2026-DevJournal.org"))
(setq org-agenda-include-diary t)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; package manager
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;; for GUI
(global-unset-key (kbd "C-z"))

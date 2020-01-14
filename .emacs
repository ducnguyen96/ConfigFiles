;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))


;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    ;;    material-theme                  ;; Theme
    doom-themes			    ;; Doom Themes
    elpy			    ;; Emacs Lisp Python Enviroment
    flycheck			    ;; Syntax checking
    py-autopep8			    ;; Run autopep8 on save
    blacken			    ;; Black formatting on save
    magit			    ;; Git integration
    crux			    ;; Collections of useful commands
    undo-tree			    ;; Undo Tree
    rainbow-delimiters
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" default)))
 '(package-selected-packages
   (quote
    (doom-themes material-theme better-defaults use-package ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally
(tool-bar-mode -1)
;; User-Defined init.el ends here

;; =================================== 
;; Useful packages                         
;; ===================================

;; crux
(use-package crux
	    :bind
	    ("C-c t" . crux-visit-term-buffer)
	    ("C-a" . crux-move-beginning-of-line)
)

;; undo-tree
(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-mode-lighter "")
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  :config (global-undo-tree-mode))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; theme
(use-package doom-themes
  :init (load-theme 'doom-one t)
  :config (doom-themes-org-config))

;; ===================================
;; Key Binding                  
;; ===================================
(global-set-key (kbd "C-x C-/") 'comment-line)
(global-set-key (kbd "C-x g") 'magit-status)

;; =================================== 
;; Development Setup
;; ===================================

;; Enable Flycheck
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

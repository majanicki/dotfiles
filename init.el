
;; Disable the menu bar
(menu-bar-mode -1)
(visual-line-mode 1)
;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bars
(scroll-bar-mode -1)
(blink-cursor-mode 1)
(electric-pair-mode 1)
(require 'dashboard)
(dashboard-setup-startup-hook)
(icomplete-mode t)
(show-paren-mode t)
(global-set-key (kbd "C-c C-r") 'compile)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-limit 5)
 '(company-tooltip-maximum-width 50)
 '(company-tooltip-width-grow-only t)

 '(font-lock-maximum-decoration t)
 '(ispell-dictionary nil)
 '(org-agenda-files
   '("~/Documents/studia/sem4/sem4-todo-list.org" "/home/maciej/Documents/pasje/germ/kursbuch.org" "/home/maciej/Documents/studia/sem4/eng/notes.org"))
 '(package-selected-packages '(fireplace org-drill doom-themes)))







(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(which-key-mode)
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-completion-show-detail nil)
  (setq lsp-completion-enable-additional-text-edit nil)
  :config
  (lsp-enable-which-key-integration t)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
	 (c++-mode . lsp)
        )
  :commands lsp)



(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
              ("<tab>" . company-indent-or-complete-common) )
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))



(use-package yasnippet
  :hook (company-mode . yas-minor-mode)
  )
(use-package lsp-ui
  :init
  :hook (lsp-mode . lsp-ui-mode))
(eval-after-load 'yasnippet
  '(progn
(define-key yas-keymap (kbd "M-n") 'yas-next-field-or-maybe-expand)
(define-key yas-keymap (kbd "M-p") 'yas-prev-field)))

(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
(setq org-hide-emphasis-markers t)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-zenburn 1)
  ;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

)



(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq dired-listing-switches "-lGh1v --group-directories-first")
(global-font-lock-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; Use variable width font faces in current buffer
(set-face-attribute 'default nil :font "Monospace" :height 110)
(defun my-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Sans" :height 130 ))
  (buffer-face-mode))


 

;(add-hook 'org-mode-hook 'my-buffer-face-mode-variable)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

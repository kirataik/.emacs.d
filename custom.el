;; hide menu bar:
(menu-bar-mode -1)

;; don't make any backup files.
(setq make-backup-files  nil)

;; .mjs file as js2-mode
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))

;; auto reload file:
(global-auto-revert-mode t)

;; ask before quiting
(setq confirm-kill-emacs 'y-or-n-p)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'zenburn t)
(load-theme 'monokai t)

;; open custom.el with C-x r j e
(set-register ?e (cons 'file "~/.emacs.d/custom.el"))

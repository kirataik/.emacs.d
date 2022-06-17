;; hide menu bar:
(menu-bar-mode -1)

;; no-tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; prevent emacs from splitting windows automatically
(setq split-height-threshold nil
      split-width-threshold nil)

;; column mode on
(setq column-number-mode t)

;; don't make any backup files.
(setq make-backup-files nil)

(setq-default show-trailing-whitespace t)

;; .mjs file as js2-mode
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))

;; auto reload file:
(global-auto-revert-mode t)

;; ask before quiting
(setq confirm-kill-emacs 'y-or-n-p)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)
;; (load-theme 'monokai t)

;; open custom.el with C-x r j e
(set-register ?e (cons 'file "~/.emacs.d/custom.el"))
(set-register ?1 (cons 'file "/mnt/github/taikochain/protocol/packages/rollup/hardhat.config.ts"))

;; remove trailing whitespaces when saving file.
(defun my-prog-nuke-trailing-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)

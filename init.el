
(let* ((minver "27.1"))
  (when (version< emacs-version minver)
    (error "Emacs v%s or higher is required" minver)))

(defconst my-emacs-d (file-name-as-directory (file-name-directory user-init-file))
  "Directory of emacs.d")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; package management ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; taken from: https://stackoverflow.com/a/10095853/2450347
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed
 'typescript-mode
 'solidity-mode
 'smartparens
 'yasnippet
 'yasnippet-snippets
 'popup
 'org-bullets
 'rust-mode
 ) ;  --> (nil...) if packages are already installed

;; activate installed packages
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; package configs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'smartparens-config)
(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'typescript-mode-hook #'smartparens-mode)
(add-hook 'solidity-mode-hook #'smartparens-mode)
(add-hook 'rust-mode-hook #'smartparens-mode)

;; yasnippet configs:
(require 'yasnippet)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; use popup menu for yas-choose-value
(require 'popup)
;; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)
(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))
(setq yas-prompt-functions
      '(yas-popup-isearch-prompt
	    yas-maybe-ido-prompt
	    yas-completing-prompt
	    yas-no-prompt))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; customize solidity-mode
(defun solidity-at-vsemi-p (&optional pos)
  (let ((rpos (or pos (point))))
    (save-excursion
      (goto-char rpos)
      (ignore-errors
        ;; Try to jump back to the word "struct", as if we're at the end of a
        ;; syntactically-correct struct. Struct body, struct name, the keyword "struct".
        (forward-sexp -3)
        (looking-at-p "\\bstruct\\b")))))

(add-hook 'solidity-mode-hook
          (lambda () (setq-local c-at-vsemi-p-fn 'solidity-at-vsemi-p)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; load custom.el ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load (concat my-emacs-d "custom.el") t nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; customized generated ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; automatically generated code
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-offsets-alist
   '((arglist-intro . +)
     (arglist-close . c-lineup-close-paren)))
 '(org-startup-folded 'show2levels)
 '(package-selected-packages
   '(rust-mode org-bullets popup yasnippet-snippets yasnippet smartparens typescript-mode solidity-mode))
 '(read-buffer-completion-ignore-case t)
 '(safe-local-variable-values
   '((eval when
           (require 'rainbow-mode nil t)
           (rainbow-mode 1))))
 '(warning-suppress-types '((comp))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)

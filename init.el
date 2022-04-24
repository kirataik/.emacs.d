
(let* ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Emacs v%s or higher is required" minver)))

(defconst my-emacs-d (file-name-as-directory (file-name-directory user-init-file))
  "Directory of emacs.d")

(load (concat my-emacs-d "custom.el") t nil)

;; package management:
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
 ) ;  --> (nil...) if packages are already installed

;; activate installed packages
(package-initialize)


;; automatically generated code
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(solidity-mode))
 '(safe-local-variable-values
   '((eval when
	   (require 'rainbow-mode nil t)
	   (rainbow-mode 1)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

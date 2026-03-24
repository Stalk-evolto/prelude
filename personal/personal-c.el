(defvar c-include-path
  (delete-dups (split-string (getenv "C_INCLUDE_PATH") ":"))
  "The system C programming include path.")

(defun setenv-ld-library-path ()
  "Set LD_LIBRARY_PATH value same LIBRARY_PATH."
  (interactive)
  (setenv "LD_LIBRARY_PATH" (getenv "LIBRARY_PATH")))
(add-hook 'c-mode-common-hook #'setenv-ld-library-path)

;; set gtags.
(autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(require 'hl-line)
(add-hook 'gtags-select-mode-hook
          (lambda ()
            (setq hl-line-face 'underline)
            (hl-line-mode 1)))
(add-hook 'c-mode-hook
          (lambda ()
            (gtags-mode 1)))
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

;; set semantic.
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-show-unmatched-syntax-mode 1)
(semantic-mode 1)
(add-hook 'c-mode-common-hook
          (lambda ()
            (dolist (include-path c-include-path)
              (semantic-add-system-include include-path))
            (setq semantic-c-dependency-system-include-path c-include-path)))
(define-key semantic-mode-map "\C-c,." #'semantic-ia-fast-jump)

;; set hs-minor for create hide.
(add-hook 'c-mode-common-hook 'hs-minor-mode)

(require 'company)
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers)
  (setq company-c-headers-path-system
        c-include-path))

(setq
 ;; use gdb-many-windows by default
 gdb-manoy-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(defvar c-include-path
  (delete-dups (split-string (getenv "C_INCLUDE_PATH") ":"))
  "The system C programming include path.")

;; set ggtags.
(use-package ggtags
  :ensure t
  :hook
  ((c-mode c++-mode java-mode asm-mode) . ggtags-mode)
  :config
  (setq imenu-create-index-function #'ggtags-build-imenu-index)
  ;; set eldoc for doc search.
  (setq-local eldoc-documentation-function #'ggtags-eldoc-function)
  :bind
  (("C-c g s" . ggtags-find-other-symbol)
   ("C-c g h" . ggtags-view-tag-history)
   ("C-c g r" . ggtags-find-reference)
   ("C-c g f" . ggtags-find-file)
   ("C-c g c" . ggtags-create-tags)
   ("C-c g u" . ggtags-update-tags)
   ("M-," . pop-tag-mark)))

;; set helm-gtags.
(use-package helm-gtags
  :config
  (setq
   helm-gtags-ignore-case t
   helm-gtags-auto-update t
   helm-gtags-use-input-at-cursor t
   helm-gtags-pulse-at-cursor t
   helm-gtags-prefix-key "\C-cg"
   helm-gtags-suggested-key-mapping t
   )
  :hook
  ((dired-mode eshell-mode c-mode c++-mode asm-mode) . helm-gtags-mode)

  :bind
  (("C-c g a" . helm-gtags-tags-in-this-function)
   ("C-j" . helm-gtags-select)
   ("M-." . helm-gtags-dwim)
   ("M-," . helm-gtags-pop-stack)
   ("C-c <" . helm-gtags-previous-history)
   ("C-c >" . helm-gtags-next-history)))

;; set semanic.
(require 'cc-mode)
(use-package semantic
  :ensure t
  :init
  (global-semanticdb-minor-mode t)
  (global-semantic-idle-schedule-mode t)
  (global-semantic-decoration-mode t)
  (global-semantic-highlight-func-mode t)
  (global-semantic-show-unmatched-syntax-mode t)
  (semantic-mode t)
  (semantic-add-system-include c-include-path))

;; set ede mode manage Automake.
(require 'ede)
(global-ede-mode t)

;; set hs-minor for create hide.
(add-hook 'c-mode-common-hook 'hs-minor-mode)

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

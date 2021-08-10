;; sources:
;; - https://lucidmanager.org/productivity/configure-emacs/

;; Define the init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; start up message
(setq inhibit-startup-message t
      initial-scratch-message "Welcome to Emacs"
      cursor-type 'bar
      initial-major-mode 'org-mode) ;; init to org-mode to take notes...

;; customize themes
(load-theme 'wheatgrass)

;; maximize screen height
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; font
;; (set-default-font "DejaVu Sans Mono-14")

;;
(setq column-number-mode t)
(setq-default fill-column 99)

;;
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;;
(show-paren-mode 1)

;; set the frame title format
(setq frame-title-format "emacs - %b")


;; indents 4 chars
(setq c-basic-offset 4)                  

;; and 4 char wide for TAB
(setq tab-width 4)          

;; And force use of spaces
(setq indent-tabs-mode nil)

;; Unset the CTRL+Z shortcut to avoid putting emacs as a background process
(global-unset-key (kbd "C-z"))



;; un/indent region
(global-unset-key "\C-x\i")
(global-set-key "\C-x\i" 'indent-region)

;; Modify controls
;; comment-region
(global-set-key "\C-x\>" 'comment-region)
(global-set-key "\C-x\<" "\C-u\M-x\comment-region")

;; goto-line
(global-unset-key "\C-x\g")
(global-set-key "\C-x\g" 'goto-line)
(global-set-key [(meta g)] 'goto-line)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-unset-key (kbd "<delete>"))
(global-set-key (kbd "<delete>") "\C-d")

(global-set-key [(meta v)] 'fill-region)

(global-unset-key [(meta k)])
(global-set-key [(meta k)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta r)])
(global-set-key [(meta r)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta s)])
(global-set-key [(meta s)] "\C-a\C-@\C-e\C-f\M-w")

(global-set-key [(meta :)]   'hippie-expand)
(global-set-key [(meta j)]   'hippie-expand)

;; Automatic indent after 'RET'
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

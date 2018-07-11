
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; el-get ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
   (with-current-buffer
       (url-retrieve-synchronously
        "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
     (end-of-buffer)
     (eval-print-last-sexp)))
      
;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; set local recipes
(setq
 el-get-sources
 '((:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (progn
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; now set our own packages
(setq
 my:el-get-packages
 '(
   auto-complete			; complete as you type with overlays
   color-theme		                ; nice looking emacs
   color-theme-tango                    ; check out color-theme-solarized
   el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   flycheck                             ;
   htmlize                              ; syntaxic coloration in html
   imenu-anywhere                       ; document trees (sections, classes...)
   markdown-mode                        ; markdown mode
   multiple-cursors                     ; multiple cursers
   ob-ipython                           ; execute python chunks within org-mode
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   yasnippet 				; powerful snippet mode
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   ))

(el-get 'sync
	(append (cl-mapcar #'(lambda (recipe) (cl-getf recipe :name))
			   el-get-sources)
		my:el-get-packages))

(ido-mode t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wheatgrass))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; customize themes
(load-theme 'wheatgrass)

;; make welcome screen inactive
(setq inhibit-splash-screen t)

;; maximize screen height
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; font
(set-default-font "DejaVu Sans Mono-14")

;;
(set-input-mode nil nil 1)

;; drop menu and tool bars
(menu-bar-mode -1)
(tool-bar-mode -1)

;;
(setq column-number-mode t)
(setq-default fill-column 79)

;;
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;;
(show-paren-mode 1)

;; set the frame title format
(setq frame-title-format "emac s - %b")

;; indents 4 chars
(setq c-basic-offset 4)                  

;; javascript
(setq js-indent-level 2)

;; and 4 char wide for TAB
(setq tab-width 4)          

;; And force use of spaces
(setq indent-tabs-mode nil)

;; Unset the CTRL+Z shortcut to avoid putting emacs as a background process
(global-unset-key (kbd "C-z"))

;; un/indent region
(global-unset-key "\C-x\i")
(global-set-key "\C-x\i" 'indent-region)

;; comment-region
(global-set-key "\C-x\>" 'comment-region)
(global-set-key "\C-x\<" "\C-u\M-x\comment-region")

(global-unset-key "\C-x\g")
(global-set-key "\C-x\g" 'goto-line)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-unset-key (kbd "<delete>"))
(global-set-key (kbd "<delete>") "\C-d")

(global-set-key [(meta g)] 'goto-line)

(global-set-key [(meta v)] 'fill-region)

(global-unset-key [(meta k)])
(global-set-key [(meta k)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta r)])
(global-set-key [(meta r)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta s)])
(global-set-key [(meta s)] "\C-a\C-@\C-e\C-f\M-w")

(global-set-key [(meta :)]   'hippie-expand)
(global-set-key [(meta j)]   'hippie-expand)

;; Dictionary setting
(setq ispell-personal-dictionary "~/.ispell-priv-fr")
(global-set-key "\C-c\C-a"   '(lambda () (interactive)
				(ispell-change-dictionary "american")
				(setq ispell-personal-dictionary "~/.ispell-priv-us")))
(global-set-key "\C-c\C-f"   '(lambda () (interactive)
				(ispell-change-dictionary "francais")
				(setq ispell-personal-dictionary "~/.ispell-priv-fr")))
(global-set-key "\C-c\C-y"   'flyspell-mode)

;;;;;;;;;;;;;
(require 'calendar)

;; Ediff configuration.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Saves the minibuffer history.
(setq savehist-additional-variables
      '(search ring regexp-search-ring kill-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
;; Saves the locations in the files.
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; In order to get a proper shell mode.
(add-hook 'shell-mode-hook
          'ansi-color-for-comint-mode-on)

;; Changing the case in a whole region is too dangerous, and it therefore
;; disabled.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Python ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Execute Python chunks within org-mode files
(require 'ob-ipython)
(org-babel-do-load-languages
     'org-babel-load-languages
     '((ipython . t)
       (sh . t)
       (sql . t)
          ))

;; org-babel
(setq org-confirm-babel-evaluate nil) ; don't prompt me to confirm everytime I
				      ; want to evaluate a block

(autoload 'python-mode "~/applications/emacs/python-mode" "Enter Python :-P mode." t)
(add-hook 'python-mode-hook 'turn-on-auto-fill)

(setq yas-triggers-in-field t)

(setq python-shell-interpreter "/usr/bin/python3")

(when (executable-find "ipython")
    (setq python-shell-interpreter "ipython3"))

;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; Automatic indent after 'RET'
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; New functions ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
       (line-beginning-position)
       (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n))))
;;  (previous-line 1))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active
      
 (let* (
        (deactivate-mark nil)
        (start (region-beginning))
        (end (region-end))
        (contents (buffer-substring
     start
    end)))
   (save-excursion
     (goto-char start)
     (insert contents))
   (goto-char end)
   (push-mark (+ end (- end start))))
      (error "Mark is not active. Region not duplicated."))
  )

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
       (line-beginning-position)
       (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active     
 (let* (
        (deactivate-mark nil)
        (start (region-beginning))
        (end (region-end))
        (contents (buffer-substring
     start
    end)))
   (save-excursion
     (goto-char end)
     (insert contents))
   (goto-char start)
   (push-mark end)
   (exchange-point-and-mark))
      (error "Mark is not active. Region not duplicated."))
  )

(global-set-key [(control x) up]                      'duplicate-line-backward)
(global-set-key [(control x) down]                    'duplicate-line-forward)
(global-set-key [(control x) right]                   'duplicate-region-forward)
(global-set-key [(control x) left]                    'duplicate-region-backward)

(defun zap-to-char (arg char)
  "Kill up to (but not including) ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "p\ncZap to char: ")
  (kill-region (point) (progn
                         (search-forward (char-to-string char) nil nil arg)
                         (goto-char (if (> arg 0) (1- (point)) (1+ (point))))
                         (point))))

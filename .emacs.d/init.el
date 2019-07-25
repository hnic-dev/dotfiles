;;; -*- lexical-binding: t -*-

(defun tangle-init ()
  "If the current buffer is 'init.org' the code-blocks are
tangled, and the tangled file is compiled."
  (when (equal (buffer-file-name)
               (expand-file-name (concat user-emacs-directory "init.org")))
    ;; Avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
      (org-babel-tangle)
      (byte-compile-file (concat user-emacs-directory "init.el")))))

(add-hook 'after-save-hook 'tangle-init)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                 (not (gnutls-available-p))))
    (proto (if no-ssl "http" "https")))
    ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

(setq use-package-always-ensure t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'material t)
(setq initial-frame-alist '((top . 50) (left . 100) (width . 145) (height . 50)))
(tool-bar-mode -1)

(setq show-paren-delay 0)
(show-paren-mode 1)

(global-visual-line-mode 1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq
  inhibit-startup-message t
  inhibit-startup-screen t
  echo-keystrokes 0.1
  initial-scratch-message nil
  initial-major-mode 'org-mode)

(visual-line-mode 1)
(scroll-bar-mode -1)
(delete-selection-mode 1)

(setq scroll-margin 1
   scroll-step 1
   scroll-conservatively 10000
   scroll-preserve-screen-position 1)

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(setq org-directory "~/org")

(eval-after-load 'org
  '(progn
    (add-to-list 'org-structure-template-alist '("el" "#+BEGIN_SRC emacs-lisp \n?\n#+END_SRC"))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (python . t)
   (scheme . t)
  ))

(add-hook 'scheme-mode-hook 'geiser-mode)
(setq geiser-default-implementation 'racket)

(use-package projectile
  :config
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "s-P") 'projectile-command-map)
  (projectile-mode +1))

(use-package helm-swoop)
(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (helm-autoresize-mode 1)
  (setq helm-follow-mode-persistent t)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-apropos-fuzzy-match t)
  (setq helm-split-window-inside-p t)
  ;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  ;; (global-set-key (kbd "s-b") 'helm-mini)
  ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
  ;; (global-set-key (kbd "s-f") 'helm-swoop)
  )
(setq helm-swoop-pre-input-function
      (lambda () ""))

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package helm-ag
  :config
  (global-set-key (kbd "s-F") 'helm-projectile-ag))

(global-set-key (kbd "s-p") 'helm-projectile-find-file)

;; Allow hash to be entered on UK mac keyboard
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; preferences
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq dired-use-ls-dired nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(tool-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil
    :family "Source Code Pro" :height 145 :weight 'normal)
(setq-default truncate-lines 1)

(setq c-basic-offset 4)
(setq tab-width 4)
(setq indent-tabs-mode nil)

;; full-screen
(defun toggle-fullscreen ()
    "Toggle full screen"
      (interactive)
        (set-frame-parameter
               nil 'fullscreen
                    (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(global-set-key (kbd "C-<return>") 'toggle-fullscreen)

;; MELPA package management
(require 'package)
(add-to-list 'package-archives
                          '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
      (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; local packages
(let ((default-directory "~/.emacs.d/github"))
  (let ((old-path (copy-sequence load-path))
                (new-load-path nil))
        (normal-top-level-add-to-load-path '("."))
        (normal-top-level-add-subdirs-to-load-path)
        (dolist (var load-path)
          (unless (memql var old-path)
                (add-to-list 'new-load-path var)
                (setq load-path (append new-load-path old-path))))))(add-to-list 'load-path "~/.emacs.d/")

;; install-elisp
;;(load "install-elisp.el")

;; install remote modules
;;(install-elisp "https://github.com/m2ym/popup-el/raw/master/popup.el")

;; evil
(require 'evil)
    (evil-mode 1)
(setq evil-shift-width 4)

;; evil tabs
(global-evil-tabs-mode t)

;; powerline
(require 'powerline)
(powerline-center-evil-theme)

;; omnisharp
(require 'omnisharp)
(setq omnisharp-company-do-template-completion t)

;; ido
(require 'ido)
(ido-mode t)

;; popup.el
(require 'popup)

;; company-mode
(require 'company)
(require 'csharp-mode)
(defun my-csharp-mode ()
    (add-to-list 'company-backends 'company-omnisharp)
      (omnisharp-mode)
        (company-mode)
          (flycheck-mode)
            (turn-on-eldoc-mode))

(add-hook 'csharp-mode-hook 'my-csharp-mode)
(add-hook 'emacs-lisp-mode 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq company-begin-commands '(self-insert-command))
(add-hook 'after-init-hook 'global-flycheck-mode)
  
(add-to-list 'company-backends 'company-omnisharp)
(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-omnisharp))

;; hl-line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#333")
(lexical-let ((default-color (cons (face-background 'mode-line)
                                        (face-foreground 'mode-line))))
    (add-hook 'post-command-hook
        (lambda ()
            (let ((color (cond ((minibufferp) default-color)
                ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                (t default-color))))
            (set-face-background 'mode-line (car color))
            (set-face-foreground 'mode-line (cdr color))))))

;; key-chord
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-one-key-delay 0.2)
(setq key-chord-two-keys-delay 0.15)

;; key maps
(key-chord-define evil-insert-state-map "jk"  'evil-normal-state) 
(key-chord-define evil-replace-state-map "jk"  'evil-normal-state) 
(key-chord-define evil-insert-state-map "kj"  'evil-normal-state) 
(key-chord-define evil-replace-state-map "kj"  'evil-normal-state) 
(key-chord-define global-map "fj" 'smex)
;; (key-chord-define evil-insert-state-map "
;; (define-key evil-insert-state-map (kbd "j k") 'evil-normal-state)

;; (define-key evil-insert-state-map (kbd "k j") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "<SPC> e") 'find-file)
(define-key evil-normal-state-map (kbd "<SPC> w") 'evil-write)

(define-key evil-normal-state-map (kbd "M-J") 'flycheck-next-error)
(define-key evil-normal-state-map (kbd "M-K") 'flycheck-previous-error)

(define-key evil-normal-state-map (kbd "<SPC> cc") 'comment-or-uncomment-region-or-line)
(define-key evil-visual-state-map (kbd "<SPC> cc") 'comment-or-uncomment-region-or-line)
(define-key evil-normal-state-map (kbd "<SPC> c <SPC>") 'comment-or-uncomment-region-or-line)
(define-key evil-visual-state-map (kbd "<SPC> c <SPC>") 'comment-or-uncomment-region-or-line)
(define-key evil-normal-state-map (kbd "<SPC> cn") 'next-error)
(define-key evil-normal-state-map (kbd "<SPC> cp") 'previous-error)
(define-key evil-insert-state-map (kbd "<RET>") 'newline-and-indent)

(define-key company-active-map (kbd "C-j") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-k") 'company-select-previous-or-abort)

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-frontends
   (quote
    (company-pseudo-tooltip-frontend company-echo-metadata-frontend)))
 '(company-idle-delay 0.03)
 '(company-minimum-prefix-length 1)
 '(company-show-numbers t)
 '(omnisharp-auto-complete-want-documentation nil)
 '(omnisharp-company-sort-results t)
 '(omnisharp-server-executable-path
   (quote ~/src/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp\.exe))
 '(custom-enabled-themes (quote (vivid-chalk)))
 '(custom-safe-themes (quote ("b7feeb278a5b7de0a7c8dfc35c95263fb562e0e7f654d34eac811027fb3e913e" default)))
 '(custom-theme-directory "~/.emacs.d/themes/"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "yellow")))))

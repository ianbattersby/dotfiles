;; OS X stuff
(set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)

;; MELPA package management
(require 'package)
(add-to-list 'package-archives
                          '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
      (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; install-elisp
;;(add-to-list 'load-path "~/.emacs.d/")
;;(load "install-elisp.el")

;; install remote modules
;;(install-elisp "https://github.com/m2ym/popup-el/raw/master/popup.el")

;; evil
(require 'evil)
    (evil-mode 1)
(setq evil-shift-width 4)

;; omnisharp
(setq omnisharp-server-executable-path "~/src/OmniSharpServer/OmniSharp/bin/Debug")
(add-hook 'csharp-mode-hook 'omnisharp-mode)

;; ido
(require 'ido)
    (ido-mode t)

;; popup.el
(require 'popup)

;; company-mode
(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-omnisharp))

;; preferences
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(set-face-attribute 'default nil
                                        :family "Source Code Pro" :height 145 :weight 'normal)
(setq-default truncate-lines 1)
(menu-bar-mode -1)

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (vivid-chalk)))
 '(custom-safe-themes (quote ("b7feeb278a5b7de0a7c8dfc35c95263fb562e0e7f654d34eac811027fb3e913e" default)))
 '(custom-theme-directory "~/.emacs.d/themes/"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

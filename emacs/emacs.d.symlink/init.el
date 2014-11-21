;; Allow hash to be entered on UK mac keyboard
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; preferences
(setq inhibit-splash-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq dired-use-ls-dired nil)

(show-paren-mode t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(tool-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil
    :family "Source Code Pro" :height 145 :weight 'normal)
;;    :family "Sauce Code Powerline" :height 185 :weight 'normal)

(setq-default truncate-lines 1)
(setq c-basic-offset 4)
(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq compilation-ask-about-save nil)

;; (set-frame-parameter (selected-frame) 'alpha '(85 50))
;; (add-to-list 'default-frame-alist '(alpha 85 50))

;; switch me some buffers
;;(defun switch-to-previous-buffer ()
;;    (interactive)
;;        (switch-to-buffer (other-buffer (current-buffer) 1)))

;;(global-set-key (kbd "C-\]") 'switch-to-previous-buffer)

;;(global-set-key (kbd "C-\[") 'next-multiframe-window)

;; full-screen
(defun toggle-fullscreen ()
    "Toggle full screen"
      (interactive)
        (set-frame-parameter
               nil 'fullscreen
                    (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(global-set-key (kbd "C-<return>") 'toggle-fullscreen)

;; esc quits
(defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
      (if (and delete-selection-mode transient-mark-mode mark-active)
              (setq deactivate-mark  t)
                  (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
                      (abort-recursive-edit)))
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

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
                (setq load-path (append new-load-path old-path))))))

;; install-elisp
;;(load "install-elisp.el")

;; install remote modules
;;(install-elisp "https://github.com/m2ym/popup-el/raw/master/popup.el")

;; helm
(require 'helm-config)
(require 'helm-command)
(require 'helm-elisp)
(require 'helm-misc)
(require 'helm-projectile)

(helm-projectile-on)

(global-set-key (kbd "C-x f") 'helm-for-files)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(add-to-list 'compilation-error-regexp-alist
                 '(" in \\(.+\\):\\([1-9][0-9]+\\)" 1 2))

;; flycheck
;;(add-hook 'evil-insert-state-exit-hook (lambda() (interactive) (flycheck-mode 1)))
;;(add-hook 'evil-normal-state-exit-hook (lambda() (interactive) (flycheck-mode -1)))

;; evil
(setq-default evil-shift-width 4)
(setq-default evil-auto-indent t)
(require 'evil)
    (evil-mode 1)

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
(define-key evil-normal-state-map (kbd "<SPC> a") 'helm-ag)
(define-key evil-normal-state-map (kbd "C-p") 'helm-mini)

(define-key evil-normal-state-map (kbd "<SPC> <SPC>") 'ace-jump-mode)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)

(mapc (lambda (mode) (evil-set-initial-state mode 'emacs))
    '(eshell-mode
        term-mode
    ))

;; evil tabs
(setq elscreen-display-tab nil)
(global-evil-tabs-mode t)

;; powerline
(require 'powerline)
(powerline-center-evil-theme)

;; omnisharp
(setq omnisharp-company-do-template-completion t)
(require 'omnisharp)

(evil-define-key 'normal omnisharp-mode-map (kbd "g d") 'omnisharp-go-to-definition)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> b") 'omnisharp-build-in-emacs)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> cf") 'omnisharp-code-format)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> nm") 'omnisharp-rename-interactively)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> fu") 'omnisharp-helm-find-usages)
(evil-define-key 'normal omnisharp-mode-map (kbd "<M-RET>") 'omnisharp-run-code-action-refactoring)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> ss") 'omnisharp-start-omnisharp-server)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> sp") 'omnisharp-stop-omnisharp-server)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> fi") 'omnisharp-find-implementations)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> x") 'omnisharp-fix-code-issue-at-point)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> fx") 'omnisharp-fix-usings)
(evil-define-key 'normal omnisharp-mode-map (kbd "<SPC> o") 'omnisharp-auto-complete-overrides)

(define-key evil-normal-state-map (kbd "<SPC> rt") (lambda() (interactive) (omnisharp-unit-test "single")))
(define-key evil-normal-state-map (kbd "<SPC> rf") (lambda() (interactive) (omnisharp-unit-test "fixture")))
(define-key evil-normal-state-map (kbd "<SPC> ra") (lambda() (interactive) (omnisharp-unit-test "all")))
(define-key evil-normal-state-map (kbd "<SPC> rl") 'recompile)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-f") 'helm-for-files)

;; popup.el
(require 'popup)

;; company-mode
(setq company-begin-commands '(self-insert-command))
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
(add-hook 'after-init-hook 'global-flycheck-mode)
  
(add-to-list 'company-backends 'company-omnisharp)
(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-omnisharp))

(define-key company-active-map (kbd "C-j") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-k") 'company-select-previous-or-abort)

(defun tab-indent-or-complete ()
    (interactive)
        (if (minibufferp)
            (minibuffer-complete)
        (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
        (indent-for-tab-command)))))

(define-key company-active-map (kbd "<tab>") 'tab-indent-or-complete)

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

;; linum-relative
(setq linum-relative-format " %3s ")
(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode)) (defun linum-on () (unless (or (minibufferp) (member major-mode linum-disabled-modes-list)) (linum-mode 1)))
(require 'linum-relative)

(define-key evil-normal-state-map (kbd "<SPC> li") 'linum-mode)

;; smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; key-chord
(setq key-chord-one-key-delay 0.2)
(setq key-chord-two-keys-delay 0.15)
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define evil-insert-state-map "jk"  'evil-normal-state) 
(key-chord-define evil-replace-state-map "jk"  'evil-normal-state) 
(key-chord-define evil-insert-state-map "kj"  'evil-normal-state) 
(key-chord-define evil-replace-state-map "kj"  'evil-normal-state) 
(key-chord-define global-map "fj" 'smex)
;; (key-chord-define evil-insert-state-map "
;; (define-key evil-insert-state-map (kbd "j k") 'evil-normal-state)

;; (define-key evil-insert-state-map (kbd "k j") 'evil-normal-state)

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(company-frontends
   (quote
    (company-pseudo-tooltip-frontend company-echo-metadata-frontend)))
 '(company-idle-delay 0.03)
 '(company-minimum-prefix-length 1)
 '(company-show-numbers t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (vivid-chalk)))
 '(custom-safe-themes
   (quote
    ("550b94fed60f498837896d9913e1f25f45300aa7bab202217908e3d3fcaf2117" "aa0cff9f0399a01e35a884bebe67039e3f8890dbe69ebaaa6e8d307dce50dfcd" "d856a69b420c5882358b33a7265f9f069f260cad44ca7ce0fa9b4228d65ee8f3" "05db4ea84692952a883a3ed1e3f82215163f73f41d53ffe8acdccf5b314ecb9f" "b7feeb278a5b7de0a7c8dfc35c95263fb562e0e7f654d34eac811027fb3e913e" default)))
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(fci-rule-color "#49483E")
 '(helm-ag-insert-at-point (quote word))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(omnisharp-auto-complete-want-documentation nil)
 '(omnisharp-company-sort-results t)
 '(omnisharp-server-executable-path
   (quote ~/src/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp\.exe))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "yellow")))))

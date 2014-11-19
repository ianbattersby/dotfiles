(deftheme vivid-chalk
  "A deftheme version of the old vivid-chalk theme back when color-theme was in")

(custom-theme-set-faces
 'vivid-chalk
 '(cursor ((((background light)) (:background "black")) (((background dark)) (:background "white"))))
 '(minibuffer-prompt ((t (:foreground "#ff6600" :weight bold))))
 '(highlight ((t (:background "#333"))))
 '(region ((t (:background "#557"))))
 '(secondary-selection ((t (:background "darkslateblue"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-builtin-face ((t (:foreground "#acf"))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#93c"))))
 '(font-lock-constant-face ((t (:foreground "#399"))))
 '(font-lock-doc-face ((t (:foreground "LightSalmon"))))
 '(font-lock-function-name-face ((t (:foreground "#fc0"))))
 '(font-lock-keyword-face ((t (:foreground "#f60"))))
 '(font-lock-preprocessor-face ((t (:foreground "#aff"))))
 '(font-lock-string-face ((t (:foreground "#6f0"))))
 '(font-lock-type-face ((t (:foreground "#aaa"))))
 '(font-lock-variable-name-face ((t (:foreground "#acf"))))
 '(font-lock-warning-face ((t (:background "red" :foreground "white" :weight bold))))
 '(fringe ((t (:background "black"))))
 '(mode-line ((t (:background "#a5baf1" :foreground "black"))))
 '(isearch ((t (:background "#555" :foreground "#77f"))))
 '(default ((t (:inherit nil :stipple nil :background nil :foreground "White" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "apple" :family "Ubuntu_Mono"))))
 '(bold ((t (:weight bold))))
 '(bold-italic ((t (:slant italic :weight bold))))
 '(italic ((((supports :slant italic)) (:slant italic)) (((supports :underline t)) (:underline t)) (t (:slant italic))))
 '(underline ((((supports :underline t)) (:underline t)) (((supports :weight bold)) (:weight bold)) (t (:underline t)))))

(provide-theme 'vivid-chalk)

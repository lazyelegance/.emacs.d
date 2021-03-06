;; Contains GUI settings and defuns

;; Good themes:

;; Dark variants:
;; avk-darkblue-white
;; heroku
;; busybee
;; doom
;; minimal (comes in light, great for writing)
;; sanityinc
;; darktooth
;; dracula
;; django *** (I like it, bit dark)
;; Lavender-theme *** (problem: highlight line looks ugly)
;; rebecca-theme ***
;; Reykjavik Theme *** (little flat with javascript)
;; * Subatomic Theme ***** current favorite. available in 256
;; purple haze (bit dark)
;; misteriso ***
;; soothe
;; tao
;; twilight?

;; Light:
;; Twilight Bright Theme

;; Get rid of ugly splash screen
(setq inhibit-startup-screen t)

;; Theming
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq custom-safe-themes t) ;; in case I want to use custom themes

;; Current appearance config
(use-package neotree)
(use-package subatomic256-theme)


;; Annoyingly have to use require
;; Looks better than neotree default
(use-package all-the-icons)
(when (display-graphic-p)
  (require 'doom-neotree))

(when (display-graphic-p)
  (use-package subatomic-theme))

(when (not (display-graphic-p))
  (use-package subatomic256-theme))


(use-package spaceline)
(require 'spaceline-config) ;; Have to use require here, annoying.
;; this doesn't look quite right, but it works
(spaceline-emacs-theme)

;; (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
(set-face-attribute 'mode-line nil :box nil)

(require 'all-the-icons)

;; adjust opacity
;; I like this, but I think it has a markedly negative effect on perf.
;; (set-frame-parameter (selected-frame) 'alpha '(99 90))
;; (add-to-list 'default-frame-alist '(alpha 100 90))

;; highlight line
(global-hl-line-mode 1)

;; Set alarm bell to visual warning
(setq visible-bell t)

;; disable superfluous gui
(menu-bar-mode -1)
(when (display-graphic-p)
  (toggle-scroll-bar -1))
(tool-bar-mode -1)
(blink-cursor-mode -1)

;; Other visual stuff
(global-linum-mode 1)
(setq indicate-empty-lines -1)

;; show line numbers dynamically with spaces
(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

;; Cooool. The snippet below flashes modeline for bell
(defvar doom--modeline-bg nil)

(setq ring-bell-function
      (lambda ()
        (unless doom--modeline-bg
          (setq doom--modeline-bg (face-attribute 'mode-line :background)))
        (set-face-attribute 'mode-line nil :background "#54252C")
        (run-with-timer
         0.1 nil
         (lambda () (set-face-attribute 'mode-line nil :background doom--modeline-bg)))))

;; Set font
(defun font-exists-p (font)
  "Check that a font exists."
  (if (member font (font-family-list))
      t
    nil))

(when (font-exists-p "SF Mono")
  (set-frame-font "SF Mono-13"))

(provide 'gui)

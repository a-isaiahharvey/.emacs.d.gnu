(require 'package)
(add-to-list 'package-archives
    '(("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")))
(package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-install 'use-package))
(setq use-package-always-ensure t)

(electric-pair-mode 1)

(blink-cursor-mode 1)

(when (member "Cascadia Code" (font-family-list))
  (set-frame-font "Cascadia Code"  t))

(defun set-font-size(size)
  "Calculates font size"
  (setq pt (* 10 size))
  (set-face-attribute 'default nil :height pt)
)

(set-font-size 12)

(use-package format-all
  :preface
  (defun ian/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (global-set-key (kbd "M-F") #'ian/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

(global-visual-line-mode t)

(delete-selection-mode 1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package real-auto-save)
(add-hook 'prog-mode-hook 'real-auto-save-mode)

(setq real-auto-save-interval 8) ;; in seconds

(use-package all-the-icons
:ensure t)

(package-install `atom-one-dark-theme)
(package-install `dracula-theme)
(package-install `nord-theme)

(use-package doom-themes
:ensure t
:config
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config))

(load-theme 'doom-tokyo-night t)

(menu-bar-mode 1)

(scroll-bar-mode 0)

(tool-bar-mode 0)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package which-key)
(which-key-mode 1)

(use-package toc-org)

(use-package neotree)

(global-set-key [f8] 'neotree-toggle)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(use-package lsp-mode
:ensure
:commands lsp
:custom
;; what to use when checking on-save. "check" is default, I prefer clippy
(lsp-rust-analyzer-cargo-watch-command "clippy")
(lsp-eldoc-render-all t)
(lsp-idle-delay 0.6)
;; enable / disable the hints as you prefer:
(lsp-rust-analyzer-server-display-inlay-hints t)
(lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
(lsp-rust-analyzer-display-chaining-hints t)
(lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
(lsp-rust-analyzer-display-closure-return-type-hints t)
(lsp-rust-analyzer-display-parameter-hints nil)
(lsp-rust-analyzer-display-reborrow-hints nil)
:config
(add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
:ensure
:commands lsp-ui-mode
:custom
(lsp-ui-peek-always-show t)
(lsp-ui-sideline-show-hover t)
(lsp-ui-doc-enable nil))

(use-package company
:ensure
:custom
(company-idle-delay 0.5) ;; how long to wait until popup
;; (company-begin-commands nil) ;; uncomment to disable popup
:bind
(:map company-active-map
	    ("C-n". company-select-next)
	    ("C-p". company-select-previous)
	    ("M-<". company-select-first)
	    ("M->". company-select-last)))

(use-package yasnippet
:ensure
:config
(yas-reload-all)
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'text-mode-hook 'yas-minor-mode))

(use-package doom-modeline
:ensure t
:hook (after-init . doom-modeline-mode))

(setq doom-modeline-support-imenu t)

(setq doom-modeline-height 25)

(setq doom-modeline-bar-width 4)

(setq doom-modeline-hud nil)

(setq doom-modeline-window-width-limit 0.25)

(setq doom-modeline-project-detection 'auto)

(setq doom-modeline-buffer-file-name-style 'auto)

(setq doom-modeline-icon t)

(setq doom-modeline-major-mode-icon t)

(setq doom-modeline-major-mode-color-icon t)

(setq doom-modeline-buffer-state-icon t)

(setq doom-modeline-buffer-modification-icon t)

(setq doom-modeline-unicode-fallback nil)

(setq doom-modeline-buffer-name t)

(setq doom-modeline-minor-modes nil)

(setq doom-modeline-enable-word-count nil)

(setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

(setq doom-modeline-buffer-encoding t)

(setq doom-modeline-indent-info nil)

(setq doom-modeline-checker-simple-format t)

(setq doom-modeline-number-limit 99)

(setq doom-modeline-vcs-max-length 12)

(setq doom-modeline-workspace-name t)

(setq doom-modeline-gnus-timer 2)

(setq doom-modeline-gnus-excluded-groups '("dummy.group"))

(setq doom-modeline-irc t)

(setq doom-modeline-irc-stylize 'identity)

(setq doom-modeline-env-version t)

(setq doom-modeline-env-enable-python t)
(setq doom-modeline-env-enable-ruby t)
(setq doom-modeline-env-enable-perl t)
(setq doom-modeline-env-enable-go t)
(setq doom-modeline-env-enable-elixir t)
(setq doom-modeline-env-enable-rust t)

(setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
(setq doom-modeline-env-rust-executable "rustc")

(setq doom-modeline-env-load-string "...")

(setq doom-modeline-before-update-env-hook nil)
(setq doom-modeline-after-update-env-hook nil)

(use-package tree-sitter-langs)

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rustic)

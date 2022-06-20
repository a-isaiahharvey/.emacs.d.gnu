(require 'package)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/"))
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

(package-install `atom-one-dark-theme)
(package-install `dracula-theme)
(package-install `nord-theme)

(load-theme 'dracula t)

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

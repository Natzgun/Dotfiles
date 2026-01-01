;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
                                        ; (setq doom-unicode-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 15)
                                        ;       doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14))
;; (setq doom-font (font-spec :family "Maple Mono NF" :weight 'Regular :size 17))
;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :weight 'SemiBold :size 11.5))
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :weight 'Semibold :size 18))

;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 12.5)
;;       doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-moonlight)
(setq doom-theme 'doom-horizon)
(add-to-list 'default-frame-alist '(alpha . 90))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Treesitter
;; (use-package tree-sitter-langs :ensure t)

;; (use-package tree-sitter
;;   :ensure t
;;   :after tree-sitter-langs
;;   :config
;;   (global-tree-sitter-mode)
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Delete autosave WorkSpaces
(setq +workspaces-autosave-when-idle nil)

;; INDENTATION

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Indentation for c and c++
(add-hook 'c-mode-hook
          (lambda ()
            (setq c-basic-offset 4)      ;; Indentación de 4 espacios
            (c-set-style "k&r")))       ;; Estilo Kernighan & Ritchie

;; Configuración para C++
(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-basic-offset 4)      ;; Indentación de 4 espacios
            (c-set-style "stroustrup"))) ;; Estilo Stroustrup

(after! lsp-mode
  (setq lsp-enable-on-type-formatting nil)  ;; Desactiva el formato en tiempo real
  (setq lsp-enable-indentation nil))        ;; Desactiva la indentación automática del LSP


;; (after! c-mode
;;   (setq c-basic-offset 2))

;; (after! cpp-mode
;;   (setq c-basic-offset 2))



;; Github Copilot
;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; Neotree Icons
;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(after! doom-themes
  (remove-hook 'doom-load-theme-hook #'doom-themes-neotree-config))
(setq doom-themes-neotree-file-icons t)
(setq doom-themes-neotree-enable-folder-icons t)
;; (setq doom-themes-neotree-dir-rules t)

;; (use-package all-the-icons :ensure t
;;   :if (display-graphic-p))

;; Treemacs
;; Open the(defun my/treemacs-display-current-project-exclusively ()
;; (setf treemacs-expand-after-init nil)
;; (defun my/treemacs-display-current-project-exclusively ()
;;   (treemacs-display-current-project-exclusively))
;; (add-hook 'find-file-hook #'my/treemacs-display-current-project-exclusively)
;; (after! treemacs
;;   (treemacs-project-follow-mode t))
(add-hook 'treemacs-mode-hook (lambda() (treemacs-project-follow-mode t)))

;; ORG ROAM
;; (setq org-directory "~/ORG/OrgNotes")
;; (setq org-agenda-files "~/ORG/OrgNotes")
(use-package! org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-include-todo t)
  :custom
  (org-roam-directory "~/ORG/RoamNotes")
  (org-roam-complete-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-c i" . completion-at-point)
         ("C-c n g" . org-roam-graph)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-enable))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))



;; WRITING FOCUS MODE DARKROOM
(use-package darkroom
  :commands darkroom-mode
  :config
  (setq darkroom-text-scale-increase 0))

(defun dw/enter-focus-mode ()
  (interactive)
  (darkroom-mode 1)
  (display-line-numbers-mode 0))

(defun dw/leave-focus-mode ()
  (interactive)
  (darkroom-mode 0)
  (display-line-numbers-mode 1))

(defun dw/toggle-focus-mode ()
  (interactive)
  (if (symbol-value darkroom-mode)
      (dw/leave-focus-mode)
    (dw/enter-focus-mode)))

;; (dw/leader-key-def
;;  "tf" '(dw/toggle-focus-mode :which-key "focus mode"))

;;Line Inactives " ~ "
;; (setq-default indicate-empty-lines nil)
(after! doom-modeline (setq indicate-empty-lines nil))

;; Org download for drag and drop images
;; (defun zz/org-download-paste-clipboard (&optional use-default-filename)
;;   (interactive "P")
;;   (require 'org-download)
;;   (let ((file
;;          (if (not use-default-filename)
;;              (read-string (format "Filename [%s]: "
;;                                   org-download-screenshot-basename)
;;                           nil nil org-download-screenshot-basename)
;;            nil)))
;;     (org-download-clipboard file)))

(require 'org-download)
(add-hook 'dired-mode-hook 'org-download-enable)
(setq-default
 org-download-method 'directory
 org-download-image-dir "./images"
 org-download-heading-lvl nil
 org-download-timestamp "%Y%m%d-%H%M%S_")
;; org-image-actual-width 400)

;; (after! org
;;   (setq org-download-method 'directory)
;;   (setq org-download-image-dir "./images")
;;   (setq org-download-heading-lvl nil)
;;   (setq org-download-timestamp "%Y%m%d-%H%M%S_")
;;   (setq org-image-actual-width 300)
;;   (map! :map org-mode-map
;;         "C-c l a y" #'zz/org-download-paste-clipboard
;;         "C-M-y" #'zz/org-download-paste-clipboard))

;; MAGICK for support images
(use-package image
  :ensure t
  :init
  (setq image-default-program "magick") ; Reemplaza 'magick' con el nombre del programa de conversión que hayas instalado
  )

;; ORG AGENDA CONFIG
(after! org
  (setq org-agenda-files '("~/ORG/OrgNotes/AgendaORG/Agenda2025B.org")))
(setq
 ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
 ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
 org-fancy-priorities-list '("🟥" "🟧" "🟨")
 org-priority-faces
 '((?A :foreground "#ff6c6b" :weight bold)
   (?B :foreground "#98be65" :weight bold)
   (?C :foreground "#c678dd" :weight bold))
 ;; org-agenda-block-separator 8411)
 )

;; (setq org-agenda-custom-commands
;;       '(("v" "A better agenda view"
;;          ((tags "PRIORITY=\"A\""
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;                  (org-agenda-overriding-header "High-priority unfinished tasks:")))
;;           (tags "PRIORITY=\"B\""
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;                  (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
;;           (tags "PRIORITY=\"C\""
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;                  (org-agenda-overriding-header "Low-priority unfinished tasks:")))
;;           (tags "customtag"
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;                  (org-agenda-overriding-header "Tasks marked with customtag:")))

;;           (agenda "")
;;           (alltodo "")))))

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags-todo "PRIORITY=\"A\""
                     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags-todo "PRIORITY=\"B\""
                     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags-todo "PRIORITY=\"C\""
                     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags-todo "customtag"
                     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))


;; EMACS OPACITY WITH HYPRLAND
                                        ; (set-frame-parameter nil 'alpha-background 92) ; For current frame
                                        ; (add-to-list 'default-frame-alist '(alpha-background . 92)) ; For all new frames henceforth

;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha)))
;;               100)
;;          '(85 . 50) '(100 . 100)))))
;; (global-set-key (kbd "C-c t") 'toggle-transparency)
;;

;; (doom/set-frame-opacity 92)

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("templateEPCC"
                 "\\documentclass{templateEPCC} ")))


(setq +latex-viewers '(pdf-tools))
(setq lsp-tex-server 'digestif)


;; Best TreeSitter Modern
;; (use-package treesit-auto
;;   :config
;;   (global-treesit-auto-mode))

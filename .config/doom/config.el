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
;; 
;; Old Font
;; (setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :weight 'Semibold :size 18))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'regular))
(setq doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Propo" :size 17 :weight 'regular))

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
(setq doom-theme 'doom-one)
;; (add-to-list 'default-frame-alist '(alpha-background . 90))

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

;;; config.el

;; -------------------------------------------------------------------------
;; INDENTATION
;; -------------------------------------------------------------------------

;; Default: 2 espacios. dtrt-indent y editorconfig ajustan por proyecto.
(setq-default tab-width 2
              c-basic-offset 2
              indent-tabs-mode nil)

(setq c-default-style "bsd")

;; dtrt-indent: adivina la indentación analizando el archivo existente.
;; Si el proyecto usa 4 espacios, lo detecta automáticamente.
(use-package! dtrt-indent
  :hook ((c-mode   . dtrt-indent-mode)
         (c++-mode . dtrt-indent-mode)))

;; Yasnippet: usar indentación fija para que los snippets respeten
;; el offset del buffer actual, no re-indenten con c-basic-offset.
(after! yasnippet
  (add-hook 'c-mode-common-hook
            (lambda () (setq-local yas-indent-line 'fixed))))


;; -------------------------------------------------------------------------
;; CONFIGURACIÓN C/C++ Y GRAFICOS
;; -------------------------------------------------------------------------

;; -------------------------------------------------------------------------
;; Emacs 30 + Doom tree-sitter fix
;; -------------------------------------------------------------------------
;; Emacs 30 auto-promueve c-mode→c-ts-mode, c++-mode→c++-ts-mode, etc.
;; cuando los grammars de tree-sitter están instalados. Pero Doom no
;; engancha font-lock ni lsp! en los modos *-ts-mode. Arreglamos aquí:

;; Fix para Emacs 30: los modos *-ts-mode no ejecutan hooks de Doom.
;; Usamos find-file-hook que sí corre después de abrir el archivo.
(defun my/fix-ts-modes ()
  "Activar font-lock y LSP en modos *-ts-mode que Doom no maneja.
Para GLSL, forzar glsl-mode clásico porque glsl-ts-mode no fontifica."
  (cond
   ;; GLSL: revertir a modo clásico (glsl-ts-mode no tiene buen fontificado)
   ((eq major-mode 'glsl-ts-mode)
    (let ((inhibit-message t))
      (glsl-mode)
      (font-lock-mode 1)))
   ;; C/C++ ts modes: asegurar font-lock + lsp + indentación
   ((derived-mode-p 'c-ts-base-mode)
    (unless font-lock-mode (font-lock-mode 1))
    (setq-local c-ts-mode-indent-offset c-basic-offset)
    (unless (bound-and-true-p lsp-mode) (lsp!)))))

(add-hook 'find-file-hook #'my/fix-ts-modes)

;; Buscar el ejecutable CMake del proyecto automáticamente
(defun my/cmake-find-executable ()
  "Busca el ejecutable generado por CMake en build/, ignorando archivos internos de CMake."
  (when-let ((root (or (my/find-cmake-root) (projectile-project-root) (vc-root-dir))))
    (cl-loop for build-dir in '("build" "cmake-build-debug" "cmake-build-release" "cmake-build")
             for full-dir = (expand-file-name build-dir root)
             when (file-directory-p full-dir)
             thereis (cl-loop for f in (directory-files-recursively full-dir "" nil)
                              when (and (file-executable-p f)
                                        (not (file-directory-p f))
                                        (not (string-match-p "CMakeFiles\\|cmake_install\\|\\.cmake\\|\\.o$\\|\\.a$" f)))
                              return f))))

(defun my/cmake-run ()
  "Ejecuta el binario CMake del proyecto en un vterm popup."
  (interactive)
  (if-let ((exe (my/cmake-find-executable)))
      (let* ((buf-name "*cmake-run*")
             (default-directory (file-name-directory exe)))
        (if-let ((buf (get-buffer buf-name)))
            ;; Si ya existe, re-usar y re-ejecutar
            (progn
              (pop-to-buffer buf)
              (vterm-send-C-c)
              (vterm-send-string (concat exe "\n")))
          ;; Si no existe, crear nuevo vterm popup
          (let ((buf (vterm buf-name)))
            (vterm-send-string (concat exe "\n")))))
    (message "No se encontró el ejecutable. Compila primero con SPC , b")))

(set-popup-rule! "^\\*cmake-run\\*" :side 'bottom :size 0.35 :quit 'current :select t :ttl nil)

;; Usar fish como shell para vterm
(setq vterm-shell "/usr/bin/fish")

(after! cc-mode
  ;; SPC m b = compilar, SPC m r = ejecutar
  (map! :map c++-mode-map
        :localleader
        "b" #'project-compile
        "r" #'my/cmake-run)
  (map! :map c-mode-map
        :localleader
        "b" #'project-compile
        "r" #'my/cmake-run))

;; Keybindings para modos *-ts-mode (Emacs 30)
(map! :after cc-mode
      :map c++-ts-mode-map
      :localleader
      "b" #'project-compile
      "r" #'my/cmake-run)
(map! :after cc-mode
      :map c-ts-mode-map
      :localleader
      "b" #'project-compile
      "r" #'my/cmake-run)

;; Soporte para Shaders (HLSL, GLSL, .shader)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.compute\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.hlsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.shader\\'" . glsl-mode))

;; LSP para GLSL: glsl_analyzer
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("glsl_analyzer"))
    :activation-fn (lsp-activate-on "glsl")
    :server-id 'glsl-analyzer
    :major-modes '(glsl-mode glsl-ts-mode))))

(add-hook 'glsl-mode-hook #'lsp!)
(add-hook 'glsl-mode-hook
          (lambda ()
            (setq-local tab-width 4
                        c-basic-offset 4)))

;; -------------------------------------------------------------------------
;; LSP (Clangd) + CMake compile_commands.json
;; -------------------------------------------------------------------------

(after! lsp-clangd
  ;; Args base para clangd
  (setq lsp-clients-clangd-args
        '("-j=4"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 1)

  ;; Buscar compile_commands.json en la raíz o en subdirectorios de build.
  ;; Compatible con cmake-tools de Neovim (genera en raíz) y CMake manual.
  (defun my/find-compile-commands-dir ()
    "Busca compile_commands.json en la raíz del proyecto y directorios de build comunes."
    (when-let ((project-root (or (my/find-cmake-root)
                                 (projectile-project-root)
                                 (vc-root-dir))))
      (cl-loop for dir in '("." "build" "cmake-build-debug" "cmake-build-release"
                            "cmake-build" "out/build" "out" "builddir")
               for full = (expand-file-name dir project-root)
               when (file-exists-p (expand-file-name "compile_commands.json" full))
               return full)))

  ;; Pasar --compile-commands-dir a clangd para que encuentre el compile_commands.json
  (add-hook 'c-mode-hook #'my/setup-clangd-compile-commands)
  (add-hook 'c++-mode-hook #'my/setup-clangd-compile-commands)
  (add-hook 'c-ts-mode-hook #'my/setup-clangd-compile-commands)
  (add-hook 'c++-ts-mode-hook #'my/setup-clangd-compile-commands)

  (defun my/setup-clangd-compile-commands ()
    (when-let ((dir (my/find-compile-commands-dir)))
      (setq-local lsp-clients-clangd-args
                  (append lsp-clients-clangd-args
                          (list (concat "--compile-commands-dir=" dir)))))))

;; CMake: auto-generar compile_commands.json al configurar
(after! cmake-mode
  (setq cmake-compile-command "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build -S ."))

;; Detectar CMakeLists.txt buscando hacia arriba desde el archivo actual
(defun my/find-cmake-root ()
  "Busca el directorio más cercano hacia arriba que contenga CMakeLists.txt con project()."
  (when-let ((dir (locate-dominating-file
                   (or buffer-file-name default-directory)
                   "CMakeLists.txt")))
    (file-name-as-directory (expand-file-name dir))))

(defun my/set-cmake-compile-command ()
  "Si el proyecto tiene CMakeLists.txt, usar cmake como compile-command."
  (when-let ((root (my/find-cmake-root)))
    (setq-local compile-command
                (format "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B %sbuild -S %s && cmake --build %sbuild"
                        root root root))))

(add-hook 'c-mode-hook #'my/set-cmake-compile-command)
(add-hook 'c++-mode-hook #'my/set-cmake-compile-command)
(add-hook 'c-ts-mode-hook #'my/set-cmake-compile-command)
(add-hook 'c++-ts-mode-hook #'my/set-cmake-compile-command)

;; Desactivar cmake-language-server (incompatible con Python 3.14)
(after! lsp-mode
  (add-to-list 'lsp-disabled-clients 'cmakels))

;; Desactivar formato automático de LSP al guardar
;; (usa SPC c f para formatear manualmente)
(after! lsp-mode
  (setq lsp-before-save-edits nil))



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

(after! org
  (setq org-emphasis-alist
        '(("*" (:foreground "#FABD2F" :weight bold))      ; Negrita en amarillo claro
          ("/" (:foreground "#98be65" :slant italic))     ; Cursiva en verde
          ("_" (:foreground "#c678dd" :underline t))      ; Subrayado en violeta
          ("=" (:foreground "#ff6c6b" :background "#3f444a")) ; Verbatim en rojo suave con fondo
          ("~" (:foreground "#da8548")) ; Code en naranja con fondo
          ("+" (:foreground "#5b6268" :strike-through t))))) ; Tachado en gris

;; Htmlize: resaltado de sintaxis en exportación HTML (org-roam-ui)
(after! htmlize
  (setq org-html-htmlize-output-type 'inline-css))

;; Fix: org-modern interfiere con fontificado de bloques src
(add-hook 'org-mode-hook
          (lambda ()
            (run-with-idle-timer 0.5 nil
              (lambda () (font-lock-flush)))))

;; MCP
(use-package! mcp-server
  :config
  (setq mcp-server-emacs-tools-enabled 'all)
  (mcp-server-start))

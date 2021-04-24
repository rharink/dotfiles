;;; lang/reason/config.el -*- lexical-binding: t; -*-

 (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
      (when (and opam-share (file-directory-p opam-share))
       ;; Register Merlin
       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
       (autoload 'merlin-mode "merlin" nil t nil)
       ;; Automatically start it in OCaml buffers
       (add-hook 'tuareg-mode-hook 'merlin-mode t)
       (add-hook 'caml-mode-hook 'merlin-mode t)
       ;; Use opam switch to lookup ocamlmerlin binary
       (setq merlin-command 'opam)))


(defun chomp-end (str)
  "Chomp tailing whitespace from STR."
  (replace-regexp-in-string (rx (* (any " \t\n")) eos)
                            ""
                            str))

(defun real-path (path)
  "Resolves the actual path for PATH."
  (chomp-end (shell-command-to-string (concat "realpath " path))))

(let ((support-base-dir (concat (replace-regexp-in-string "refmt\n" "" (shell-command-to-string (concat "realpath " (shell-command-to-string "which refmt")))) ".."))
      (merlin-base-dir (concat (replace-regexp-in-string "ocamlmerlin\n" "" (shell-command-to-string (concat "realpath " (shell-command-to-string "which ocamlmerlin")))) "..")))
  ;; Add npm merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
  (add-to-list 'load-path (concat merlin-base-dir "/share/emacs/site-lisp/"))
  (setq merlin-command (concat merlin-base-dir "/bin/ocamlmerlin"))

  ;; Add npm reason-mode to the emacs load path and tell emacs where to find refmt
  (add-to-list 'load-path (concat support-base-dir "/share/emacs/site-lisp"))
  (setq refmt-command (concat support-base-dir "/bin/refmt")))

(require 'reason-mode)
(require 'merlin)
(add-hook 'reason-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(setq merlin-ac-setup t)

;;(require 'merlin-iedit)
;;(defun evil-custom-merlin-iedit ()
;;  (interactive)
;;  (if iedit-mode (iedit-mode)
;;    (merlin-iedit-occurrences)))
;;(define-key merlin-mode-map (kbd "C-c C-e") 'evil-custom-merlin-iedit)

;; If you're using different versions of refmt between projects, you can use the
;;    project-specific installed version via the special config values:
;; -  'npm (calls npx refmt ... to use the version of refmt installed in the project's node_modules)
;; -  'opam (calls opam exec -- refmt ... to use the version of refmt on the current opam switch):
(setq refmt-command 'npm)

(map! :after reason-mode
      :map reason-mode-map
      :n "gd" #'merlin-locate)

;; C-x C-k n
;; Give a command name (for the duration of the Emacs session) to the most recently defined keyboard macro (kmacro-name-last-macro).
;; C-x C-k b
;; Bind the most recently defined keyboard macro to a key sequence (for the duration of the session) (kmacro-bind-to-key).
;; M-x insert-kbd-macro
;; Insert in the buffer a keyboard macro's definition, as Lisp code.


;; (load "~/.emacs.d/haskell-mode/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq scroll-step 1)
(setq scroll-conservatively 10000)

(setq tramp-debug-buffer t)
(setq shell-prompt-pattern "")
(setq tramp-default-method "ssh")


;;(add-to-list 'load-path "/Applications/SuperCollider/sclang")
;;(require 'sclang)


(require 'tls)
(require 'erc)

(require 'uniquify)
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;; erlang
(setq load-path (cons  "/usr/local/Cellar/erlang/R15B/lib/erlang/lib/tools-2.6.6.6/emacs"
      load-path))
      (setq erlang-root-dir "/usr/local/Cellar/erlang")
      (setq exec-path (cons "/usr/local/Cellar/erlang/R15B/bin" exec-path))
      (require 'erlang-start)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-n" 'outline-next-visible-heading)
            (local-set-key "\M-p" 'outline-previous-visible-heading)
					; org-metaleft
	    (local-set-key  "\M-\S-l" 'org-metaright)
					; org-metaright
	    (local-set-key "\M-\S-h" 'org-metaleft)))

; python macros
(fset 'line-to-kill-ring
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("" 0 "%d")) arg)))

(fset 'comment-line-python
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 32 backspace 1 67108896 5 134217848 99 111 109 109 tab 101 110 tab 114 101 tab return] 0 "%d")) arg)))

(fset 'uncomment-line-python
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 67108896 5 134217848 117 110 99 111 109 109 101 110 116 45 114 101 103 105 111 110 return] 0 "%d")) arg)))

(fset 'ig-python-doc
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([34 34 34 return 34 34 34 16 tab 14 tab 16 13 tab] 0 "%d")) arg)))


(require 'python)
(define-key python-mode-map "\M-k" 'line-to-kill-ring)
(define-key python-mode-map "\C-h" 'comment-line-python)
(define-key python-mode-map "\C-j" 'uncomment-line-python)
(define-key python-mode-map (kbd "C-c q") 'ig-python-doc)


(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)

(add-hook 'python-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))


;; http://emacsblog.org/2007/03/12/tab-completion-everywhere/
;; (defun indent-or-expand (arg)
;;   "Either indent according to mode, or expand the word preceding
;; point."
;;   (interactive "*P")
;;   (if
;;       (eolp)  ;; point is at end of line

;; ;  (if (and
;;  ;      (or (bobp) (= ?w (char-syntax (char-before))))
;; ;       (or (eobp) (not (= ?w (char-syntax (char-after))))))
;;       (dabbrev-expand arg)
;;     (indent-according-to-mode)))
;; (defun my-tab-fix ()
;;   (local-set-key [tab] 'indent-or-expand))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FLYMAKE MODE
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "/Library/Frameworks/Python.framework/Versions/2.7/bin/pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))



(defun my-flymake-err-at (pos)
  (let ((overlays (overlays-at pos)))
    (remove nil
            (mapcar (lambda (overlay)
                      (and (overlay-get overlay 'flymake-overlay)
                           (overlay-get overlay 'help-echo)))
                    overlays))))


(defun my-flymake-err-echo ()
  (message "%s" (mapconcat 'identity (my-flymake-err-at (point)) "\n")))


(defun my-flymake-show-next-error()
    (interactive)
    (flymake-goto-next-error)
    (my-flymake-err-echo)
    ;; (flymake-display-err-menu-for-current-line)
    )

(defun my-flymake-show-prev-error()
    (interactive)
    (flymake-goto-prev-error)
    (flymake-display-err-menu-for-current-line)
    )

(defvar my-flymake-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\M-p" 'my-flymake-show-prev-error)
    (define-key map "\M-n" 'my-flymake-show-next-error)
    map)
  "Keymap for my flymake minor mode.")

;;(add-hook 'python-mode-hook 'my-flymake-minor-mode-map)

(define-minor-mode my-flymake-minor-mode
  "Simple minor mode which adds some key bindings for moving to the next and previous errors.
Key bindings:
\\{my-flymake-minor-mode-map}"
  nil
  "my-flymake-minor-mode"
  :keymap 'my-flymake-minor-mode-map)


(add-hook 'python-mode-hook 'my-flymake-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  for editing files over tramp
;(add-hook 'find-file-hook 'flymake-find-file-hook)






(setq-default ispell-program-name "/usr/local/bin/aspell")


(setq visible-bell t)
;(windmove-default-keybindings)
(setq font-lock-maximum-decoration t)
(display-time)
(defun night-screen ()
  (interactive)
  (set-cursor-color "#8fc92a")
  (set-foreground-color "#ffa500")
  (set-background-color "#2b2b2b"))

(defun daylight-screen ()
  (interactive)
  (set-cursor-color "black")
  (set-foreground-color "brown")
  (set-background-color "white"))
(setq load-path (append (list (expand-file-name "~/.emacs.d/")) load-path))
(setq load-path (append (list (expand-file-name "~/.emacs.d/ess-12.04-4/lisp/")) load-path))
(require 'ess-site)

(setq load-path (append (list (expand-file-name "~/.emacs.d/js2-mode/")) load-path))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(fset 'ig-js2-comment-line
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("// " 0 "%d")) arg)))

(fset 'ig-js2-uncomment-line
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 117 110 99 111 109 109 tab 108 105 110 tab return] 0 "%d")) arg)))

(fset 'ig-js2-curly-complete
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([32 123 13 13 125 59 16 tab] 0 "%d")) arg)))

(defun ig-js2-mode-hook ()
(define-key js2-mode-map "\C-h" 'ig-js2-comment-line)
(define-key js2-mode-map "\C-j" 'ig-js2-uncomment-line)
(define-key js2-mode-map (kbd "C-{") 'ig-js2-curly-complete)
(message "Isaac's js2-mode hook"))


(add-hook 'js2-mode-hook 'ig-js2-mode-hook)


;; go mode
(require 'go-mode)



;; (require 'git)
;(require 'flymake-cursor)
;; Overwrite flymake-display-warning so that no annoying dialog box is
;; used.

;; This version uses lwarn instead of message-box in the original version.
;; lwarn will open another window, and display the warning in there.
;; (defadvice flymake-display-warning (after stop-x-message (warning))
;;   "Display a warning to the user, using lwarn"
;;   (lwarn 'flymake :warning warning))

;; ;; Using lwarn might be kind of annoying on its own, popping up windows and
;; ;; what not. If you prefer to recieve the warnings in the mini-buffer, use:
;; (defadvice flymake-display-warning (after stop-x-warning (warning))
;;   "Display a warning to the user, using lwarn"
;;   (message warning))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(py-pychecker-command "/Library/Frameworks/Python.framework/Versions/2.7/bin/pyflakes")

 '(py-pychecker-command-args (quote ("")))

; '(python-check-command "~/bin/pep8checker.sh")
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2b2b2b" :foreground "#ffa500" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Courier_New"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "red3"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "CadetBlue1")))))

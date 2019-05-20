(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(package-selected-packages
   (quote
    (auto-complete flycheck-tip flycheck company popup magit circe evil-visual-mark-mode zenburn-theme org)))
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'zenburn t)
(when window-system 
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(menu-bar-mode -1)

;; enable ido mode
(ido-mode t)

;; set vim mode
(require 'evil)
(evil-mode t)

;; auto-complete
(ac-config-default)
(add-hook 'after-init-hook 'global-company-mode)


;; org-mode config

;; erlang config
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-3.1/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)



;;flycheck
(require 'flycheck)
(flycheck-define-checker erlang-otp
  "An Erlang syntax checker using the Erlang interpreter."
  :command ("erlc" "-o" temporary-directory "-Wall"
	    "-I" "../include" "-I" "../../include"
	    "-I" "../../../include" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ": Warning:" (message) line-end)
   (error line-start (file-name) ":" line ": " (message) line-end))
  :modes (erlang-mode)
  )
(add-hook 'erlang-mode-hook
	  (lambda ()
	    (flycheck-select-checker 'erlang-otp)
	    (flycheck-mode)))
(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toggle between most recent buffers                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; set key binding
(global-set-key (kbd "M-SPC") 'switch-to-previous-buffer)
(global-set-key (kbd "C-y") 'clipboard-yank)
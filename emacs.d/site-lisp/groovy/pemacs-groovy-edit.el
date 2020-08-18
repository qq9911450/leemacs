;;;

(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)

(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(add-hook 'groovy-mode-hook '(c-set-offset 'label 2))
(add-hook 'groovy-mode-hook '(indent-tabs-mode . nil))

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))

(provide 'pemacs-groovy-edit)

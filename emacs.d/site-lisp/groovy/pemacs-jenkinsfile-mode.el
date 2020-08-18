;;;

(require 'groovy-mode)

(setq jenkinsfile-mode-font-lock-keywords
      `(("pipeline" . font-lock-preprocessor-face)
        ("agent\\|post\\|stages\\|steps" . font-lock-builtin-face)
        (,(regexp-opt '("environment" "options" "parameters"
                        "triggers" "stage" "tools" "input"
                        "when" "parallel" "script") 'symbols)
         . font-lock-constant-face)
        (,(regexp-opt '("always" "changed" "fixed"
                        "regression" "aborted" "failure" "success"
                        "unstable" "unsuccessful" "cleanup") 'symbols)
         . font-lock-keyword-face)
        (,(regexp-opt '("buildDiscarder" "checkoutToSubdirectory"
                        "disableConcurrentBuilds" "disableResume"
                        "newContainerPerStage" "overrideIndexTriggers"
                        "preserveStashes" "quietPeriod" "retry"
                        "skipDefaultCheckout" "skipStagesAfterUnstable"
                        "timeout" "timestamps" "parallelsAlwaysFailFast") 'symbols)
         . font-lock-keyword-face)
        (,(regexp-opt '("string" "text" "booleanParam" "choice" "file"
                        "password") 'symbols)
         . font-lock-keyword-face)
        (,(regexp-opt '("cron" "pollSCM" "upstream") 'symbols)
         . font-lock-keyword-face)
        (,(regexp-opt '("id" "ok" "subitter" "submitterParameter" "parameters") 'symbols)
         . font-lock-keyword-face)
        (,(regexp-opt '("branch" "buildingTag" "changelog" "changeset" "changeRequest"
                        "environment" "equals" "expression" "tag" "not" "allOf"
                        "anyOf" "triggeredBy") 'symbols)
         . font-lock-keyword-face)
        ))

(setq jenkinsfile-mode-font-lock-defaults
      (append groovy-font-lock-keywords jenkinsfile-mode-font-lock-keywords))

(define-derived-mode jenkinsfile-mode groovy-mode "jenkinsfile-mode"
  "Major mode for editing Jenkins declarative pipeline files."
  (setq font-lock-defaults '(jenkinsfile-mode-font-lock-defaults)))

(provide 'pemacs-jenkinsfile-mode)
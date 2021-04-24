;;; completion/selectrum/config.el -*- lexical-binding: t; -*-
;; enable
(selectrum-mode +1)

;; to make sorting and filtering more intelligent
(selectrum-prescient-mode +1)

;; to save your command history on disk, so the sorting gets more
;; intelligent over time
(prescient-persist-mode +1)

;; to make sorting and filtering more intelligent
;; to save your command history on disk, so the sorting gets more
;; intelligent over time
;; (after! prescient
;;     (prescient-persist-mode +1)
;;     (selectrum-prescient-mode +1))

#lang rosette

; Section 4.8: Boxes
(define-symbolic x integer?)
(define-symbolic b boolean?)

(define v1 (box x)) ; v1 is a box with symbolic contents
(define v2 (if b v1 (box 3))) ; v2 is a symbolic box

(define sol
  (solve (assert (= 4 (unbox v2)))))

(evaluate v1 sol)
(evaluate v2 sol)

(evaluate (eq? v1 v2) sol)
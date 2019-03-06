#lang rosette

; Section 8: Unsafe Operations

; The following snippet demonstrates the non-standard execution
; that the SVM needs to perform in order to assign the expected meaning to Rosette code
(define y (vector 0 1 2))
(define-symbolic b boolean?)
(if b
    (vector-set! y 1 3)
    (vector-set! y 2 4))
y

(define env1 (solve (assert b)))
(evaluate y env1)
(define env2 (solve (assert (not b))))
(evaluate y env2)

; Incorrect behavior due to unsafe operations
(define h (make-hash '((1 . 2))))
(define-symbolic key integer?)

(hash-ref h key 0) ; incorrect value: 0

(when b
  (hash-clear! h))
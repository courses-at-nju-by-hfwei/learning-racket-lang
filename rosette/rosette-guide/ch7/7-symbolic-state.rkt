#lang rosette

; Section 7.2: Reflecting on Symbolic State

(define-symbolic a b boolean?)
(if a
    (if b
        #f
        (pc)) ; pc returns the current path condition
    #f)

(define-values (result asserted)
  (with-asserts ; returns two results: the evaluation result and the assertions generated
      (begin (assert a)
             (assert b)
             4)))
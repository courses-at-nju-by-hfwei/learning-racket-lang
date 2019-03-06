#lang rosette

; Section 4.7: Vectors
(define-symbolic x y z n integer?)
(define xs (take (list x y z) n)) ; xs is a symbolic list
(asserts)
(define vs (list->vector xs)) ; vs is a symbolic vector
(asserts)

(define sol
  (solve
   (begin
     (assert (< n 3))
     (assert (= 4 (vector-ref vs (sub1 n)))))))
(evaluate n sol)
(evaluate (list x y z) sol)
(evaluate vs sol)
(evaluate xs sol)

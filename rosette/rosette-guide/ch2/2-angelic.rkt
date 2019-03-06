;  @secref["sec:solve" #:doc '(lib "rosette/doc/guide/scribble/rosette-guide.scrbl")]

; Section 2.3.4: Angelic Execution
#lang rosette

(define (poly x)
 (+ (* x x x x) (* 6 x x x) (* 11 x x) (* 6 x)))

(define-symbolic x y integer?)
(define sol
  (solve (begin (assert (not (= x y)))
                (assert (< (abs x) 10))
                (assert (< (abs y) 10))
                (assert (not (= (poly x) 0)))
                (assert (= (poly x) (poly y))))))
(evaluate x sol)
(evaluate y sol)
(evaluate (poly x) sol)
(evaluate (poly y) sol)
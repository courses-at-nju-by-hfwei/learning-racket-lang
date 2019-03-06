#lang rosette

; Section 4.5: Procedures

(define-symbolic b boolean?)
(define-symbolic x integer?)

(define p (if b * -)); a symbolic procedure

(define sol
  (synthesize #:forall (list x)
              #:guarantee (assert (= x (p x 1)))))

(evaluate p sol)

(define sol2
  (synthesize #:forall (list x)
              #:guarantee (assert (= x (p x 0)))))
(evaluate p sol2)

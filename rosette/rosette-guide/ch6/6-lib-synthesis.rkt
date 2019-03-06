#lang rosette

; Section 6.2: Solver-Aided Libraries

; Section 6.2.1: Synthesis Library
(require rosette/lib/synthax)

(define (div2 x)
  ([choose bvshl bvashr bvlshr bvadd bvsub bvmul] x (?? (bitvector 8))))
(define-symbolic i (bitvector 8))
(print-forms
 (synthesize #:forall (list i)
             #:guarantee (assert (equal? (div2 i) (bvudiv i (bv 2 8))))))

; Defines a grammar for boolean expressions
; in negation normal form (NNF).
(define-synthax (nnf x y depth)
  #:base (choose x (! x) y (! y))
  #:else (choose
          x (! x) y (! y)
          ((choose && ||) (nnf x y (- depth 1))
                          (nnf x y (- depth 1)))))
; The boby of nnf=> is a hole to be filled with
; an expression of depth (up to) 1 from the NNF grammar.
(define (nnf=> x y)
  (nnf x y 1))

(define-symbolic a b boolean?)
(print-forms
 (synthesize
  #:forall (list a b)
  #:guarantee (assert (equal? (=> a b) (nnf=> a b)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A grammar for linear arithmetic
(define-synthax LA
  ([(_ e ...) (+ (* e (??)) ...)]))

; The following query has no solution
; because (??) in (LA e ...) generates a single integer hole
; that is shared by all e passed to LA, in this case x and y.
(define-symbolic* x y integer?)
(define sol
  (synthesize
   #:forall (list x y)
   #:guarantee (assert (= (LA x y) (+ (* 2 x) y)))))

; The following query has a solution
; because the second clause of LA2 creates two independent (??) holes.
(define-synthax LA2
  ([(_ e) (* e (??))]
   [(_ e1 e2) (+ (* e1 (??)) (* e2 (??)))]))

(print-forms
  (synthesize
   #:forall (list x y)
   #:guarantee (assert (= (LA2 x y) (+ (* 2 x) y)))))
#lang rosette

; Section 4.1: Equality
(define-symbolic f g (~> integer? integer?))

(distinct?)
(define-symbolic x y z integer?)
(distinct? 3 z x y 2)
(distinct? 2 x y z 2)

(define-symbolic b boolean?)
(distinct? 3 (bv 3 4) (list 1) (list x) y 2)

; Section 4.2: Booleans, Integers, and Reals
(! (if b #f 3)) ; this typechecks only when b is true
(asserts) ; so Rosette emits a corresponding assert

(clear-asserts!)
(&& #f (begin (displayln "hello") #t)); no shortcircuiting

(clear-asserts!)
(define-symbolic a boolean?)
(&& a (if b #t 1)) ; this typechecks only when b is true
(asserts) ; so Rosette emits a corresponding assert

(clear-asserts!)
(current-bitwidth #f)
(define-symbolic u v integer?)
(forall (list) (= u v))

(clear-asserts!)
(define h (forall (list u) (exists (list v) (= u (+ u v)))))
(define l (forall (list u) (= u (+ u v))))
(define n (forall (list a) (= a (+ a a))))
(define m (exists (list a) (forall (list a) (= a (+ a a)))))
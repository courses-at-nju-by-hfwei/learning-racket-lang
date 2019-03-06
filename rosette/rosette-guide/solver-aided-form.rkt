; @secref["ch:syntactic-forms:rosette" #:doc '(lib "rosette/doc/guide/scribble/rosette-guide.scrbl")]
; Section 3.2: Solver-Aided Forms

#lang rosette

; Section 3.2.1: Symbolic Constants
(define (always-same)
  (define-symbolic x integer?)
  x)

(define (always-different)
  (define-symbolic* x integer?)
  x)

; Section 3.2.2: Assertions

; Section 3.2.3: Angelic Execution
(define-symbolic x y boolean?)
(assert x)

(define sol (solve (assert y)))

(define-symbolic u v integer?)
(define inc (solve+)) ; incremental solver
(inc (< u v)) ; push and solve
; (inc (> u v)) ; unsat
(inc (> u 5)) ; push and solve
(inc (< v 4)) ; push and solve: unsat
(inc 1) ; pop (< v 4) and solve
(inc (< v 9)); push and solve
(inc 'shutdown)

; Section 3.2.4: Verification
(clear-asserts!)
(assert x)
(define veri (verify (assert y)))
(asserts)
(evaluate x veri)
(evaluate y veri)
(verify #:assume (assert y) #:guarantee (assert (and x y)))

; Section 3.2.5: Synthesis
(clear-asserts!)
(define-symbolic e o integer?)
(assert (even? e))
(asserts)
(define syn
  (synthesize #:forall e
              #:guarantee (assert (odd? (+ e o)))))
(asserts)
(evaluate e syn) ; e is unbound
(evaluate o syn)

; Section 3.2.6: Optimization
(clear-asserts!)
(current-bitwidth #f)
(define-symbolic s t integer?)
(assert (< s 2))
(define opt
  (optimize #:maximize (list (+ s t))
            #:guarantee (assert (< (- t s) 1))))
(evaluate s opt)
(evaluate t opt)
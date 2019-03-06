#lang rosette

; Section 4.9: Solvers and Solutions
(current-solver)
(require rosette/solver/smt/z3)
(require rosette/solver/smt/z3)
(require rosette/solver/mip/cplex)

(define-symbolic a b boolean?)
(define-symbolic x y integer?)
(define sol
  (solve (begin
           (assert a)
           (assert (= x 1))
           (assert (= y 2)))))
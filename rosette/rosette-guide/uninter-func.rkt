#lang rosette

; Section 4.4: Uninterpreted Functions

(current-bitwidth #f)

; an uninterpreted function from integers to booleans:
(define-symbolic f (~> integer? boolean?))
(f 1)

(define-symbolic x real?) ; this typechecks when x is an integer
(f x)

(asserts) ; so Rosette emits the corresponding assertion

(define sol (solve (assert (not (equal? (f x) (f 1))))))
(define g (evaluate f sol)) ; an interpretation of f
(g x) ; apply g to symbolic values

(define t (~> integer? real? boolean? (bitvector 4)))

(clear-asserts!)
(define-symbolic h (~> boolean? boolean?))
(define-symbolic b boolean?)
(define solution
  (solve
   (begin
     (assert (not (h #t)))
     (assert (h #f)))))
(define l (evaluate h solution))
(define v (verify (assert (equal? (l b) (not b))))) ; verify that l implements logical negation
#lang rosette

(struct point (x y) #:transparent)
(struct pt (x y))
(struct pnt (x y) #:mutable #:transparent)

(define-symbolic b boolean?)
(define p (if b (point 1 2) (point 3 4))) ; p holds a symbolic structure
(point-x p)
(point-y p)

(define sol
  (solve (assert (= (point-x p) 3))))
(evaluate p sol)

; Rosette also lifts structure properties, generic interfaces,
; and facilities for defining new properties and interfaces.

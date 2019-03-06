;  @secref["sec:synthesize" #:doc '(lib "rosette/doc/guide/scribble/rosette-guide.scrbl")]

; Section 2.3.3: Synthesis
#lang rosette

(require rosette/lib/synthax)

(define (poly x)
 (+ (* x x x x) (* 6 x x x) (* 11 x x) (* 6 x)))

(define (factored x)
 (* (+ x (??)) (+ x 1) (+ x (??)) (+ x (??))))

(define (same p f x)
  (assert (= (p x) (f x))))

(define-symbolic i integer?)
(print-forms
  (synthesize
   #:forall (list i)
   #:guarantee (same poly factored i)))
; @secref["sec:notes" #:doc '(lib "rosette/doc/guide/scribble/rosette-guide.scrbl")]

; Section 2.4: Symbolic Reasoning
#lang rosette

(define-symbolic x integer?)

(current-bitwidth 5)
; 64 = 0 in the 5-bit representation
(solve (begin (assert (= x 64))
              (assert (= x 0))))
(verify (assert (not (and (= x 64) (= x 0)))))

(current-bitwidth #f)
; but no solutions exist under infinite-precision semantics
(solve (begin (assert (= x 64))
              (assert (= x 0))))
(verify (assert (not (and (= x 64) (= x 0)))))

(letrec ([ones (lambda (n)
                    (if (<= n 0)
                        (list)
                        (cons 1 (ones (- n 1)))))])
    (printf "~a\n" (ones 3))
    ; (printf "~a" (ones x)) timeout
  )

; It is safe to apply recursive procedures to symbolic values
; if they are not used in termination checks.
(letrec ([adder (lambda (vs n)
                    (if (null? vs)
                        (list)
                        (cons (+ (car vs) n) (adder (cdr vs) n))))])
    (adder '(1 2 3) x))
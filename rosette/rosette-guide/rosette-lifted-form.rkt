#lang rosette

(let ([y 0])
    (if #t (void) (set! y 3))
    (printf "y unchanged: ~a\n" y)
    (if #f (set! y 3) (void))
    (printf "y unchanged: ~a\n" y)
    (define-symbolic x boolean?)
    (if x (void) (set! y 3))
    (printf "y symbolic: ~a\n" y))

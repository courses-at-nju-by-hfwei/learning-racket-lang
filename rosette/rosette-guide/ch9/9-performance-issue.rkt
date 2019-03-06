#lang rosette

; Section 9.1: Common Performance Issues

; Section 9.1.1: Integer and Real Theories
(current-bitwidth 5)
(define-symbolic x integer?)
(solve (assert (> x 15)))

; Section 9.1.2: Algorithmic Mismatch
(define (list-set lst idx val)
  (let-values ([(front back) (split-at lst idx)])
    (append front (cons val (cdr back)))))

(define-symbolic* idx len integer?)
(define lst (take '(a b c) len))
(list-set lst idx 'd)

(define (list-set* lst idx val)
    (for/all ([lst lst])
      (map (lambda (i v) (if (= idx i) val v))
           (build-list (length lst) identity)
           lst)))
(list-set* '(a b c) 1 'd)
(list-set* lst idx 'd)

; Section 9.1.3 Irregular Representation
(define-values (width height) (values 5 5))
(define-symbolic* y integer?)
(define grid/2d
  (for/vector ([_ height])
    (make-vector width #f)))
(vector-set! (vector-ref grid/2d y) x 'a)

(define grid/flat
    (make-vector (* width height) #f))
(vector-set! grid/flat (+ (* y width) x) 'a)

; Section 9.1.4: Missed Concretization
(define (maybe-ref lst idx)
  (if (<= 0 idx 1)
      (list-ref lst idx)
      -1))
(maybe-ref '(5 6 7) idx)

(define (maybe-ref* lst idx)
    (cond [(= idx 0) (list-ref lst 0)]
          [(= idx 1) (list-ref lst 1)]
          [else -1]))
(maybe-ref* '(5 6 7) idx)
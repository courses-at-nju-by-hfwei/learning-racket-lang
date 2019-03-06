#lang rosette

; Section 9.3: Walkthrough: Debugging Rosette Performance
; Calculator opcodes.
(define-values (Add Sub Sqr Nop)
  (values (bv 0 2) (bv 1 2) (bv 2 2) (bv 3 2)))
; An interpreter for calculator programs.
; A program is a list of '(op) or '(op arg) instructions
; that update acc, where op is a 2-bit opcode and arg is
; a 4-bit constant.
(define (calculate prog [acc (bv 0 4)])
  (cond
    [(null? prog) acc]
    [else
     (define ins (car prog))
     (define op (car ins))
     (calculate
      (cdr prog)
      (cond
        [(eq? op Add) (bvadd acc (cadr ins))]
        [(eq? op Sub) (bvsub acc (cadr ins))]
        [(eq? op Sqr) (bvmul acc acc)]
        [else         acc]))]))

; Functionally sets lst[idx] to val.
(define (list-set lst idx val)
  (match lst
    [(cons x xs)
     (if (= idx 0)
         (cons val xs)
         (cons x (list-set xs (- idx 1) val)))]
    [_ lst]))

; Replaces Sub with Add if possible.
(define (sub->add prog idx)
  (define ins (list-ref prog idx))
  (if (eq? (car ins) Sub)
      (list-set prog idx (list Add (bvneg (cadr ins))))
      prog))

; Verifies the given transform for all programs of length N.
(define (verify-xform xform N)
  (define P
    (for/list ([i N])
      (define-symbolic* op (bitvector 2))
      (define-symbolic* arg (bitvector 4))
      (if (eq? op Sqr) (list op) (list op arg))))
  (define-symbolic* acc (bitvector 4))
  (define-symbolic* idx integer?)
  (define xP (xform P idx))
  (verify
   (assert (eq? (calculate P acc) (calculate xP acc)))))

(verify-xform sub->add 10)

; The core issue here is an algorithmic mismatch:
; list-set makes a recursive call guarded by a short-circuiting condition (= idx 0)
; that is symbolic when idx is unknown.
(define-symbolic* idx integer?)
(list-set '(1 2 3) idx 4)

; The solution is to alter list-set to recurse unconditionally:
(define (list-set* lst idx val)
    (match lst
      [(cons x xs)
       (cons (if (= idx 0) val x)
             (list-set* xs (- idx 1) val))]
      [_ lst]))
(list-set* '(1 2 3) idx 4)
#lang rosette

; Section 4.3: Bitvectors

(define-symbolic x y (bitvector 7))
(define-symbolic b c boolean?)

(define bv6? (bitvector 6))
(bv6? (if b (bv 3 6) #t))

(bvnot (if b 0 (bv 0 4))) ; this typechecks only when b is false

(define-symbolic z (bitvector 3))

(define-symbolic i j integer?)
(extract i j (bv 1 2)) ; store asserts

(clear-asserts!)
(integer->bitvector 4 (bitvector 2))
(integer->bitvector (if b pi 3) (if c (bitvector 5) (bitvector 6)))
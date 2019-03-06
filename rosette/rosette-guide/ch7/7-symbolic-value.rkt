#lang rosette

; Section 7.1: Reflecting on Symbolic Values

; Section 7.1.2: Symbolic Unions
(define-symbolic b boolean?)
(define-symbolic c boolean?)

(define v (vector 1))
(define w (vector 2 3))
(define s (if b v w))

(define t (if c "c" 0))
(define u (if b (vector t) 4))

; Section 7.1.3: Symbolic Lifting

; Lifting a pure Racket procedure to work on symbolic unions
(require (only-in racket [string-length racket/string-length]))

(define (string-length value)
  (for/all ([str value])
    (racket/string-length str)))

(string-length (if b "a" "abababa") )
(string-length (if b "a" 3))
(asserts)
(clear-asserts!)

; Making symbolic evaluation more efficient
(require (only-in racket build-list))
(define limit 1000)

(define (slow xs)
  (and (= (length xs) limit) (car (map add1 xs))))

(define (fast xs)
  (for/all ([xs xs]) (slow xs)))

(define ys (build-list limit identity))

(define-symbolic a boolean?)

(define xs (if a ys (cdr ys)))

; define-lift
(require rosette/lib/lift)
(require (only-in racket [string-length racket/string-length] string?))
(define-lift string-len
  [(string?) racket/string-length])

#lang racket

; 5: Progammer-Defined Datatypes

; 5.1: Simple Structure Types: struct
(struct posn (x y))

; 5.2: Copying and Update
(define p1 (posn 1 2))
(define p2 (struct-copy posn p1 [x 3]))

; 5.3: Structure Subtypes
(struct 3d-posn posn (z))
(define p (3d-posn 1 2 3))

; 5.4: Opaque versus Transparent Structure Types
(struct posn-transparent (x y)
  #:transparent)

; 5.5: Structure Comparisons
(struct glass (width height) #:transparent)
; (equal? (glass 1 2) (glass 1 2)) ; #t

; (struct lead (width height))
; (define slab (lead 1 2))
; (equal? slab (lead 1 2)) ; #f

; To support instances comparisons via equal?
; without making the structure type transparent,
; you can use the #:methods keyword, gen:equal+hash,
; and implement three methods:
(struct lead (width height)
  #:methods
  gen:equal+hash
  [(define (equal-proc a b equal?-recur)
     (and (equal?-recur (lead-width a) (lead-width b))
          (equal?-recur (lead-height a) (lead-height b))))
   (define (hash-proc a hash-recur)
     (+ (hash-recur (lead-width a))
        (* 3 (hash-recur (lead-height a)))))
   (define (hash2-proc a hash2-recur)
     (+ (hash2-recur (lead-width a)
                     (hash2-recur (lead-height a)))))])

; 5.6: Structure Type Generativity
(struct fish (size) #:transparent)

(define (add-bigger-fish lst)
  (cond
    [(null? lst) (list (fish 1))]
    [else (cons (fish (* 2 (fish-size (car lst))))
                lst)]))

; 5.8: More Structure Type Options
; #:auto-value
(struct posn-auto (x y [z #:auto] [w #:auto])
               #:transparent
               #:auto-value 0)
; #:guard
(struct thing (name)
          #:transparent
          #:guard (lambda (name type-name)
                    (cond
                      [(string? name) name]
                      [(symbol? name) (symbol->string name)]
                      [else (error type-name
                                   "bad name: ~e"
                                   name)])))

(struct person thing (age)
          #:transparent
          #:guard (lambda (name age type-name)
                    (if (negative? age)
                        (error type-name "bad age: ~e" age)
                        (values name age))))

; #:methods
(struct cake (candles)
          #:methods gen:custom-write
          [(define (write-proc cake port mode)
             (define n (cake-candles cake))
             (show "   ~a   ~n" n #\. port)
             (show " .-~a-. ~n" n #\| port)
             (show " | ~a | ~n" n #\space port)
             (show "---~a---~n" n #\- port))
           (define (show fmt n ch port)
             (fprintf port fmt (make-string n ch)))])

; #:property
(struct greeter (name)
          #:property prop:procedure
                     (lambda (self other)
                       (string-append
                        "Hi " other
                        ", I'm " (greeter-name self))))
(define joe-greet (greeter "Joe"))

; #:super
(define (raven-constructor super-type)
  (struct raven ()
          #:super super-type
          #:transparent
          #:property prop:procedure (lambda (self)
                                      'nevermore))
  raven)
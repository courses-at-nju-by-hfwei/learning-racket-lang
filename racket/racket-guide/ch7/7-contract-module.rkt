#lang racket

; 7.1.2: Experimenting with Contracts and Modules
(module+ server
  (provide (contract-out [amount (and/c number? positive?)]))
  (define amount 150))
 
(module+ main
  (require (submod ".." server))
  (+ amount 200))

; 7.1.3: Experimenting with Nested Contract Boundaries
(define/contract amount
  (and/c number? positive?)
  150)

(+ amount 10)
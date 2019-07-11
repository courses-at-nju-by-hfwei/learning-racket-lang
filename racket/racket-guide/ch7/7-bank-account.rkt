#lang racket
 
(provide (contract-out
          [deposit (-> number? any)]
          [balance (-> number?)]))
 
(define amount 0)
(define (deposit a) (set! amount (+ amount a)))
(define (balance) amount)

(define/contract (deposit1 a)
  (-> number? any)
  (set! amount (+ amount a)))
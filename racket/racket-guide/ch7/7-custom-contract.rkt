#lang racket

; 7.2.4: Rolling Your Own Contracts
(define (amount? a)
  (and (number? a) (integer? a) (exact? a) (>= a 0)))
 
(provide (contract-out
          ; an amount is a natural number of cents
          ; is the given number an amount?
          [deposit (-> amount? any)]
          [amount? (-> any/c boolean?)]
          [balance (-> amount?)]))
 
(define amount 0)
(define (deposit a) (set! amount (+ amount a)))
(define (balance) amount)

(define (has-decimal? str)
  (define L (string-length str))
  (and (>= L 3)
       (char=? #\. (string-ref str (- L 3)))))
 
(provide (contract-out
          ; convert a random number to a string
          [format-number (-> number? string?)]
 
          ; convert an amount into a string with a decimal
          ; point, as in an amount of US currency
          [format-nat (-> natural-number/c
                          (and/c string? has-decimal?))]))

(define (format-number num)
  "OK")
(define (format-nat num)
  "OK")

#lang rosette

(require rosette/lib/synthax)
(require rosette/lib/angelic)

(define (static) (choose 1 2 3))
(define (dynamic) (choose* 1 2 3))


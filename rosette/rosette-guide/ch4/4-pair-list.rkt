#lang rosette

; Section 4.6: Pairs and Lists

(define-symbolic x y z n integer?)
(define xs (take (list x y z) n)) ; xs is a symbolic list

(define sol
  (solve (assert null? xs)))
(evaluate xs sol)
(evaluate n sol)

(define sol2
  (solve
   (begin
     (assert (= (length xs) 2))
     (assert (not (equal? xs (reverse xs))))
     (assert (equal? xs (sort xs <))))))
(evaluate xs sol2)

(define-symbolic b boolean?)
(define p (if b (cons 1 2) (cons 4 #f))) ; p is a symbolic pair

(define sol3
  (solve (assert (boolean? (cdr p)))))
(evaluate p sol3)

(define sol4
  (solve (assert (odd? (car p)))))
(evaluate p sol4)

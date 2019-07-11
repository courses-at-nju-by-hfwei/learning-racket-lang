; 7.2.6: Contract Messages with "???"

(module improved-bank-server racket
    (provide
     (contract-out
      [deposit (-> (flat-named-contract
                    'amount
                    (λ (x)
                      (and (number? x) (integer? x) (>= x 0))))
                   any)]))
  
    (define total 0)
    (define (deposit a) (set! total (+ a total))))
; @secref["Interpretations" #:doc '(lib "ocelot/scribblings/ocelot.scrbl")]

#lang rosette
(require ocelot)

; The Cat Example in the Ocelot Docs.

; Define the universe (of discourse)
(define U (universe '(a b c d)))

; Declare a cats relation and create an interpretation for it
(define cats (declare-relation 1 "cats"))
(define bCats (make-upper-bound cats '((a) (b) (c) (d))))
(define allCatBounds (bounds U (list bCats)))
(define iCats (instantiate-bounds allCatBounds))

; Find an interesting model for the cats relation
(define F (and (some cats) (some (- univ cats))))
(define resultCats (solve (assert (interpret* F iCats))))
; (sat? resultCats)

; Lift the model to lists of tuples for each relation
(define catsModel (interpretation->relations (evaluate iCats resultCats)))
(hash-ref catsModel cats)
; @other-doc['(lib "ocelot/scribblings/ocelot.scrbl")]

#lang rosette
(require ocelot)

; Section 1.1:
; Section 1.1.1: Universe of discourse
(define U (universe '(a b c d)))

; Section 1.1.2: Relation declarations
(define File (declare-relation 1 "File"))
(define Dir (declare-relation 1 "Dir"))
(define contents (declare-relation 2 "contents"))

; Section 1.1.3: Constraints over relations
(define DirsAndFiles (+ File Dir))
(define nonEmptyDir (some (join Dir contents)))
(define acyclic (no ([d Dir]) (in d (join d (^ contents)))))

; Section 1.2: Defining bounds on relations
(define bDir (make-exact-bound Dir '((a))))
(define bFile (make-bound File '((b)) '((b) (c) (d))))
(define bContents (make-product-bound contents '(a b c d) '(a b c d)))
(define allBounds (bounds U (list bDir bFile bContents)))

; Section 1.3: Checking Relational Specifications

; There is a model in which a directory is non-empty
(define nonEmptyDirFormula (interpret nonEmptyDir allBounds))
(define nonEmptyDirSolve (solve (assert nonEmptyDirFormula)))
; There is a counterexample to acyclicity
(define acyclicFormula (interpret acyclic allBounds))
(define acyclicVerify (verify (assert acyclicFormula)))

; Obtain models
(define iFileDir (instantiate-bounds allBounds))
(define resultFileDir (solve (assert (interpret* nonEmptyDir iFileDir))))
; (sat? resultFileDir)
(define fileDirModel (interpretation->relations (evaluate iFileDir resultFileDir)))
(define f (hash-ref fileDirModel File))
(define d (hash-ref fileDirModel Dir))
(define c (hash-ref fileDirModel contents))
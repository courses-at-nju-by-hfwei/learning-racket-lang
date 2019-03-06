; Quick: An Introduction to Racket with Pictures; by Matthew Flatt
; https://docs.racket-lang.org/quick/index.html

#lang slideshow
(define c (circle 10))
(define r (rectangle 10 20))

(define (square n)
  (filled-rectangle n n))

(define (four p)
  (define two-p (hc-append p p))
  (vc-append two-p two-p))

; let binds many identifiers at once.
(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))

; let* allows later bindings to use earlier bindings
(define (checkerboard p)
  (let* ([rp (colorize p "red")]
         [bp (colorize p "black")]
         [c (checker rp bp)]
         [c4 (four c)])
    (four c4)))

; Since functions are values, you can define functions that accept other functions as arguments
(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))

; lambda function which creates an anonymous function
; (series (lambda (size) (checkerboard (square size))))

; lexical scope
(define (rgb-series mk)
  (vc-append
   (series (lambda (sz) (colorize (mk sz) "red")))
   (series (lambda (sz) (colorize (mk sz) "green")))
   (series (lambda (sz) (colorize (mk sz) "blue")))))

; list
; (list (circle 10) (square 10))

; list map
(define (rainbow p)
  (map (lambda (color)
         (colorize p color))
       (list "red" "orange" "yellow" "green" "blue" "purple")))
; modules
(require pict/flash)

; macros
(require slideshow/code)

; objects
(require racket/class
         racket/gui/base)
(define f (new frame% [label "My Art"]
                      [width 300]
                      [height 300]
                      [alignment '(center center)]))
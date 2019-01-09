;a; implement this algorithm as a procedure  reduce-terms  that takes two term
;lists  n  and  d  as arguments and returns a list  nn,dd,  which are n and d
;reduced to lowest terms via the algorithm given above. also write a procedure
;reduce-poly, analogous to add-poly, that checks to see if the two polys have
;the same variable. if so reduce-poly strips off the variable and passes the
;problem to reduce-terms , then reattaches the variable to the two term lists
;supplied by reduce-terms.

;b; define a procedure analogous to reduce-terms that does what the original
;make-rat  did for integers

(define (reduce-integers n d)
  (let ((g (gcd n d)))
   (list (/ n g) (/ d g))))

;and define reduce as a generic operation that calls apply-eneric to dispatch to
;either reduce-poly or reduce-integers. you can now easily make the
;rational-arthmetic package reduce fractions to lowest terms by having make-rat
;call reduce before combining the given numertor and denominator to form a
;rational number. the system now handles rational expressions in either integers
;or polynomials. to test your program, try the example at the beginning of this
;extended exercise:

(define p1 (make-polynomial 'x '((1 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1) (0 -1))))

(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(add rf1 rf2)

;see if you get the asnwer correctly reduced to lowest terms


(define (reduce-terms n d)
  (let ((gcdterms (gcd-terms n d)))
   (list (car (div-terms n gcdterms))
         (car (div-terms d gcdterms)))))

(define (reduce-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (let ((result (reduce-terms (term-list p1) (term-list p2))))
     (list (make-poly (variable p1) (car result))
           (make-poly (variable p1) (cadr result))))
    (error "Not the same variable -- REDUCE-POLY" (list p1 p2))))

;modify the rational-arithmetic package to use generic operations, but change
;make-rat so that it does not attempt to reduce fractions to lowest terms. test
;your system by calling make-rational on two polynomials to produce a rational
;function

(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))

;now add rf to itself using add, you will observe that this addition procedure
;does not reduce fractions to lowest terms

;we can educe polynomial fractions to lowest terms using the same idea we used
;with integers: modifying make-rat to divide both the numeratoir and the
;denominator by their greatest common divisor. the notion of gcd makes sense for
;polynomials infact we can compute the gcd of two polynomials using essentially
;the same euclids algorithm that works for integers. the integer version is

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

;using this we could make the obvious modifications to define a gcd operation
;that works on term lists

(define (gcd-terms a b)
  (if (empty-termlist? b)
    a
    (gcd-terms b (remainder-terms a b))))

;where remainder-terms picks out the remainder componenet of the list returned
;by theterm-list division operation div-terms that was implemented in exersize
;2.91
;
;uhh sure dont care, 
(define (greatest-common-divisor a b)
  (apply-generic 'greatest-common-divisor a b))
;(put 'greatest-common-divisor '(scheme-number scheme-number) gcd)
(define (remainder-terms p1 p2)
  (cadr (div-terms p1 p2)))
(define (gcd-terms a b)
  (if (empty-termlist? b)
    a
    (gcd-terms b (remainder-terms a b))))
(define (gcd-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (gcd-terms (term-list p1)
                          (term-list p2)))
    (error "not the same variable -- GCD-POLY" (list p1 p2))))
;(put 'greatest-common-divisor '(polynomial polynomial)
;     (lambda (a b)(tag (gcd-poly a b))))

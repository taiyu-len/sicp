;using div-terms, implement the procedure remainder-terms and use this to define
;gcd-terms as above. now write a procedure gcd-poly that computes the polynomial
;gcd of two polys. (the procedure should signal an error if the two polys are
;not in the same vairbale.) isntall in the system a generic operation
;greatest-common-divisor that reduces to gcd-poly for polynomials and to
;ordinary gcd for ordinary numbers. as a test,try

(define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))
;(greatest-common-divisor p1 p2)


;change the return from div-terms to include both then get the car from it.
;this is the remainder
;

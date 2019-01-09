;define a generic equality predicate equ? that tests the equality of two numbers
; and install it in the generic arithmetic package. this operation should work
; for ordinary numbers, rational numbers, and complex numbers

;(put 'equ? '(scheme-number scheme-number)
;  (lambda (x y)(= x y)))
;(put 'equ? '(rational rational)
;  (lambda (x y)
;    (= (* (numer x)(denom y))
;       (* (numer y)(denom x)))))
;(put 'equ? '(complex complex)
;  (lambda (x y)
;    (and (= (real-part x)
;            (real-part y))
;         (= (imag-part x)
;            (imag-part y)))))
;(put 'equ? '(scheme-number rational) (lambda (x y) #f))
;(put 'equ? '(rational scheme-number) (lambda (x y) #f))
;(put 'equ? '(scheme-number complex) (lambda (x y) #f))
;(put 'equ? '(complex scheme-number) (lambda (x y) #f))
;(put 'equ? '(rational complex) (lambda (x y) #f))
;(put 'equ? '(complex rational) (lambda (x y) #f))
;
;
;

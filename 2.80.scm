;define a generic predicate =zero? that tests if its argument is zeor and
;install it in the generic arithmetic package. this operation should work for
;ordinary numbers, rational and complex

;(put '=zero? 'scheme-number zero?)
;(put '=zero? 'rational
;  (lambda (x)(zero? (numer x))))
;(put '=zero? 'complex
;  (lambda (x)
;    (and (zero? (real-part x))
;         (zero? (imag-part x)))))

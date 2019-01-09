;install =zer? for polynomials in the generic arithmetic package. this will
;allow adjoin-term to work for polynomials with coefficients that are themselves
;polynomials
;

;(put '=zero? 'scheme-number zero?)
;(put '=zero? 'rational
;  (lambda (x)(zero? (numer x))))
;(put '=zero? 'complex
;  (lambda (x)
;    (and (zero? (real-part x))
;         (zero? (imag-part x)))))
;(put '=zero? 'polynomial
;  (lambda (x)
;    (if (empty-termlist? x)
;      #t
;      (if (zero? (coeff (first-term x)))
;        (=zero? (rest-terms x))
;        #f))))


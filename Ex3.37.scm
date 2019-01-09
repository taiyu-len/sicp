;the celsius-fahrenheit-converter procedure is cumbersome when compared with a
;more expression-oriented style of definition, such as

;here c+,c*,etc are the constraint version of the arithmetic operations.
;forexample, c+ takes two connectors as arguments and returns a connector that
;is related to these by an adder constraint:

(define (c+ x y)
  (let ((z (make-connector)))
   (adder x y z)
   z))

;define analogous  procedures c-,c*,c/, and cv(constant vlaue) that enable us to
;define compound contraints as in the converter example above

(define (c- x y);x-y=z -> z+y=x
  (let ((z (make-connector)))
    (adder z y x)
    z))
(define (c* x y)
  (let ((z (make-connector)))
   (multiplier x y z)
   z))
(define (c/ x y);x/y=z -> z*y = x
  (let ((z (make-connector)))
   (multiplier z y x)
   z))
(define (cv x)
  (let ((z (make-connector)))
   (constant x z)
   z))





(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))
(probe "Celsius Temp" C)
(probe "Fahrenheit Temp" F)

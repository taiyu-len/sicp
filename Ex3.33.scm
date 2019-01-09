;using primitive multiplier, adder, and constant constraints, define a procedure
;averager that takes three connectors a,b, and c and establishes the constraint
;that the value of c is the average of the values of a and b

;1/2 (a+b) = c

(define (averager a b c)
  (let ((sum (make-connector))
        (half (make-connector)))
    (adder a b sum)
    (multiplier half sum c)
    (constant 0.5 half)))


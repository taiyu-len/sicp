;internal definitions
;
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-ter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve-guess))))
  (sqrt-iter 1.0))


;3.11

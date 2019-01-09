;designa a machine to compute square roots using newton's method, as described
;in section 1.1.7;

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

;begin by assuming that good-enough? and improve are available as primitives.
;then show how to expand these in terms of arithmetic operations. describe each
;version of the sqrt machine design by drawing a data-path diagram and writing
;a controller definition in the register machine language.

;use the series

;ln2 = 1 - 1/2 + 1/3 - 1/4 + 1/5 -....

;to compute three sequences of approximations to the natural logarithm of 2, in
;the same way we did above for \pi. how rapidly do these sequences converge?

(define (ln-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln-summands (+ n 1)))))

(define ln2
  (partial-sums (ln-summands 1)))



;consider the sequence of expressions

(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y   (stream-filter even? seq))
(define z   (stream-filter (lambda (x) (= (remainder x 5) 0))
                           seq))

;(stream-ref y 7);returns 136, sum is same
;(display-stream z);draws all outputs divisible by 5. sum=210 (might be cause of 
;memo again thou)

;sum is 
;y is '

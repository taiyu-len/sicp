;with power series represetned as streams of coefficients as in exercise 3.59,
;adding series is implemented by add-streams complete hte definition of the
;following procedure for multiplying series

(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (scale-stream (stream-cdr s2)
                               (stream-car s1))
                 (mul-series (stream-cdr s1) s2))))


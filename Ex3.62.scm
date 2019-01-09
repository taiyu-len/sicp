;use the result of exercises 3.60 and 3.61 to define a procedure div-series that
;divides two power series. div-series should work for any two series, provided
;that the denominator series begins with a nonezro constant term, (if the
;denominator has a zero constant, then div-series should signal an error.) show
;how to use div-series together with the result of exercies 3.59 to gerneate the
;pwoer series for tanger.

(define (div-series s1 s2)
  (let ((c (stream-car s2)))
   (if (= c 0)
     (error "Division By Zero!")
     (scale-stream (mul-series s1
                               (invert-unit-series (scale-stream s2 (/ 1 c))))
                   (/ 1 c)))))

(define tane-series (div-series sine-series cosine-series))

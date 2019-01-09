;the integral procedure used above was analogous to the "implicit" definition of
;the infinite stream of integers in section 3.5.2. alternatively, we can give a
;definition of integral that is more like integersStartingFrom

(define (Integral integrand initial dt)
  (cons-stream initial
               (if (stream-null? integrand)
                 the-empty-stream
                 (integral (stream-cdr (force integrand))
                           (+ (* dt (stream-car (force integrand)))
                              initial)
                           dt))))

;when used in sstems with loops, this procedure has the same problem as does our
;original version of integral. modify the procedure so that it expects the
;integrand as a delayed argument and hence can be used in the solve procedure
;above.
;

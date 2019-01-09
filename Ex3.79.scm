;generalize the solve-2nd  procedure of exercise 3.78 so that it can be used to
;solve general second-order differential equations
;d^2y/dt^2 = f(dy/dt,y)

(define (solve-2nd f y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay dyy) dy0 dt))
  (define ddy (stream-map f y dy))
  y)


;streams and delayed evalutation

;(define int
;  (cons-stream initial-value
;               (add-streams (scale-stream integrand dt)
;                            int)))

;(define (solve f y0 dt)
;  (define y (integral dy y0 dt))
;  (define dy (stream-map f y))
;  y)

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                  (add-streams (scale-stream integrand dt)
                              int))))
  int)

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(load "/home/project/scheme/Ex3.74.scm")
(load "/home/project/scheme/Ex3.75.scm")
(load "/home/project/scheme/Ex3.76.scm")
(load "/home/project/scheme/Ex3.77.scm")
(load "/home/project/scheme/Ex3.78.scm")
(load "/home/project/scheme/Ex3.79.scm")
(load "/home/project/scheme/Ex3.80.scm")


;exploiting the stream paradigm
(define average (lambda (x y) (/ (+ x y)2)))
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))
(define pi-stream
  (scale-stream (partial-sums (pi-summands 1))4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (<+combine_in_some_way>
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define (stream-append s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
  (if (stream-null? s1)s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))



(load "/home/project/scheme/Ex3.61.scm")
(load "/home/project/scheme/Ex3.62.scm")
(load "/home/project/scheme/Ex3.63.scm")
(load "/home/project/scheme/Ex3.64.scm")
(load "/home/project/scheme/Ex3.65.scm")
(load "/home/project/scheme/Ex3.66.scm")
(load "/home/project/scheme/Ex3.67.scm")
(load "/home/project/scheme/Ex3.68.scm")
(load "/home/project/scheme/Ex3.69.scm")
(load "/home/project/scheme/Ex3.70.scm")
(load "/home/project/scheme/Ex3.71.scm")
(load "/home/project/scheme/Ex3.72.scm")



(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int))))



(load "/home/project/scheme/Ex3.73.scm")


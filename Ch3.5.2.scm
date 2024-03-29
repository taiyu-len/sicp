;infinite streams

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y)0))
(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7)))
                 integers))

(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter
             (lambda (x)
               (not (divisible? x (stream-car stream))))
             (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define integers (cons-stream 1 (add-streams ones integers)))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))stream))

(define double (cons-stream 1 (scale-stream double 2)))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps))n)#t)
          ((divisible? n (stream-car ps))#f)
          (else (iter (stream-cdr ps)))))
  (iter primes))


(load "/home/project/scheme/Ex3.53.scm")
(load "/home/project/scheme/Ex3.54.scm")
(load "/home/project/scheme/Ex3.55.scm")
(load "/home/project/scheme/Ex3.56.scm")
(load "/home/project/scheme/Ex3.57.scm")
(load "/home/project/scheme/Ex3.58.scm")
(load "/home/project/scheme/Ex3.59.scm")
(load "/home/project/scheme/Ex3.60.scm")

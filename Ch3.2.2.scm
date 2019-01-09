;applying simple procedures

(define (square x)
  (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

;3.9
(load "/home/project/scheme/Ex3.9.scm")

;exhibit a program that you would expect to run much more slowly without
;memoization thatn with memoization. also conider the following intercation,
;where the id procedure is defined as in exercise 4.27 and count starts at 0;

(define (square x)
  (* x x))
;;input
;(square (id 10))
;;value
;100
;;input
;count
;;value
;1


;any program with a lot of repetitive computtion say something like fib1000
;called a dozen times.



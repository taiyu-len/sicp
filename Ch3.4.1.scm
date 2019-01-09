;the nature of time i concurrent systems

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount))
           balance)
    "insufficient funds"))
(load "/home/project/scheme/Ex3.38.scm")

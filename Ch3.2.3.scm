;frames as the repository of local state

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds")))

(define W1 (make-withdraw 100))

;3.10
(load "/home/project/scheme/Ex3.10.scm")
(load "/home/project/scheme/Ex3.11.scm")

;Local state variables

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount))
           balance)
    "Insufficient funds"))

(define new-withdraw
  (let ((balance 100))
   (lambda (amount)
     (if (>= balance amount)
       (begin (set! balance (- balance amount))
              balance)
       "Insufficient funds"))))

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds")))

(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw)withdraw)
          ((eq? m 'deposit )deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

(define acc (make-account 100))

(define acc2 (make-account 100))

;Exersize 3.1
(load "/home/project/scheme/Ex3.1.scm")
(load "/home/project/scheme/Ex3.2.scm")
(load "/home/project/scheme/Ex3.3.scm")
(load "/home/project/scheme/Ex3.4.scm")


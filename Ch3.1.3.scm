;the costs of introdcuing assingment
(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))
(define W (make-simplified-withdraw 25))

(define (make-decrementer balance)
  (lambda (amount)
    (- balance amount)))

(define D (make-decrementer 25))


(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
      product
      (iter (* counter product)
            (+ counter 1))))
  (iter 1 1))

(define (factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n)
        product
        (begin (set! product (* counter product))
               (set! counter (+ counter 1))
               (iter))))
    (iter)))

;(set! counter (+ counter 1))
;(set! product (* counter product))

;Ex3.7
(load "/home/project/scheme/Ex3.7.scm")
(load "/home/project/scheme/Ex3.8.scm")

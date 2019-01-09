;suppose we want to modify the differentation program so that it works with
;ordinary mathematical notation. in which + and * are infix rather then prefx
;operators. since the differenatiation program is defined in terms of abstract
;data, we cna modify it to work with different representations of expressions
;solely by changeing predicates, selectors, and constructors that define the
;represntation of the algebraic expressions on which the differentiator is to
;operate.

;a show how to do this in order to differentiate algebraic expreesions in infix
;form, such as (x + (3 * (x + (y + 2)))). to simplifyt assume that + and *
;always take two arugments and the epxressions are fully parenthesied

(define (make-sum a1 a2)
  ((cond ((=number? a1 0)a2)
         ((=number? a2 0)a1)
         ((and (number? a1) (number? a2)) (+ a1 a2))
         (else (list a1 '+ a2)))))
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define addend car)
(define augend caddr)

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0))0)
        ((=number? m1 1)m2)
        ((=number? m2 1)m1)
        ((and (number? m1) (number? m2)) (+ m1 m2))
        (else (list m1 '* m2))))
(define (product? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define multiplier car)
(define multiplicand caddr)


(define (make-exponent b e)
  (cond ((=number? b 0)0)
        ((=number? b 1)1)
        ((=number? e 0)1)
        ((=number? e 1)b)
        ((and (number? b) (number e)) (expt b e))
        (else (list b '^ e))))
(define (exponentiation? x)
  (and (pair? x) (eq? cadr x) '^))
(define base car)
(define exponent caddr)

; b the problem becmes substantially harder if we allow standar algrebraic
; notation such as (x + 3 * (x _ y _ 2)) which drops unnecessary parentheses and
; assumes that mulitplication is done before addition can you design appropriate
; predicates, selectors, and constructors for this notation such that our
; derivative program still works?


(define augend cddr)
(define multiplicand cddr)
(define (unparent? x)
  (and (null? (cdr x)) (pair? x)))

(define (deriv expr var)
  (cond ((unparent? expr)
         (deriv (car expr) var))
        ((variable? expr)
         (if (same-variable expr var)1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (mutliplicand expr) var))
           (make-product (deriv (multiplier expr))
                         (multiplicand))))
        ((exponentiation? expr)
         (make-product (exponent expr)
                       (make-exponent (base expr)
                                      (make-sum (exponent expr) -1))
                       (deriv (base expr) var)))
        (else (error "unrecognized expression -- " expr))))



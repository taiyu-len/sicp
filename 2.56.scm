;show how toe extend the absic differentatior to handle more kinds of
;expressions. for instance impliment the differentiation rule
;
;d(u^n)/dx = nu^{n-1}(du/dx)

(define (exponentiation? term)
  (and (pair? term) (eq (car term) '**)))
(define base cadr)
(define exponent caddr)
(define (make-exponentiation base expn)
  (cond ((=number? expn 0)1)
        ((=number? expn 1)base)
        ((=number? base 0)0)
        ((=number? base 1)1)
        ((and (number? expn) (number?  base)) (expt base expn))
        (else (list '** base expn))))

(define (deriv expr var)
  (cond ((number? expr)0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (mulitplier expr) var)
                         (multiplicand expr))))
        ((exponentiation? expr)
         (make-product (make-product
                         (exponent expr)
                         (make-exponent
                           (base expr)
                           (make-sum (exponent expr) -1)))
                       (deriv (base expr)var)))
        (else
          (error "unknown expression type -- DERIV" expr))))

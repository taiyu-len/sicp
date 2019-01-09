;section 2.3.2 described a program that performs symbolic differentiation
(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr)var)
                   (deriv (augend expr)var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr)var))
           (make-product (deriv (multiplier expr)var)
                         (multiplicand expr))))
        ;<more rules here>
        (else (error "unknown expression type -- DERIV" expr))))
;we can regard htis program as performing a dispath on the type of the
;expression to be differentiated. in this situation the "type-tag" of the datum
;is the algebraic operator symbol (such as +) and the operation being performed
;is deriv. we can transform this program into data-directed style by rewriting
;the basic derivation procedure as 
(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        (else ((get 'deriv (operator expr)) (operands expr)
                                            var))))
(define (operator expr) (car expr))
(define (operands expr) (cdr expr))

;a explain what was done above. why cant we assimilat the predicates number? and
;same-variable? into data-directed dispatch

;we could if we did '(number 2) '(variable x) but thats dumb so we keep is as 2
;and x cause no need do so otherwise

;b: write the procedures for derivatives of sums and products, and the auxiliary
;code required to install them in the table used by the program above.

(define (install-deriv-package)
  ;tagthem
  (define (tag t d) (cons t d))
  (define (tag-sum a) (tag '+ a))
  (define (tag-product m) (tag '* m))
  (define (tag-exponent b e) (tag '* (cons b e)))
  ;make-sum,product
  (define (make-sum . a)
    (let ((numbers (sum (filter number? a)))
          (rest (filter (lambda (x) (not (number? x)))a)))
      (cond ((null? rest)numbers)
            ((= numbers 0)
             (if (null? (cdr rest))
               (car rest)
               (tag-sum rest)))
            (else (tag-sum (append (list numbers) rest))))))
  ;product
  (define (make-product m)
    (let ((numbers (product (filter number? m)))
          (rest (filter (lambda (x) (not (number? x)))m)))
      (cond ((= numbers 0)0)
            ((= numbers 1)
             (if (null? (cdr rest))
               (car rest)
               (tag-product rest)))
            (else (tag-product (append (list numbers) rest))))))
  ;exponent
  (define (=number? a b)
    (and (number? a) (number? b) (= a b)))
  (define (make-exponent base expn)
    (cond ((=number? expn 0)1)
          ((=number? expn 1)base)
          ((=number? base 0)0)
          ((=number? base 1)1)
          ((and (number? expn) (number? base)) (expt base expn))
          (else (tag-exponent base expn))))
  ;selectors
  (define addend car)
  (define augend cdr)
  (define multiplier car)
  (define multiplicand cdr)
  (define base car)
  (define exponent cdr)
  ;derivition rules
  (define (deriv-sum expr var)
    (make-sum (deriv (addend expr) var)
              (deriv (augend expr) var)))
  (define (deriv-product expr var)
    (make-sum
      (make-product (multiplier expr)
                    (deriv (multiplicand expr) var))
      (make-product (deriv (multiplier expr) var)
                    (multiplicand expr))))
  (define (deriv-exponent expr var)
    (make-product
      (exponent expr)
      (make-exponent
        (base expr)
        (make-sum (exponent expr) -1))
      (deriv (base expr) var)))
  ;install it
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '^ deriv-exponent)
  'done)

;c; choose any additional differentaion rule that you like such as the one for
;exponent and install it into the data-directed system. 
;DONE
;d;in this simple algebraic manipulator the type of an expression is the
;algebraic operator that binds it together. suppose however, we indexed the
;procedure the opposite way, so that the dispatch line in deriv looked like
;((get (operator exp) 'deriv)(operands exp) var)
;what corresponding changes to the derivative system are required

;change (put 'deriv '+ deriv-sum) to (put '+ 'deriv deriv-sum)


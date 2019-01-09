;scheme allows an additional syntax for cond clauses (<test> => <recipient> if
;<test> evaluates to a true value, then recipient is evaluated. its value must
;be a procedure of one argument; this procedure is then invoked on the value of
;the <test>, and the result is returned as the value of the ocnd expession, for
;example

;returns 2. modify the handling of cond so that it supports this extended
;syntax.

(define (extended-cond-syntax? clause) (eq? (cadr clause) '=>))
(define (extended-cond-test clause) (car clause))
(define (extended-cond-recipient clause) (caddr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
    #f
    (let ((first (car clauses))
          (rest  (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isnt last -- COND->if" clauses))
        (let ((test (cond-predicate first))
              (recepient (if (eq? (car (cond-actions first))'=>)
                           (cadr (cond-actions first))
                           false)))
          (make-if test
                   (if recepient
                     (list recepient test)
                     (sequence->exp (cond-actions first)))
                   (expand-clauses rest)))))))

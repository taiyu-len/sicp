;the approach taken in this section is somwhat unpleasant, because it makes an
;incompatable change to scheme it imght be nicer to implment lazy evaluation as
;an upward compatable extension, that is, so that ordinary scheme programs will
;work as before. we can do this by extending the syntax of procedure
;declarations to let the user control whether or not arguments are to be
;delayed. while were at it we may as wel also give the user the choice between
;deaying with and without memoization. forexample, the definiton
'(define (f a (b lazy) c (d lazy-memo))
   ...)

;would define f to be aprocedure of four arguments, where the 1st and 3rd
;arguments are evaluated when the procedure is called, the second argument is
;delayed, and the fourth arugment is both delayed and momized. thus, ordinary
;procedure definitions will prodcue the same behavior as ordinary scheme. while
;adding the lazy-memo declaration to each parameter of every compound will
;produce the behaivior of the lazy evaluator defined in this seciton. design and
;implement the changes required to produce such an extension to scheme. you will
;have to implement new syntax procedures to handle the new syntax for define.
;you must also arrange for eval or apply to determine when arguments are to be
;delayed, and to force or delay arguments accordingly, you must arrange for
;forcing to memoize or not as appropriate.


(define (apply proc argc env)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure
           proc
           (list-of-arg-values args env)))
        ((compound-procedure? proc)
         (eval-compound-procedure proc args env))
        (else
          (error "9:Unknown procedure type -- APPLY" procedure))))

(define (eval-compound-procedure proc args env)
  (define (iter-args formal-args actual-args)
    (if (null? formal-args)
      '()
      (cons
        (let ((this-arg (car formal-args)))
         (if (and (pair? this-arg)
                  (eq? (cadr this-arg)'lazy))
           (delay-it (car actual-args) env)))
        (iter-args (cdr formal-args) (cdr actual-args)))))
  (define (procedure-arg-names parameters)
    (map (lambda (x) (if (pair? x) (car x) x))parameters))
  (eval-sequence
    (procedure-body proc)
    (extend-environment
      (procedure-arg-names (procedure-parameters proc))
      (iter-args
        (procedure-parameters proc)
        args)
      (procedure-environment proc))))



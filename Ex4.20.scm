;because internal definitons look sequential but are actually simultaneous, some
;people prefer to avoid them entirely, and use the special form letrec isntead.
;letrec looks like let, so it is not suprising that the variabes it binds are
;bound simultaeously and have the same scope as eachother. the sample procedure
;f above can be written without internal definitions, but with exactly the same
;meaning as

(define (f x)
  (letrec ((even?
             (lambda (n)
               (if (= n 0)
                 #t
                 (odd? (- n 1)))))
           (odd?
             (lambda (n)
               (if (= n 0)
                 #f
                 (even? (- n 1))))))
    <rest_of_body_of_f>))

;letrec expressions,which have the form

'(letrec ((<var1><exp1>) ... (<varn><expn>))
   <body>)

;are a variation on let in which the expressions <expk> that provide the initial
;values for the variables <vark> are evaluated in an environment that includes
;all the letrec bindings. this permits recursion in the bindings, such as the
;mutual recursion of even? and odd? in the examples above, or the evaluation of
;10 factorial with

'(letrec ((fact
            (lambda (n)
              (if (= n 1)
                1
                (* n (fact (- n 1)))))))
   (fact 10))

;implement letrec as a derived expression by transforming a letrec expression
;into a let expression as shown in the text above or in exercise 4.18. that is,
;the letrec variables should be created with a let and then be assigned their
;vlaues with set!.

(define (letrec? exp) (tagged-list? exp 'letrec))
(define (letrec-init exp) (cadr exp))
(define (letrec-body exp) (cddr exp))
(define (declare-variables exp)
  (map (lambda (x) (list (car x) '*unassigned*))
       (letrec-init exp)))
(define (set-variables exp)
  (map (lambda (x) (list 'set! (car x) (cadr x)))
       (letrec-init exp)))
(define (letrec->let exp)
  (list 'let (declare-variable exp)
        (make-begin (append (set-variables exp) (letrec-body exp)))))
(put 'eval 'letrec (lambda (exp env)
                     (eval (letrec->let exp) env)))


;b; louis reasoner is confused by all this fuss about internal definitons. the
;way he sees it. if you dont like to use define inside a procedure, you can just
;use let. illustrate what is loose about his reasoning by drawing an
;environement diagram that shows environment in which the <rest of body of f> is
;evaluated during evaluation of the xexpression (f 5), with f defined as in this
;exercise. draw na environment diagram for the same evaluation, but with let in
;place of letrec in the definition of f.
;cant recursivly call



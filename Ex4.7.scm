;let* is similar to let, except that hte bindings of the let variables are
;performed sequentially from left to right, and each binding is made in an
;enciroemnt in which all of the preceding bindings are visiable


;returns 39, explain how a let* expession can be rewrittin as a set of nested
;let expessions, and write a procedure let*->nested-lets  htat performs this
;transofmaiton. if we have already implemented let and we want to extend the
;evalutator to handle let*, is it sufficient to add a clause to eval whose
;action is 
;(eval (let*->nested-lets exp)env)
;or must we explicitly expand let* in terms of non-derived expessions.


(define (let*? exp) (tagged-list? exp 'let*))
;use the same var,body,exp from let
(define (let*-var exp) (caadr exp))
(define (let*-exp exp) (car(cdaadr exp)))

(define (let*->nested-lets var exp body)
  (if (null? var)
    body
    (list 'let
          (list (list (car var)
                      (car exp)))
          (let*->nested-lets (cdr var) (cdr exp)))))

(define (eval-let* exp env)
  (eval (let*->nested-lets (let-vars exp)
                           (let-exp exp)
                           (let-body exp))
        env))
;welll seems like i could do it.

(put 'eval 'let* eval-let*)

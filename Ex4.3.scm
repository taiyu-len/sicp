;rewrite eval os that the dispatch is done in data-directed style. compare this
;with the data-directed differentiation procedure of exerisize 2.73. (you may
;use the car of a compound expession as the type of the expession. as is
;appropriate for the syntax implemented in this section
(load "/home/project/scheme/table.scm")
(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
(put 'eval 'set!  eval-assignment)
(put 'eval 'define eval-definition)
(put 'eval 'if eval-if)
(put 'eval 'lambda (lambda (exp env)
                     (make-procedure (lambda-parameters exp)
                                     (lambda-body exp)
                                     env)))
(put 'eval 'begin (lambda (exp env) (eval-sequence (begin-sequence exp) env)))
(put 'eval 'cond  (lambda (exp env) (eval (cond->if exp) env)))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((get 'eval (car exp)) ((get 'eval (operator exp)) exp env))
        ((application? exp) (apply (eval (operator exp)env)
                                   (list-of-values (operands exp) env)))
        (else
          (error "Unknown expession type -- EVAL" exp))))


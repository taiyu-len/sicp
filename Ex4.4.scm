;recall the definitions of the special forms and and or from chapter 1:

;;;and:the expessions are evaluated from left to right. if any expession
;evaluates to false, false is returnd: any remaining expessions are not
;evaluated. if all the expessions evaluate to true values, then the vlaue of
;the last expession is returned. if there are no expessions then true is
;returned.

;;;or: the expesiions are evaluated from left ot right. if any expesion
;evaluates to true value, that value is returned; any remaining expessions are
;not evaluated. if all expessions evaluate to false, or if there are no
;expessions, false is returned.

;install and and or as nor special forms for the evaluator by defining
;appropriate syntax procedure and evaluation procedures eval-and and eval-or.
;alternatively, show how to omplement and and or as a derived expession

(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))


(define (eval-and exp env)
  (let ((first (eval (first-exp exp)env)))
    (cond ((last-exp exp)
           (if first first #f))
          (else
            (if first
              (eval-and (rest-exps exp)env)
              #f)))))

(define (eval-or exp env)
  (let ((first (eval (first-exp exp)env)))
    (cond ((last-exp exp)
           (if first #t #f))
          (else
           (if first
             #t
             (eval-or (rest-exps exp)env))))))

(put 'eval 'and eval-and)
(put 'eval 'or  eval-or)


;many languages support a variety of iteration constructs, such as do,for,while,
;and until. in scheme, iterative processes can be expessed in terms of ordinary
;procedure calls, so special iteration construct provide no essential gain in
;computational power. on the other hand, such constructs are often convenient.
;design some iteration constructs give examples of their use, and show how to
;implement them as derived expessions


'(while predicate procedure)

(define (while? exp) (tagged-list? exp 'while))
(define (while-pred exp) (cadr exp))
(define (while-proc exp) (caddr exp))
(define (eval-while exp env)
  (if (eval (while-pred exp) env)
    (begin
      (eval (while-proc exp) env)
      (eval-while exp env))))

(put 'eval 'while eval-while)

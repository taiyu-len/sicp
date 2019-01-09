;when we defined the evaluation model in section 1.1.3 we said that the first
;step in evaljuating an expression is to evaluate its subexpressions. but we
;never specified the order in which the subexpressions should be evaluated. when
;we introduce assignement, the order in which the arguments to a procedure are
;evaluated can make a difference to the result, define a simple procedure f such
;that (+ (f 0)(f 1)) will return 0 if the arguments to + are evaluated from left
;to right but will return 1 if the arguments are evaluated from right to left.

(define f
  (let ((x 0))
  (lambda (y)
    (set! x (if (= x 0) 1 0))
    (* x y))))

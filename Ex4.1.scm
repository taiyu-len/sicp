;notice that we cannot tell whether the metacircular evaluator evaluates
;operands rom left to right or from right to left. its evaluation order is
;inherited from the underlying lisp: if the arguments to cons in list of-values
;are evaluated from left to right, then list-of-values will evaluate operands
;from left to right: and if the arguments to cons are evaluated from right to
;left, then list-of-values will evaluate operands from right to left.

;write a version of list-of-values that evaluates operands from left-to-right
;regardless of the order of evaluation in the underlying lisp. also write a
;version of list-of-values that evaluates operands from right to left

(define (list-of-values-LR)
  (if (no-operands? exps)
    '()
    (let ((left (eval (first-operand exps)env))
          (right (eval (list-of-values (rest-operands exps)env))))
      (cons left right))))
(define (list-of-values-RL)
  (if (no-operands? exps)
    '()
    (let ((left (eval (list-of-values (rest-operands exps)env)))
          (right (eval (first-operand exps)env)))
      (cons left right))))



;eval uses actual-value rather than eval to evaluate the operator before passing
;it to apply, in order to force the value of the operator. give an example that
;demonstrates the need for this forcing

;(+ (fib n)(fib (+ n 1)))

;if we had not realized that require could be implemented as an odinary
;procedure that uses amb, to be defined by the user as part of a
;nondeterministic program, we wouuld have to implement it as a special form.
;this would require syntax procedures.

(define (require? exp) (tagged-list? exp 'require))
(define (require-predicate exp) (cadr exp))
;and a new clause in the dispatch in analyze

(define (analyze-require exp)
  (let ((pproc (analyze (require-predicate exp))))
   (lambda (env succeed fail)
     (pproc env
            (lambda (pred-value fail2)
              (if (not (true? pred-value))
                (fail2)
                (succeed 'ok fail2)))
            (fail)))))

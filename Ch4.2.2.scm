;an interpreter with lazy evaluation
(
 )



(define (actual-value exp env)
  (force-it (eval exp env)))

(define (apply proc args env)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure
           proc
           (list-of-arg-values args env)))
        ((compound-procedure? proc)
         (eval-sequence
           (procedure-body proc)
           (extend-environment
             (procedure-parameters proc)
             (list-of-delayed-args args env)
             (procedure-environment proc))))
        (else
          (error
            "Unknown procedure type -- APPLY" procedure))))

(define (list-of-arg-values exps env)
    (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps)env)
            (list-of-arg-values (rest-operands exps)
                                env))))
(define (list-of-delayed-args exps env)
  (if (no-operands? exps)
    '()
    (cons (delay-it (first-operand exps) env)
          (list-of-delayed-args (rest-operands exps)
                                env))))

(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp)env))
    (eval (if-consequent exp)env)
    (eval (if-alternative exp)env)))

(define input-prompt ";;;L-eval input:")
(define output-prompt ";;;L-eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
   (let ((output
           (actual-value input the-global-environment)))
     (announce-output output-prompt)
     (user-print output)))
  (driver-loop))

(define the-global-environment (setup-environment))

(define (force-it obj)
  (if (thunk? obj)
    (actual-value (thunk-exp obj) (thunk-env obj))
    obj))

(define (delay-it exp env)
  (list 'thunk exp env))

(define (thunk? obj)
  (tagged-list? obj 'thunk))
(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))
(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))
(define (thunk-value evaluated-thunk) (cadr evaluated-thunk))
(define (force-it obj)
  (cond ((thunk? obj)
         (let ((result (actual-value
                         (thunk-exp obj)
                         (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj)result)
           (set-cdr! (cdr obj)'())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))



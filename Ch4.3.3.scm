;; Analyzer

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
(define (variable? exp) (symbol? exp))
(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (car exp) tag)
    false))
(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
    (cadr exp)
    (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
    (caddr exp)
    (make-lambda (cdadr exp)
                 (cddr exp))))
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameter body)
  (cons 'lambda (cons parameter body)))
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (null? (cdddr exp))
    'false
    (cadddr exp)))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq)seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause)'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isnt last -- COND->IF" clauses))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))


(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((amb? exp) (analyze-amb exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond-if exp)))
        ((application? exp) (analyze-application exp))
        (else
          (error "1:Unknown expression type -- ANALYZE"))))


;;AMB evaluator

(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))
(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))

(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))
(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
   (lambda (env succeed fail)
     (succeed qval fail))))

(define (analyze-variable exp)
  (lambda (env succeed fail)
    (succeed (lookup-variable-value exp env)
             fail)))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env succeed fail)
      (succeed (make-procedure vars bproc env)
               fail))))

(define (analyze-if exp)
  (let ((proc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             ;;sucess continuations for evaluating the predicate to obtain the
             ;;pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                 (cproc env succeed fail2)
                 (aproc env succeed fail2)))
             ;;failure continutation for evaluating the predicate
             fail))))

(define (analyze-sequence exps)
  (define (sequentially a b)
    (lambda (env succeed fail)
      (a env
         ;; success continutation for calling a
         (lambda (a-value fail2)
           (b env succeed fail2))
         ;;failure for calling a
         fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
      first-proc
      (loop (sequentially first-proc (car rest-procs))
            (cdr rest-procs))))
  (let ((procs (map analyze exps)))
   (if (null? procs)
     (error "Empty sequence -- ANALYZE"))
   (loop (car procs) (cdr procs))))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (define-variable! var val env)
               (succeed 'ok fail2))
             fail))))

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (let ((old-value
                       (lookup-variable-value var env)))
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()
                            (set-variable-value! var old-value env)
                            (fail2)))))
             fail))))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succeed fail)
      (fproc env
             (lambda (proc fail2)
               (get-args aprocs
                         env
                         (lambda (args fail3)
                           (execute-application
                             proc args succeed fail3))
                         fail2))
             fail))))

(define (get-args aprocs env succeed fail)
  (if (null? aprocs)
    (succeed '() fail)
    ((car aprocs) env
                  ;;success continuation for this aproc
                  (lambda (arg fail2)
                    (get-args (cdr aprocs)
                              env
                              ;;success continuation for recursive
                              ;;call to get-args
                              (lambda (args fail3)
                                (succeed (cons arg args)
                                         fail3))
                              fail2))
                  fail)))

(define apply-in-underlying-scheme apply)
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
    (primitive-implementation proc)args))
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cdr proc))


(define (execute-application proc args succeed fail)
  (cond ((primitive-procedure? proc)
         (succeed (apply-primitive-procedure proc args)
                  fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))
          succeed
          fail))
        (else
          (error "Unknown procedure type -- EXECUTE-APPLICATION" proc))))

(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
   (lambda (env succeed fail)
     (define (try-next choices)
       (if (null? choices)
         (fail)
         ((car choices)
          env
          succeed
          (lambda ()
            (try-next (cdr choices))))))
     (try-next cprocs))))

(define input-prompt  ";; Amv-Eval input:")
(define output-prompt ";; Amv-Eval value:")
(define (prompt-for-input string)
  (newline) (display string) (newline))
(define (announce-output string)
  (newline) (display string) (newline))
(define (user-print obj)
  (if (compound-procedure? obj)
    (display (list 'compound-procedure
                   (procedure-parameters obj)
                   (procedure-body obj)
                   '<procedure-env>))
    (display obj)))

;;Environment Functions
(define (make-frame vars vals)
  (map cons vars vals))
(define (env-empty? env)
  (eq? the-empty-environment env))

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
(define (make-frame vars vals)
  (map cons vars vals))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (cdr (scan-env var env)));returns variables value

(define (define-variable! var value env)
  (let ((result (scan-frame var (first-frame env))))
   (if result
     (set-var! result value)
     (add-binding-to-env! var value env))))

(define (set-variable-value! var value env)
  (set-var! (scan-env var env) value))

(define (scan-frame var frame);#f on fail, pair on success
  (assoc var frame))

(define (scan-env var env);error on fail, pair on success
  (if (env-empty? env) (error "Unbound Variable" var)
    (let ((result (scan-frame var (first-frame env))))
      (if result result (scan-env var (enclosing-environment env))))))

(define (set-var! var value);'(a old) => '(a value)
  (set-cdr! var value))

(define (add-binding-to-env! var value env)
  (set-car! env (cons (cons var value) (first-frame env))))


;; Set up Environment

(define primitive-procedures
  (list (cons 'car car) (cons 'cdr cdr) (cons 'cons cons)
        (cons 'pair? pair?) (cons 'null? null?)
        (cons '+ +)(cons '- -)(cons '* *)(cons '/ /)
        (cons '< <)(cons '> >)(cons '= =)
        (cons '<= <=)(cons '>= >=)))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (cons 'primitive (cdr proc)))
       primitive-procedures))
(define the-empty-environment '())
(define (setup-environment)
  (let ((initial-env
          (extend-environment (primitive-procedure-names)
                              (primitive-procedure-objects)
                              the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

;; Setup the evaluator

(define the-global-environment (setup-environment))

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
     (if (eq? input 'try-again)
       (try-again)
       (begin
         (newline)
         (display ";;Starting New problem")
         (ambeval input
                  the-global-environment
                  ;;ambeval success
                  (lambda (val next-alternative)
                    (announce-output output-prompt)
                    (user-print val)
                    (internal-loop next-alternative))
                  ;;Ambeval failure
                  (lambda ()
                    (announce-output
                      ";;There are no more values of")
                      (user-print input)
                      (driver-loop)))))))
  (internal-loop
    (lambda ()
      (newline)
      (display ";;; There is no current problem")
      (driver-loop))))

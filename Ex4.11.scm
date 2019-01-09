;instead of representing a frame as a pair of lists, we can represent a frame as
;a list of bindings, where each binding is a name-value pair. rewrite the
;environement operations to use this alternative representation

(define (make-frame vars vals)
  (map cons vars vals))
(define (env-empty? env)
  (eq? the-empty-environment env))

(define (lookup-variable-value var env)
  (define (scan-env env)
    (if (env-empty? env)
      (error "Unbound Variable -- LOOKUP" var)
      (let ((result (assoc var (first-frame env))))
       (if result
         (cadr result) ;'(a 1) returns 1
         (scan-env (enclosing-environment env))))))
  (scan-env env))

(define (define-variable! var value env)
  (let ((result (assoc var (first-frame env))))
   (if result
     (set-cdr! result);'(a old) => '(a value)
     (add-binding-to-env! var value env))))

(define (add-binding-to-frame! var value env)
  (set-car! env (cons (cons var value) (car env))))

(define (set-variable-value! var value env)
  (define (scan-env env)
    (if (env-empty? env)
      (error "Unbound Variable -- SET" var)
      (let ((result (assoc var (first-frame env))))
       (if result
        (set-cdr! result value)
        (scan-env (enclosing-environment env))))))
  (scan-env env))



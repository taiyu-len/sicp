;the procedures set-variable-value!, define-variable! and lookup-variable-value
;can be expessed in terms of more abstract procedures for traversing the
;environment structure. define abstractions that capture the common patters and
;redefine the three procedures in terms of these abstractions.

;enviroment
;'(envn ... env3 env2 env1)
;env contains a frame
;frame
;'((var val)(var val)(var val))


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

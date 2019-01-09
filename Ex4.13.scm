;scheme allows us to create new bindings for variables by means of define, but
;provides no way to get rid of binding. implement for the evaluator a special
;form  make-unbound!  that removes the binding of a given symbol from
;theenvironement in which the make-unbound! expession is evaluated. this
;problem is not completely specified. for example, should we remove only the
;binding in the first frame of the environment? complete the specification and
;justify any choices you make

;using stuff from Ex4.12.scm

(define (make-unbound! var env)
  (define (unbind frame)
    (cond ((null? frame) (error "Failed To Unbind Variable" var))
          ((eq? (caar frame) var)
           (cdr frame))
          (else
           (cond (car frame)
                 (unbind (cdr frame))))))
  (unbind (first-frame env)))

(put 'eval 'undefine make-unbound!)

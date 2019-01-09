;in this exerie we implement the method just described for interpreting interal
;defintions. we assume that hte evaluator supports let (see exercise 4.6)


;change lookup-variable-value to signal an error if the value it finds is the
;symbol *unassigned*

(define (lookup-variable-value var env)
  (let ((value (scan-env var env)))
   (if (eq? value '*unassigned*)
     (error "Value Unassigned")
     value)))

;write a procedure scan-out-defines that takes a procedure body an dreutns an
;equivalent one that has no internal definitions, by making the transformation
;described above.

(define (scan-out-defines body)
  (define (name-unassigned defines)
    (map (lambda (x) (list (definition-variable x)
                           '*unassigned*))
         defines))
  (define (set-values defines)
    (map (lambda (x)
           (list 'set! (definition-variable x)
                 (definition-value x)))
         defines))
  (define (defines->let exp defines not-defines)
    (cond ((null? exp)
           (if (null? defines)
             body
             (list (list 'let (name-unassigned defines)
                         (make-begin (append (set-values defines)
                                             (reverse not-defines)))))))
          ((definition? (car exp))
           (defines->let (cdr exp) (cons (car exp) defines)
                         not-defines))
          (else (defines->let (cdr exp)defines (cons (car exp)not-defines)))))
  (defines->let body '()'()))







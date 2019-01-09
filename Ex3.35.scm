;be bitdiddle tells louis that one way to avoid the trouble in exercise 3.34 is
;to define a squarer as a new primitive constraint. fill in the missing portions
;in bens outline for a procedure to implement such a constraint

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
        (error "square less then 0 -- SQUEARER" (get-value b))
        (set-value! a (sqrt (get-value b))))
      (set-value b (expt (get-value a) 2))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- MULTIPLIER" request))))
  (connect a me)
  (connect b me)
  me)

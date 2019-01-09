;ben and alyssa disagree over the importance of lazy evaluation for implementing
;things such as unless. ben points out that its possible to implement unless in
;applicative order as specialform. alyssa counters that, if on did that, unless
;would merely be syntax, not a procedure thatcould be used in conjunction with
;higher order procedures. fill in the details on both sides of the argument.
;show how to implement unless as a derived expression and give an example of a
;situation where it might be useful to have unless available as a procedure,
;rather then a special form


(define (unless? exp) (tagged-list? exp 'unless))
(define (unless-predicate exp) (cadr exp))
(define (unless-consequence exp)
  (if (null? (cdddr exp))
    #f
    (cadddr exp)))
(define (unless-alternative exp) (caddr exp))
(define (unless->if exp)
  (make-if (unless-predicate exp)
           (unless-consequence exp)
           (unless-alternative exp)))



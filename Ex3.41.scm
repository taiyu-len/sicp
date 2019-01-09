;
;ben bitdiddle worries that it owuld be better to implment the bank account as
;follows (where the commented line has been changed

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amound)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
   (define (dispatch m)
     (cond ((eq? m 'withdraw) (protected withdraw))
           ((eq? m 'deposit ) (protected deposit))
           ((eq? m 'balance)
            ((protected (lambda () balance))));serialized
           (else (error "Unknown request--MAKE-ACCOUND" m))))
   dispatch))

;because allowing unserialized access to the bank balance can result in
;anomalous behavior. do you agree?
;;i guess so
;is there any scenario that demonstrates ben's concern
;;just same time access


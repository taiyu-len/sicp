;ben bitdiddle suggests its a waste of time to create a new serialized procedure
;in response to every withdraw and deposit message. he says that  make-account
;could be changed so that the calls to protected are done outside the dispatch
;procedure. thatis an account would return the same serialized procedure each
;time it is asked for a withdrawl procedure

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
   (let ((protected-withdraw (protected withdraw))
         (protected-deposit  (protected deposit)))
     (define (dispatch m)
       (cond ((eq? m 'withdraw)protected-withdraw)
             ((eq? m 'deposit )protected-deposit)
             ((eq? m 'balance )balance)
             (else (error "Unknown request -- Make-Account" m))))
     dispatch)))

;is this a safe change to make? in particular is there any difference in what
;concurrency is allowed by these two versions of make-account.

;id think it would be safe. it does create a dunno lol

;louis reasoner thinks our bank-account system in unnecessarily complex and
;error-prone now hat deposits and withdrawls arent automatically serialized. he
;suggests that make-account-and-serializer should have exporeted the serializer
;in addition to using it to serialize accounts and depositis in make-account
;did. he proposes the following

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
   (define (dispatch m)
     (cond ((eq? m 'withdraw) (balance-serializer withdraw))
           ((eq? m 'deposit) (balance-serializer deposit))
           ((eq? m 'balance)balance)
           ((eq? m 'serializer)balance-serializer)
           (else (error "Unknown request--make-account" m))))
   dispatch))

(define (deposit acc amt)
  ((acc 'deposit) amt))
;explain what is wrong with louis's reasoning in particular consider what
;happens when serialized-exchange is called

;IT WILL NEVER RETURN. say the serializedprocess from exhange is A, and the
;serialized process in deposit is B, we first call A, and then B,  by the nature
;of the serializer B does not call until A finishes. however B is a part of A
;and so A will never return and niether will Bwill 

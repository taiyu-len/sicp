; modify make-account procedure so that it creates password-protected accounts.
;that is, make-account should take a symbol as an additional argument, as in


;the resulting account object should process a request only if it is accompanied
;by the password with which the account was created and should otherwise return
;a complaint


(define (make-account amount pass)
  (let ((value amount))
   (lambda (pw action)
     (if (eq? pass pw)
       (lambda (x)
         (set! value
           (cond ((eq? action 'withdraw)
                  (- value x))
                 ((eq? action 'deposit)
                  (+ value x))
                 (else "Invalid Action"))))
       (lambda (a)"Invalid Password")))))

(define acc (make-account 100 'secret-password))


((acc 'secret-password 'withdraw) 40)
;60

((acc 'some-other-password 'deposit) 50)
;incorrect password

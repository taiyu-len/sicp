;consider the bank account objects cretaed by make-account with the password
;modification described in exercise 3.3. suppose that our banking system
;requires tha bility to make joint accounts. define a procedure make-joint that
;accompishes this. make-joint should take three arguments. the first is a
;password-protected account. the second argument must match the passwod. with
;thich the account was defined in order for the make-joint operation to proceed.
;the third is a new password. make-joint is to create an additional access to
;the original account using the new password. for example, if peter-acc is a
;bank account with password open-sesame. then 

;(define paul-acc
;  (make-joint peter-acc 'open-sesame 'rosebud))

;will allow one to make transactions on peter-acc using the name paul-acc and 
;the password rosebud. you may wish to modify your solution in exersize 3.3 to
;accomodate this new feature.


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

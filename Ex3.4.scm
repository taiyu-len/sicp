;modify the make-account procedure of exercise 3.3 by adding another local state
;variable so that, if an account is accessed more then seven consecutive times
;with an incorrect password, it invokes the procedure call-the-cops

(define call-the-cops
  (lambda (a)"Failed Password Seven Times, Go Kill Yourself"))
(define (make-account amount pass)
  (let ((value amount)
        (fail 0))
   (lambda (pw action)
     (if (eq? pass pw)
       (begin
         (set! fail 0)
         (lambda (x)
           (set! value
             (cond ((eq? action 'withdraw)
                    (- value x))
                   ((eq? action 'deposit)
                    (+ value x))
                   (else "Invalid Action")))))
       (begin
         (set! fail (+ fail 1))
         (if (= fail 7) call-the-cops
                        (lambda (a)"Invalid Password")))))))

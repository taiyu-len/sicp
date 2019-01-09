;in the make-withdraw  procedure, the local variable balance is created as a
;parameter of make-withdraw. we could also create the local state variable
;explicitly, using let as follows

(define (make-withdraw ini)
  (let ((balance ini))
   (lambda (amount)
     (if (>= balance amount)
       (begin (set! balance (- balance amount))
              balance)
       "Insufficient funds"))))

;recall from section 1.3.2 that let is simply

;(let ((<+var+> <+exp+>)) <+body+>)

;is interpretedd as alternate syntax for 

;((lambda (<+var+>)<+body+>)<+exp+>)

;use the environment model to analyze this alternate version of make-withdraw
;drawing figures like the ones above to illustrate the interactions

(define W1 (make-withdraw 100))
(W1 50)
(define W2 (make-withdraw 100))

;first it creates an enviroment for W1, that is built from the make-withdraw
;procedure. simply put it is a function that subtracts stuff from the balance.
;
;calling W1 50 will evalute the procedure and change reset the balance that is
;in E1.
;it will then create a new enviroment for W2 from make with draw so E2. 

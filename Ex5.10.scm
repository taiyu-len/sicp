;design a new snytax for register-machine instructions and modify the simulator
;to use your new syntax. can you implement your new syntax wihtout changing
;any part of the simulator except the syntax procedures in this section

;so ill design a swap procedure then.


'(swap (reg a) (reg b)) 
;will be the instruction

(define swap-test
  (make-machine
    (list (list))
    '((assign a (const 4))
      (assign b (const 10))
      (swap a b))))

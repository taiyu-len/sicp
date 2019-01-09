;se the register-machine  language to describe the iterative factorial machine
;of exercise 5.1

(controller
  (assign p (const 1))
  (assign c (const 1))
 iter
  (test (op >) (reg c) (reg n))
  (branch (label done))
  (assign p (op *) (reg c) (reg p))
  (assign c (op +) (reg c) (const 1))
  (goto (lable iter))
 done)

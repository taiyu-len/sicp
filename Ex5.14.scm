;factorial

(define fact-machine
  (make-machine
    (list (list '* *)
          (list '+ +)
          (list '> >))
    '((assign p (const 1))
      (assign c (const 1))
      iter
      (test (op >) (reg c) (reg n))
      (branch (label done))
      (assign p (op *) (reg c) (reg p))
      (assign c (op +) (reg c) (const 1))
      (goto (label iter))
      done)))

(define expt-machine
  (make-machine
    (list (list '= =)
          (list '- -)
          (list '* *))
   '((assign c (label expt-done))
     expt-loop
     (test (op =) (reg n) (const 0))
     (branch (label base-case))
     (save c)
     (assign n (op -) (reg n) (const 1))
     (assign c (label expt-return))
     (goto (label expt-loop))
     expt-return
     (restore c)
     (assign n (op *) (reg n) (reg b))
     (goto (reg c))
     base-case
     (assign n (const 1))
     (goto (reg c))
     expt-done)))

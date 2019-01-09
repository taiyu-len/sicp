;the treate ment of machine operations above permits them to operatoe on labels
;as well as on constants and the contents of registers. modify the
;expression-processing procedures to enforce the condition that operations can
;used only with registers and constants



(define test-label-op
  (make-machine
    (list (list '* *))
    '(test
       (assign a (op *) (const 5) (const 7))
       (assign a (op *) (reg a) (const 5)))))



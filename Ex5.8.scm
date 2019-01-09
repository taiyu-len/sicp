;te following register-machine code is ambiguous because the label here is
;defined more than once:

(define test-dup-label
  (make-machine
    (list (list))
'(start
  (goto (label here))
  here
  (assign a (const 3))
  (goto (label there))
  here
  (assign a (const 4))
  (goto (label there))
  there)))

;with the simulator as written what will the contents of a register a be when
;control reaches there? modify the extract-labels procedure so that the
;assembler will signal an error if the same label name is used to indicate two
;different locations



;see regmac.scm for implementation

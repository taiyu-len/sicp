;louis reasoner wants to build a squarer, a constraint device with two terminals
;such that the value of connector b on the second terminal will always be the
;equare of the value a on the first terminal. he propeeses the following simple
;device made from a multiplier:

(define (squarer a b)
  (multiplier a a b))

;there is a serious flaw explain.
;
;obviously it only works in one direction 



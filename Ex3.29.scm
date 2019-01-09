;another way to construct an or-gate is a compount digital logic device, built
;form and-gates and inverters. define a procedure or-gate that accomplishes
;this. what is the delay time of the or-gate interms of and-gate-delay and
;inverter-gate-delay


(define (or-gate a1 a2 output)
  (let ((w1 (make-wire))
        (w2 (make-wire))
        (o  (make-wire)))
   (inverter a1 w1)
   (inverter a2 w2)
   (and-gate w1 w2 o)
   (inverter o output)))

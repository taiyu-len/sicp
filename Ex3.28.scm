;define an or-gate as primitive function box. your or-gate constructor should be
;similar to and-gate


(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
            (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
(define (logical-or s1 s2)
  (if (and (or (= s1 0) (= s1 1)) 
           (or (= s2 0) (= s2 1)))
    (if (or (= 1 s1) (= 1 s2))
      1
      0)
    (error "Invalid Signal")))

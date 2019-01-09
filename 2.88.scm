;extend the polynomial system to include subtraction of polynomials. 
;
(define (sub-terms L1 L2)
  (cond ((empty-termlist? L1)L2)
        ((empty-termlist? L2)L1)
        (else
          (let ((t1 (first-term L1)) (t2 (first-term L2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term
                    t1 (sub-term (rest-terms L1) L2)))
                 ((< (order t1) (order t2))
                  (adjoin-term
                    t2 (sub-term L1 (rest-terms L2))))
                 (else
                   adjoin-term
                   (make-term (order t1)
                              (sub (coeff t1) (coeff t2)))
                   (sub-terms (rest-terms L1)
                              (rest-terms L2))))))))

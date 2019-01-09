;a; implement the procedure  pseudoremainder-terms  which is just like
;remainder-terms  except that it multiplies the dividend by the integerizing
;factor described above before calling div-terms. modify gcd-terms ot use
;pseudoremainder-term, and verify that greatest-common-divisor now produces an
;answer with integer coefficients on the example in 2.95

(define (pseudoremainder-terms a b)
  (let ((o1 (order (first-term a)))
        (o2 (order (first-term b)))
        (c (coeff (first-term b)))
        (divident (mul-terms
                    (make-term 0
                               (expt c (+ 1 (- o1 o2))))
                    a)))
    (cadr (div-terms divident b))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
    a
    (gcd-terms b (pseudoremainder-terms a b))))

;; b
(define (gcd-terms a b)
  (if (empty-termlist? b)
    (let* ((coeff-list (map cadr a))
           (gcd-coeff (apply gcd coeff-list)))
      (div-terms a (make-term 0 gcd-coeff)))
    (gcd-terms b (pseudoremainder-terms a b))))

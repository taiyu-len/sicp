;suppose you are designing a generic arithmetic system for dealing with the
;tower of types showin  figure 2.25: integer rational, real, complex. for each
;type (except complex), design a procedure that raises ojects of that type one
;level oin the tower. show how to install a generic raise operation that will
;work for each type (not complex)

(define (raise num)
  (let ((tag? (lambda (x) (eq? x (type-tag num)))))
   (cond ((tag? 'scheme-number);raise to rational
          (attach-tag 'rational
                      (make-rat (contents num)
                                1)))
         ((tag? 'rational);raise to real
          (attach-tag 'real
                      (make-real
                        (/ (* 1.0 (numer (contents num)))
                           (* 1.0 (denom (contents num)))))))
         ((tag? 'real);make complex
          (attach-tag 'complex
                      (make-complex
                        (contents num)
                        0)))
         ((tag? 'complex) num)
         (else
           (error "unknown or number type")))))

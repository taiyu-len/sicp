;using the raise operation modify the apply-generic procedure so that it coerces
;its arguments ot have the same type by the method of successive raising, as
;discuess in this section, you will need to devise a way to test which of two
;types is higher in te tower. do this in a manner that is compatable with the
;rest of the system and will not lead to problems in adding new levels to the
;tower.

(define (higher a b)
  (let ((value (lambda (x) (level (type-tag x)))))
   (cond ((> (value a) (value b))a)
         ((< (value a) (value b))b)
         (else #f))))
(define (lower a b)
  (let ((value (lambda (x) (level (type-tag x)))))
   (cond ((> (value a) (value b))b)
         ((< (value a) (value b))a)
         (else #f))))
(define (level a)
  (cond ((eq? a 'scheme-number)1)
        ((eq? a 'rational)2)
        ((eq? a 'real)3)
        ((eq? a 'complex)4)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
   (let ((proc (get op type-tags)))
    (if proc
      (apply proc (map contents args))
      (if (> (length args)1)
        (let ((this (car args))
              (next (cadr args)))
          (if (higher this next)
            (apply-generic op (cons
                                (raise (lower (car args)))
                                (cons
                                  (higher (cadr args))
                                  (cddr args))))
            (else
              (error "cannot raise value")))))))))

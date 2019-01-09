;louis reasoner has noticed that apply-generic may try to coerce the arguments
;to each other's type even if they already have the same type, therefore he
;reasons, we need to put procedures in the corecion table to coerce arguments of
;each type to their own type. for example, in addition to the
;scheme-number->complex he would add
;(define (scheme-number->scheme-number n) n)
;(deifne (complex->complex z) z)
;(put-coercion 'scheme-number 'scheme-number
;               scheme-number->scheme-number)
;(put-coercion 'complex 'complex
;               complex->complex)
;with louis coercion procedures installed, what happens if apply-generic is
;caleld with two arguments of type sn or complex for an operation tht is not
;found in the table for those tpes? for example assume that weve defined a
;generic exponentiation operation
;(define (exp x y)(apply-generic 'exp x y))
;and have put a procedure for exponentiation in the scheme number pakagebut not
;in any other package.
;(put 'exp '(scheme-number scheme-number)
;     (lambda (x y) (tag (expt x y))));
;what happens if we call exp with two complex numbers as arguments.
;it fails as it cannot find the expressions
;b: is louis correct that something had to be done about coercion with arguments
;of the same type. or does apply-generic work correctly as is
;it would return an error
;c: modif apply-generic sot hat it doesnt try coercion if the two arguments have
;the same type

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
   (let ((proc (get op type-tags)))
    (if proc
      (apply proc (map contents args))
      (if (= (length args)2)
        (let ((type1 (car type-tags))
              (type2 (cadr type-tags))
              (a1 (car args))
              (a2 (cadr args)))
          (let ((t1->t2 (get-coercion type1 type2))
                (t2->t1 (get-coercion type2 type1)))
            (cond ((eq? type1 type2)
                   (apply-generic op a1 a2))
                  (t1->t2
                    (apply-generic op (t1->t2 a1) a2))
                  (t2->t1
                    (apply-generic op a1 (t2->t1 a2)))
                  (else
                    (error "No method for these types"
                           (list op type-tags))))))
        (error "No method for these types"
               (list op type-tags)))))))


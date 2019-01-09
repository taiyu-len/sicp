;give an implementation of adjoin-set using the ordered representation. by
;analogy with element-of-set? show how to take advantage of the ordering to
;blablah. 

(define (adjoin-set x set)
  (cond ((= x (car set))set)
        ((< x (car set))
         (cons (car set) (adjoin-set x (cdr set))))
        ((> x (car set))
         (cons x set))))

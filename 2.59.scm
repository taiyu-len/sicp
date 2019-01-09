;implement the union set operation for the u nordered-list representation of
;sets.
(define (union-set set1 set2)
  (cond ((null? set1)set2)
        ((null? set2)set1)
        ((element-of-set? (car set1)set2)
         (intersection-set (cdr set1)set2))
        (else
          (cons (car set1) (intersection-set (cdr set1)set2)))))

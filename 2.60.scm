;we specified that a set would be represented as a list wiht no duplicates. now
;suppose we allow duplicates. for instance, the set {1,2,3} could be represented
;as the list (1 2 3 1 2 3). design procedures element-of-set?,
;adjoin-set,union-set, and intersection-set that operate on this representation.
;how does the efficiency of each compare with the corresponding procedure for
;the non-duplicate represenation? are there applications for which you would use
;this representation in preference to athe non-duplucate one.

;element-of-set? wouldnt change
(define adjoin-set cons)
(define (union-set set1 set2)
  (define (union seta)
    (cond ((null? seta)setb)
          ((null? setb)seta)
          ((element-of-set? (car seta)setb)
           (union (cdr seta) setb))
          (else 
            (cons (union (cdr seta)setb)))))
  (union set1 (union set2 set1)))
(define (intersection-set set1 set2)
  (define (intersection seta setb)
    (cond ((or (null? seta) (null? setb))'())
          ((element-of-set? (car seta) setb)
           (cons (car seta)
                 (intersection (cdr seta) setb)))
          (else (intersection (cdr seta) setb))))
  (intersection set1 (intersection set2 set1)))



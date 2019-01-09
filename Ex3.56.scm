;a famous problem, first raised by R.hamming, is to enumerate, in ascending
;order with no repetitions, all positive integers with no prime factors other
;then 2,3, and 5. one obious way to do this is to simply test each integer in
;turn to see whether it has any factors other then 2,3,5. but this is very
;inefficient, since as the integers get larger, fewer and fewer fit the
;requirement. as  an alternative let us call the required stream of numbers S
;and notice the following facts about it 

;S starts with 1.

;the elements of (scale-stream S 2) are also elements of S

;the same is true for (scale-stream S 3) and (scale-stream 5 S).

;these are all elemnts of S.

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let
           ((s1car (stream-car s1))
            (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1)s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                   (cons-stream s1car
                                (merge (stream-cdr s1)
                                       (stream-cdr s2)))))))))

;then the required stream may be constructred with merge, as follows:

(define S (cons-stream 1 
                       (merge (scale-stream S 2) 
                              (merge 
                                (scale-stream S 3)
                                (scale-stream S 5)))))

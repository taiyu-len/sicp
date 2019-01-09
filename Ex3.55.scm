;define a procedure partial-sums that takes as arguments a stream S and
;returnsthe stream whose elements are  
;S_0 , S_0+S_1 , S_0+S_1+S_2,... for example (partial-sums integers)
;should be the stream 1 3 6 10 15

(define (partial-sums S)
  (cons-stream
    (stream-car S)
    (add-streams (stream-cdr S)
                 (partial-sums S))))

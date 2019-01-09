;write aprocedure  an-integer-between  that returns an integer between two given
;bounds. this can be used to implement a procedure that find pythagorean
;triples, ie triples of integers between ijk between the given bounds such that
;i<j and i^2+j^2=k^2 as follows

(define (a-pythagorean-triple-between low high)
  (let* ((i (an-integer-between low high))
         (j (an-integer-between i high))
         (k (an-integer-between j high)))
    (require (= (+ (* i i) (* j j)) (* k k)))
    (list i j k)))

(define (enumerate-integer l h)
  (if (> l h)
    '()
    (cons l (enumerate-integer (+ l 1) h))))

(define (an-integer-between low high)
  (require (> high low))
  (amb (enumerate-integer low high)))



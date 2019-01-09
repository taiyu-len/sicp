;eva lu ator has a criticism of louis approach in the last exercise. the program
;he wrote is not modular, because it intermixes the operation of smoothing with
;the ZeroCrossing extraction. for example, the extractor should not have to be
;changed if alyssa finds a better way to condition her input signa. help louis
;by writing a procedure smooth that takes a stream as input and produces a
;stream in which each element is hte average of two successive input stream
;elelemnts. then use smooth as a componenet to implement the zerocrossing
;detector in a more modular style


(define (Smooth Stream)
  (cons-stream
    (/ (+ (stream-car Stream)
          (stream-ref Stream 1))2)
    (Smooth (stream-cdr Stream))))


;in software testing applications it is useful to be able to count the number of
;times a given procedure is caleld during the corse of computation. write a
;procedure make-monitored that takes as input a procedure, f. that itself takes
;one input. the result returned by make-monitored is a third procedure, say mf,
;that keeps track of the number of times it has been called by maintining an
;internal value counter. if the input to mf is the special symbol
;'how-many-calls?.  then mf returns the value of the counter. if the input is
;the special symbol  'reset-count,  hten mf resets the counter to zero. for any
;other input mf returns the result of calling f on that input and increments the
;counter for instance we could make a monitored version of the sqrt procedure

(define (make-monitored func)
  (let ((calls 0))
   (lambda (in)
     (cond ((number? in)
            (begin
              (set! calls (+ calls 1))
              (func in)))
           ((eq? in 'how-many-calls?)
            calls)
           ((eq? in 'reset-count)
            (set! calls 0))))))

(define s (make-monitored sqrt))
(s 100)
;10
(s 'how-many-calls?)
;1

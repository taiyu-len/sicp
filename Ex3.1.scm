;an accumulator is a procedure that is called repeatedly with a single numeric
;argument and accumulates its arugments into a sum, each time it is called, it
;returns the currently accumulated sum. write a procedure make-accumulator that
;generates accumulators, each mainting an independent sum. the input to
;make-accumulator  should specify the initial value of the sum; for example

;(define A (make-accumulator 5))
;(A 10)
;15
;(A 10)
;2

(define (make-accumulator num)
  (let ((value num))
   (lambda (x)
     (begin
       (set! value (+ value num))
       value))))


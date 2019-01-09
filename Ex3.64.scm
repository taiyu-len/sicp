;write a procedure stream-limit that takes as arguments a streeam and a number
;the tolerance). it should examine the stream until it finds two successive
;elemnts that differ in absolute value by less then the tolerance, and return
;the second of the two elements, using this we could compute square roots up to
;a given tolerance by

(define (sqrt? x tolerance)
  (stream-limit (sqrt-stream x)tolerance))



(define (stream-limit S t)
  (if (< (abs (- (stream-ref S 1)
                 (stream-ref S 0)))t)
    (stream-ref S 1)
    (stream-limit (stream-cdr S) t)))

;define a procedure  mul-streams, analogous to add-streams, that produces the
;elementwise product of its two input streams. use this together with the stream
;of integers to complete the following definition of th stream whose nth element
;is n+1 factorial
;
(define (mul-streams m1 m2)
  (stream-map * m1 m2))
(define factorials
  (cons-stream 1
               (mul-streams (add-streams ones integers) factorials)))



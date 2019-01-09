;exersize 3.69 discussed how to generate the stream of all pythagorean triples,
;with no upper bound on the size of the integers to be searched. explain why
;simply replacing  an-integer-between  with  an-integer-starting-from  in the
;procedure in 4.35 is not an adequate way to generate arbitrary pythagorean
;triples. write a procedure that actually will accomplish this. (that is, write
;a procedure fo which repeatdly typing try-again would in principle eventually
;generate all pythagorean triples.

(define (a-pythagorean-triple-greater-than low)
  (let* ((k (an-integer-starting-from low))
         (i (an-integer-between low k))
         (j (an-integer-between i   k)))
    (require (= (+ (* i i) (* j j)) (* k k)))
    (list i j k)))

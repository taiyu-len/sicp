;louis reasoner thinks that building a stream of pairs from three parts is
;unnecessaro;y complicated. instead of seperating the pair (S_0,T_0) fromt the
;rest of the pairs in the first row, he proposes to work with the whole first-
;row as follows

;(define (pairs s t)
;  (interleave
;    (stream (lambda (x) (list (stream-car s) x))
;            t)
;    (pairs (stream-cdr s) (stream-cdr t))))

;does this work? consder what happens if we evaluate (pairs integers integers)
;using louis definition of pairs.

;it enters a infinite loop cause no cons-stream to stop it form processing the
;rest of the pairs

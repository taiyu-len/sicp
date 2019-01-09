;give all the possible values of x that can result from executing

;(define x 10)
;(parallel-execute (lambda () (set! x (* x x)))
;                  (lambda () (set! x (* x x x))))

;three possible,  100 1000 1000000

;which of these possibilities remain if we instead use a serialized procedure

;only 100000, 10*10=100,100*100*100 1000000


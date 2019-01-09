;whichof the five possibilities in the parallel execution shown above remian if
;we instead serialize execution as follows:

;(define x 10)
;(define s (make-serializer))
;(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
;                  (s (lambda () (set! x (+ x 1)))))
;
;seemslike it would go 110. or bottom first

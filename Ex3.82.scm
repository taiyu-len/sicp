;redo exercise 3.5 on monte carlo inegration in terms of streams. the stream
;version of estimate-integral will not have an argument telling how many trials
;to preform. instead it will produce a stream of estimates based on
;successively more trials.


(define (random-in-range low high)
  (let ((range (- high low)))
   (+ low (random range))))
(define (random-number-pairs low1 high1 low2 high2)
  (cons-stream (cons (random-in-range low1 high1) (random-in-range low2 high2))
               (random-number-pairs low1 high1 low2 high2)))

(define (monte-carlo test-stream pass fail)
  (define (next pass fail)
    (cons-stream (/ pass (+ pass fail))
                 (monte-carlo (stream-cdr test-stream)
                              pass fail)))
  (if (stream-car test-stream)
    (next (+ pass 1) fail)
    (next pass (+ fail 1))))

(define (estimate-integral P x1 x2 y1 y2)
  (let ((area (* (- x2 x1) (- y2 y1)))
        (randoms (random-number-pairs x1 x2 y1 y2)))
    (scale-stream (monte-carlo (stream-map p randoms)
                               0 0)
                  area)))

(define (sum-of-square x y) (+ (* x x) (* y y)))

(define f (lambda (x) (not (> (sum-of-square (- (car x)1) (- (cdr x)1))1))))
(define pi-stream (estimate-integral f 0 2 0 2))

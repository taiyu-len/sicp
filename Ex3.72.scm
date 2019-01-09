;in a similar way to exercise 3.71 generate a stream of all numbers that can be
;written as the sum of two squares in three different ways (showing how they can
;be so written)

(define Square-Weight
  (lambda (x)
    (+ (expt (car x) 2) (expt (cdr x)2))))

(define Square-Stream
  (cons-stream
    (cons 0 0)
    (weighted-pairs integers integers Square-Weight)))

(define (Square-Sum S)
  (cons-stream
    (+ (expt (car (stream-car S))2) (expt (cdr (stream-car S))2))
    (Square-Sum (stream-cdr S))))

(define (Triples S)
  (if (= (stream-ref S 0)
         (stream-ref S 1)
         (stream-ref S 2))
    (cons-stream
      (stream-car S)
      (Triples (stream-cdr S)))
    (Triples (stream-cdr S))))

(define ThreeSquares
  (Triples (Square-Sum Square-Stream)))




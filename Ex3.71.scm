;number that can be expresed as the sum of two cubes in more then one way are
;sometimes called ramanujan numbers ,in honor of the mathematician sstiusoth.
;ordered streams of pairs provede an elegant solution to the problem of
;computing these numbers. to find a number that can be written as the sum of two
;cubes in two different ways, we need only generate the stream of pairs of
;integers (i,j) weighted according to the sum i^3+j^3, then search the stream
;for two consecutive pairs with the same weight. write a procedure to generate
;ramanujan numbers. the first such number is 1729. what are the next 5;

(define Cube-Weight
  (lambda (x)
    (+ (expt (car x) 3) (expt (cdr x)3))))

(define Cube-Stream
  (cons-stream
    (cons 0 0)
    (weighted-pairs integers integers Cube-Weight)))

(define (Cube-Sum S)
  (cons-stream
    (+ (expt (car(stream-car S))3) (expt(cdr (stream-car S))3))
    (Cube-Sum (stream-cdr S))))

(define (Duplicates S)
  (if (= (stream-car S)
         (stream-car (stream-cdr S)))
    (cons-stream
      (stream-car S)
      (Duplicates (stream-cdr S)))
    (Duplicates (stream-cdr S))))

(define Ram-Stream
  (Duplicates (Cube-Sum Cube-Stream)))

;cause its so simple ill do a lot

;4104, 13832, 20683, 32832, 39312, 40033, 46683, 64232, 65728, 110656, 110808,
;134379, 149389, 165464, 171288, 195841, 216027, 216125, 262656

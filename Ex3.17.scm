;decice a correct versiion of the count-pairs procedure of exercise 3.16 that
;returns  the number of distinct pairs in any structure.

(define (count-pairs x)
  (let ((checked '()))
   (define (count x)
     (if (or (not (pair? x))(memq x checked))
       0
       (begin
         (set! checked (cons x checked))
         (+ (count (car x))
            (count (cdr x))
            1))))
   (count x)))

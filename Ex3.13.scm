;consider the following make-cycle procedure, which uses the last-pair procedure
;defined in exersize 3.12
;
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

;draw a box-and-pointer diagram that shows the structure z created by 

(define z (make-cycle (list 'a 'b 'c)))

;what happens if we try to compute (last-pair z)?

;infinite loop of course;



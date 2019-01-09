;ben bitdidle decides to write a procedure to count the number of pairs in any
;list structure. its easy he reasons. " the number of pairs in any structure is
;the number in the care plus the number in the cdr plus one more to count the
;current pair." so ben writes the following procedure:

(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

;show that this procedure is not correct. in particular, draw box-and pointer
;diagrams representing list structures made up of exactly 3 pairs for which bens
;procedure would return 3; return 4; return 7; and never return at all;

;three
(define L1 (cons (cons 'a 'b) (cons 'c 'd)))

;Four
(define P1 (cons 'a 'b))
(define P2 (cons P1 'c))
(define P3 (cons P2 P1))
(define L2 P3)
;seven
(define P4 (cons 'a 'b))
(define P5 (cons P4 P4))
(define P6 (cons P5 P5))
(define L3 P6)
;infinit
(define Infty (cons 'a (cons 'b (cons 'c ()))))
(set-cdr! (cddr Infty) Infty)

;the following procedure is quite useful, although obscue:

(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let  ((temp (cdr x)))
       (set-cdr! x y)
       (loop temp x))))
  (loop x '()))

;loop uses the temporary varaible temp to hold the old value of cdr of x, since
;the set-cdr! on the next line destroy the cdr. explain what mystery does in
;general. suppose v is defined by (define v '(a b c d)). draw the
;box-and-pointer diagram that represents the list to which v is bound.suppose
;that we now evaluate (define w (myster v)). draw box-and-pointer diagrams that
;show the structures v and w after evaluating this expression. what would be
;printed as the values of v and w?

;    X        y    temp
;(a b c d) ()      (b c d)
;(a)
;(b c d)   (a)     (c d)
;(b a)
;(c d)     (b a)   (d)
;(c b a)
;(d)       (c b a) ()
;(d c b a)
;()       (d c b a)
;returns (d c b a); x is now (), but for me comes out as (a) ; well w is (a)


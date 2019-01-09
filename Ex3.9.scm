;in section 1.2.1 we sued the substitution model to analyze two procedures for
;computing factorials, a recurisve versions

(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n 1)))))

;and a iterative version

(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter p c m)
  (if (> c m)
    p
    (fact-iter (* p c)
               (+ c 1)
               m)))

;show the envoroment structures created by calling (factorial 6) using each
;version of the factorial procedure.

;[Global] factorial - this is where the factorial exists
;[E1] n:6 , 6*(factorial (- 6 1)) - n set to 6, (- 6 1) evaluates
;[E2] n:5 , 5*(factorial (- 5 1)) - same shit
;[E3]
;[E6]n:1 , 1 - it finally reaches a dead point. we have 6 enviroments waiting
;for the next to finish. it then quickly returns and finishes up

;[Global] factorial , fact-iter
;[E1] n:6 , (fact-iter 1 1 6) - calling factorial
;[E2] p:1 c:1 m:6 , (fact-iter (* 1 1)(+ 1 1) 6) - now at this point we dont
;need to make another enviroment, cause its iterative. so we can just set! p c
;and m and recall [E2]
;[E2] p:1   c:2 m:6 , (fact-iter (* 1   2)(+ 2 1) 6)
;[E2] p:2   c:3 m:6 , (fact-iter (* 2   3)(+ 3 1) 6)
;[E2] p:6   c:4 m:6 , (fact-iter (* 6   4)(+ 4 1) 6)
;[E2] p:24  c:5 m:6 , (fact-iter (* 24  5)(+ 5 1) 6)
;[E2] p:120 c:6 m:6 , 120 - we reached the end and now it can be returned to E1


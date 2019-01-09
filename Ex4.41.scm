;write an ordinary scheme program to solve the multipe dwelling problem


(define (multiple-dwelling)
  (define (cooper c)
    (define (miller m)
      (define (fletcher f)
        (define (smith s)
          (define (baker b)
            (if (= b 5);Baker
              (smith (+ s 1))
              (if (distinct? (list b s f m c))
                (list (list 'baker b)   ;P
                      (list 'smith s)   ;A
                      (list 'fletcher f);S
                      (list 'miller m)  ;S
                      (list 'cooper c)) ;!
                (baker (+ b 1)))))
          (if (= s 6);SMITH
            (fletcher (+ f 1))
            (if (= (abs (- f s))1)
              (smith (+ s 1))
              (baker 1))))
        (if (= f 5);FLETCHER
          (miller (+ m 1))
          (if (= (abs (- f c))1)
            (fletcher (+ f 1))
            (smith 1))))
      (if (= m 6);MILLER
        (cooper (+ c 1))
        (fletcher 2)))
    (if (= c 6);COOPER
      'fail
      (miller (+ c 1))))
  (cooper 2));Start HERE

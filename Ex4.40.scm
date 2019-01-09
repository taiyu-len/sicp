;in themultiple dwelling problem, how many sets of assignements are there of
;people to floors, both before and after the requirementrs that floor assignment
;be distinct? it is very inefficient to generate all possible assignements of
;people to floors and then leave it to backtraking to eliminate them, for
;example, most of the restrictions depend on only one or two of the person-floor
;vairable, and can thus be imporse before floors have been selected for all
;peple. write and demonstrate a much more efficient nondeterministic procedure
;that solves this problem  based upon generating only those possibilities that
;are not already ruled out by previous restrictions

(define (multiple-dwelling)
  (let ((cooper (amb 2 3 4))
        (miller (amb 3 4 5)))
    (require (> miller cooper))
    (let ((fletcher (amb 2 3 4)))
     (require (not (= (abs (- fletcher cooper))1)))
     (let ((smith (amb 1 2 3 4 5)))
      (require (not (= (abs (- fletcher smith))1)))
      (let ((baker (amb 1 2 3 4)))
       (require (distinct? (list baker smith fletcher miller cooper)))
       (list (list 'baker baker)
             (list 'cooper cooper)
             (list 'fletcher fletcher)
             (list 'miller miller)
             (list 'smith smith)))))))

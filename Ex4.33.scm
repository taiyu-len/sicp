;ben tests the lazy list implementation given above by evaluating the expression
;(car '(a b c))

;to his suprise this produces an error, after some though, he realizes that the
;lists obtained by reading in quoted expressions are different from the lists
;manipulated by the new definitions of cons,car, and cdr. modify the evaluator's
;treatment of quoted expressions so that the quoted lists typed at the driver
;loop will produce true lazy lists.

;'(a b c) = (quote (a b c))
;so build it like that

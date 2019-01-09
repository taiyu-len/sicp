;given a one-argument proceudre p and an object a, p is said to "halt" on a if
;returning the expression (p a) returns a value (as oppsoed to terminiating with
;an error or running forever). show that it is simpossible to write a procedure
;halts? that correctly determines whether p halts on a for any procedure p and
;object a. use the following reasoning; if you had such a procudure halts?
;you chould implement the following programs

;(define (run-forever)(run-forever))
;(define (try p)
; (if(halts? p p)
;  (run-forever)
;  'halted))
;
;now consider evaluating the expression (try try) and who that any possible
;outcome, (either halting or running forever) violates the intended behavior;

;(try try)
;(halts? try try) ; if it does halt it will call
;(run-forever)    ; but this is wrong so it doesnt halt in that case it calls
;'halted          ; but this is wrong as well as it just halted. lol paradox
;if you claim it halts it runs forever and if you claim it runs forever it halts


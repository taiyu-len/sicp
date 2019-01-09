;hand simulate the factorial and fibonacci machiens using some non trivial input
;(requiing execution of at least one recusive call). show the contents of the
;stack at each significant point in the execution.

;b = 5
;n = 1
;
;continue = ->expt-done
;
;test n=0
;
;push continue  [expt-done]
;set n=n-1=0
;set continue = expt-return
;goto expt-loop;

;test n=0
;goto base-case

;set n=1
;goto continue : expt-return
;
;pop continue = expt-done
;set n= n*b=5
;done.


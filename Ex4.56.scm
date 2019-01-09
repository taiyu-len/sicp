;formulate compound queries that retrieve the following information:
;a; the names of all people who supervised by ben bitdiddle, together with their
;addresses.

;(and (supervisor (Bitdiddle Ben) ?name)
;     (address ?name . ?rest)

;b; all people whose salary is less then ben bitdiddle, together with their
;salary and ben bitdiddles salery

;(and (salary ?name ?amount)
;     (salary (Bitdiddle Ben) ?bens)
;     (lisp-value < ?amount ?bens))

;c; all people who are supervised by someone who is ont in the computer division
;together with the supervisor's name and job

;(and (supervisor ?name ?super)
;     (job ?super (computer . ?rest)))


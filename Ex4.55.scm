;give simple queries that retrieve the following information fromt he database

;a;all people supervised by ben bitdiddle;

(supervisor ?x (Bitdiddle Ben))

;b;the names and jobs of all people in the accounting divison

(job ?x (accounting . ?y))

;c;the names and addresses of all people who live in slumerville.

(address ?x (Slumerville . ?y))

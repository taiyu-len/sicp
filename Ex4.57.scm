;define a rule that says that person 1 can replace person 2 if either person 1
;does the same job as person 2, or someone who does person 1's job can also do
;person 2's job, and if erson 1 and person2 are not the same person. using your
;rule give queries that find the following
;

;;see Ch4.4.scm in rules fo  (rule (can-replace))


(can-replace (Cy D Fect) ?person)

;b;all people who cna place someone who is being paid more then they are,
;together with the two saleries;;; fucking annoying

(and (can-replace ?person1 ?person2)
     (salary ?person1 ?value1)
     (salary ?person2 ?value2)
     (list-value > ?value1 ?value2))

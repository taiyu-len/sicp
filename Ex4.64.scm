;louis reasoner mistakenly deletes the outranked-by rule from the data base.
;when he realizes this, he quickly reinstalls it. unfortunatly he makes a slight
;change in the rule, and types it in as

(rule (outranked-by ?staff ?boss)
      (or (supervisor ?staff ?boss)
          (and (outranked-by ?middle ?boss)
               (supervisor ?staff ?middle))))

;just after louis enters this into the database. DeWitt comes by to find out who
;outranked Ben and types

(outranked-by (Bitdiddle Ben) ?who)
;after answerering it goes into an infinite loop.why

;it checks the first cause in or first.
;then the next.

;it then checks outranked-by ?middle ?boss. with middle and boss both unknown.
;it then goes into a loop with both unknown and always continuesly checking the
;unknown

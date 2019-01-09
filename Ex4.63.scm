;the following data base traces the genealogy of the descendants of ada back to
;adam, by way of cain

(son Adam Cain)
(son Cain Enoch)
(son Enoch Irad)
(son Irad Mehujael)
(son Methushael Lamech)
(wife Lamech Ada)
(son Ada Jabal)
(son Ada Jubal)

;formulate rules such as  "if S is the son of F, anf F is the sone of G then S
;is the grand son of G"
(rule (grandson ?S ?G)
      (and (son ?S ?F)
           (son ?F ?G)))
;and "if W is the wife of M, and S is the son of W, thenS is the son of M"
(rule (son ?M ?S)
      (and (son ?W ?S)
           (wife ?M ?W)))

;beginning with the data base and the rules you formulated in exercise 4.63,
;devise a rule for adding "greats" to a grandon relationship. this should enable
;the system to deduce that irad is the great-grandson of adam, or that jabal and
;jubel are the great-great-great-great-great-grandsons of adam (hint:represent
;the fact about irad, for example,as ((great grandson) adam irad). write rules
;that determine if a list ends in the word grandson. use this to express a rule
;that allows one to derive the relationship ((great . ? rel) ?x ?y) where ?rel
;is a list ending in grandson. check yourrules on queries such as ((great
;grandson) ?g ?ggs) and (?relationship Adam Irad)



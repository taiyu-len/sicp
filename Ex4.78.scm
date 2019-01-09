;redesign the query language as a nondeterministic program to be implemented
;using te evaluator of section 4.3, rather than as a strema process. in this
;approach, each query will produce a single answer (rather than the stream of
;all answers) and the user cna type try-again to see more answers. you should
;find that much of a mechanism we built in this section is subsumed by
;nondeterministic search and backtracking. you will probably also find however
;that your new query language has subtle differences in behavior from the one
;implemented here. can you find examples that illustrate the difference?


;;what isnt this easy. you just have to return the stream-car, store a new
;;stream-cdr. and tryagain uses the generated results. you could build it in
;;deeper but why...

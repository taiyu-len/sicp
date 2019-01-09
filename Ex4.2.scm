;louis reasoner plans to reorder the ocnd clauses in eval so that the clause for
;procedure applications appears before the clause for assignments. he argues
;that this will mae the interpreter more efficient: since programs usually
;contain more applications than assignments, definitons, and so on, his modified
;eval will usually check fewer clauses then the original eval before identifying
;the type of an expression

;a: what is wrong with louis's plan? (hint: what will louis evaluator do with
;the expression (define x 3)?)

;it would fail as every 'define 'if 'cond whatever will trigger the application?

;b: louis is upset that his plan didnt work. hi is willing to go to any lengths
;to mae his evaluator recognize procedure applications before it checks for most
;other kinds of expressions. help him by changing the syntax of the evaluatied
;language so that procedure application start with call. for example, instead of
;(factorial 3) we will now have to write (call factorial 3) and instead of 
;(+ 1 2) we call (call + 1 2).

;make it the same as the other ones but match 'call




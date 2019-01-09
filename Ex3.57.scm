;how many addition are performed when we ompute the nth fibonacci number using
;the definition of fibs based on theadd-streams procedure? show that the number
;of additions would be exponentially greater if we had implemented (delay <exp>)
;instead of (lambda () <exp) without using the optimization provided by the
;memo-proc procedure described in section 3.5.1

;each stream does n calculations, but since htis one doesnt remember it it takes
;a lot longer. hard to explain but ya

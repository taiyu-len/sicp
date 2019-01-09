;suppose we want to have a polynomial system that is efficient for both sparce
;and dense polynomials. one way to do this is to allow both kinds of term-list
;representations in our system. the situation is analogous to the complex number
;example of section 2.4 where we allowed both rectangular and polar
;representations. to do this we must distinguish different types of term lists
;and make the operations on term lists generic. redisng the poly nomial system
;to implement this gernealization. this is a major effor not a local change.

;>major effort
;nope, dun wana do it

;i have to change the implementation to be tagged.(cons tag data) 
;then (put 'adjoin-term 'dense-poly adjoin-term-dense) and the others into
;there. change it to 
;(define (adjoint-term term list)
;  ((apply-generic 'adjoin-term (list (type term) (type list)))
;   term list)
;and then i would need a raise to raise the dense into a sparce incase they are
;differnt

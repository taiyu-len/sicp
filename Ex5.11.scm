;when we introduced save and restore in 5.1.4 we didnt specify what would happen
;if you tried to restore a register that was not the last on saved, as in the
;sequence, 

;(save y)
;(save x)
;(restore y)
;
;a;simple pop.

;b;pop into y if and only if y was the last pushed

;c;pop the last pushed y into y regardless of where it is.

;hahaha fuck no. push pop, is the only method im going to use.

;for b. you just need to keep last reg.
;for c. you just need to keep a stack for each register



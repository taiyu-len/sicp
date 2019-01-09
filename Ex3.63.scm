;louis reasoner asks why the sqrt-stream procedure was not written in the
;following more straightforward way, without the local variable guesses:

;(define (sqrt-stream x)
;  (cons-stream 1.0
;               (stream-map (lambda (guess)
;                             (sqrt-improve guess x))
;                           (sqrt-stream x))))
;
;alyssaphacker replies that this version of the procedure is considerably less
;efficient because it performs redundant comptations. explain alyssas answer.
;would the two versions still differ in efficiency if our implementation of
;delay used only (lambda ()<+exp+>) without using optimization rpoveded by
;momo-proc

;hmm seems like calling it without the intermediate guess will make it less
;efficient.
;
;it will create an new enviroment everytime it needs to get a new guess, instead
;of just grabbing the current value. 

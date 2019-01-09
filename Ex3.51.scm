;in order ot take a closer look at delayed evaluation,we will use the following
;procedure, which simply returns its argument after printing it:

(define (show x)
  (display-line x)
  x)
;what does the interpreter print in response to evaluting each expression in the
;follwoing sequence?

(define x (stream-map show (stream-enumerate-interval 0 10)))
;(stream-ref x 5)
;(stream-ref x 7)

;it will print out each number from 1,2,3,4,5 and then return 5.
;and then it will print out 6,7 and return 7
;
;the reason for this is cause we use the memo-proc which only remembers the
;return value and so the intermediate fluff such as display get removed

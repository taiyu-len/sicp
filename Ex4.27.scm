;suppose we typein the following defintion to the lazy evaluator:

'(define count 0)
'(define (id x)
   (set! count (+ count 1))
   x)
'(define w (id (id 10)))
;;;input
;count
;;;value
;0
;;;input
;w
;;;value
;2
;;;input
;count
;;;value
;3

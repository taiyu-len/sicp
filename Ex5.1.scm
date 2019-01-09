;design a register machine to compute factorials using the iterative algorithm
;spcified by the following procedure. draw data-paths and controller diagrams
;for this machine.


(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
      product
      (iter (* counter product)
            (+ counter 1))))
  (iter 1 1))



; Start Factorial
; product<-1
; counter<-1
;Start Iter
;/->{ > }-yes->return product
;|    |
;|    V
;| [mul product counter] ;think you can do that in registers. otherwise use temp
;|    |
;|    V
;| [inc counter]
;\___/

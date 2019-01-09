;draw enviroment diagrams to illustrate the evalution of the sequence of
;expressions 

;(define x (cons 1 2))
;(define z (cons x x))
;(set-car! (cdr z) 17)
;(car x)


;z---[_][_]
;     v  v
;x---[1][2]<--(cdr z)
;    /
;set-car! (cdr z) 17
;
;z-->[_] [_]
;     v   v
;x-->[17][2]
;
;(car x) = 17


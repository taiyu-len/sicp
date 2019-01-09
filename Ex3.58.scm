;give an interpretation of the stream computed by the following procedure:

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix)den)
    (expand (remainder (* num radix) den) den radix)))

;(quotient is a primitive that returns the integer quotient of two integerss) 
;what are the successive elements produced by (expand 1 7 10). what is
;produced by (expand 3 8 10)


;3 , expand 6 8 10
;7 , expand 4 8 10
;5 , expand 0 8 10
;0...
;so its the decimal version of it. 3/8 = .375
;
;(expand 1 7 10)= (1,4,2,8,5,7,1,4,2,8,5,7,...)
;so 1/7

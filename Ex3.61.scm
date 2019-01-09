;let s be a power series whose constant term is 1. suppose we wat to find the
;power series 1/S, that is, the series X such that S.X=1. write S=1+S_r where
;S_R is the part of S after the constant term. then we can solve for X as
;follows


;S*X = 1
;(1+S_R)*x = 1
;X+S_R*X = 1
;X=1-S_R*X
;
;in other words, X is the power series whose constant term is 1 and whose
;higher-order terms are given by the negative o S_4 times X. use this idea to
;write a procedure inver-unit-series that computes 1/S for a power series S with
;a constant term 1. you will need to use mul-series from 3.60


(define (invert-unit-series s)
  (cons-stream 1 
               (scale-stream (mul-series (stream-cdr s)
                                         (invert-unit-series s))
                             -1)))

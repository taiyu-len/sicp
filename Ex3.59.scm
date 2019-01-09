;in section 2.5.3 ew saw how to implement a polynomial arithmetic system
;representing polynomials as lists of terms. in a similar way, we can work with
;power series, such as

;e^x = SUM[n=0->inf] (x^n)/(n!)

;cos(x) = SUM[n=0->inf] ((-1)^nx^{2n}) / (2n!)

;sin(x) = SUM[n=0->inf] ((-1)^nx^{2n+1})/((2n+1)!)

;represented as infinite streams. we will represent the series a_0 + a_1x +
;a_2x^2+... as the stream whose elements are the coefficients a_0,a_1,a_2,...

;a: the integral of the series a_0,a_1x,a_2x^2,... is the series

;c + a_0x+a_1x^2/2+...

;where c is any constant. define a procedure integrate-series that takes as
;input a stream a_0,a_1,a_2,... representing a power series and returns the
;stream a_0,(1/2)a_1,(1/3)a_2,... of coefficients of the nonconstant terms of
;the integral of the series. (since the result has no constant term, it doesnt
;represent a pwoer series; when we use integeate-series, we will cons on the
;appropriate constant.
(define (div-streams n d)
  (stream-map / n d))
(define (integrate-series S)
  (stream-map * (stream-map / ones integers) S))
;b:the functipon x->e^x is its own derivative. this implies that e^x ad the
;integral of e^x are the same series, except for the constant term, which is
;e^0=1. accordingly, we can generate the series for e^x as
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;show how to generate the series for sine and cosine, starting from the fact
;that the derivative of sine is cosine and derivative of cosine is the negative
;of sine:

(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

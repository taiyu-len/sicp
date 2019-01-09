;define P_1,P_2,P_3 to be the polynomials
;P_1 : x^2-2x+1
;P_2 : 11x^2+7
;P_3 : 13x+5
;now define  Q_1=P_1+P_2  and  Q_2=P_1+P_3.  and use  greatest-common-divisor
;to compute the  GCD  of  Q_1 & Q_2. Note that the answer is not the same as P_1
;This example introduces noninteger operations into the computation, causing
;difficulties with the gcd algorithm. to understand what is happining try
;tracing  gcd-terms  while computing the GCD or try performing the division by
;hand.

;we cna solve the problem exhibited in exersize 2.95 if we use the following
;midification of the GCD algorithm(which really works only in the case of
;polynomials with ineger coefficients). Before performing any polynomial
;division in the gcd computation, we multiply the dividend by an integer
;constant factor, chosen to guarantee that no fractions will arise during the
;division process. our answer will thus differ from the actual gcd by an integer
;constant factorm but htis does not matter in the case of reduing rational
;functions to lewsetr terms; the gcd will be used to divide both the numerator
;and denominator so the integer constant factor will cancel out.

;more precisly, if P and Q are polynomials, let O_1 be the order of P. and let
;O_2 be the order of Q. let c be the leading coefficient of Q. then it can be
;shown that, if we multiply P by the integerizing factor  c^{1+O_1-O_2) the
;resulting polynomial can be dicided by Q by using the div-terms algoithm withou
;introducing any fractions. the operation of mulitplying the dividend by this
;constant and then dividing is sometimes called the pseudodivision of P by Q.
;the reaminder of the division is called the pseudoremainder.
;

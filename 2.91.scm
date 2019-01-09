;a univaraite polynomial can be divided by another one to produce a polynomial
;quotient and a polynomial remainder.
;
;\frac{x^5-1}{x^2-1} = x^3+x, remainder x-1
;
;division can be performed via long division.
;divide highest order term of dividend by highest of divisor
;this is the first term in the answer
;next mutliply this term by the divisor
;subtract that form the dividend
;and produce the rest of the answer by recursively dividing the difference by
;the divisor.
;stop whe the order of the divisor exceeds the order of the dividend and declar
;the dividend the the reaminder. also if the dividend ever becmes zero return 0
;as both quotient and remiainder

;we cna design a div-poly procedure on the model of add-poly and mul-poly. the
;procedure checks to see if the two polys have the same variable, if so div-poly
;strips off the variable and passes the problem to div-terms, which performs the
;division operation on term lists. div-poly finally reattaches the variable to
;the result supplied by div terms. it is convenient to design div-terms to
;complute both the quotient and the remainder of a division. div-terms can take
;two term list as arguments and returns a list of the quotient term list and
;remainder term list
;
;complete the following definition of div-terms by filling in the missing
;exxpressions. use this to implement div-poly which takes two polys as arguments
;and returns a list of the quotient and remiainder polys

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist)L1)
        (let ((new-c (div (coeff t1) (coeff t2)))
              (new-o (- (order t1) (order t2))))
          (let ((rest-of-result
                  (div-terms (sub-terms L1
                                        (mul-terms L2
                                                   (list (make-term new-o new-c))))
                             L2))
                (cadr rest-of-result))))))))

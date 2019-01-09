;louis reasoner tries to evaluate the expression (magnitude z) where z is the
;object shown in figure 2.24. to his suprice, instead of the answer 5 he gets an
;error message from apply0generic saying there is no method for the operations
;magnitude on the types (complex). he shows this interaction to alyssa who says
;"the problem is that the complex number selectors were never defined for
;complex numbers, just polar and rectangular numbers. all you have to do to make
;this work is add the following to the compelx package.
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

;describe in detail why this works. as an example, trace through all the
;procedrs called in evaluating expression (magnitude z) where z is the object
;shown in figure 2.24. in particular how many times is apply-generic invoked?
;what procedure is dispatched in each case.

;(magnitude z)    z = ('complex('rectangular x y))
;(apply-generic 'magnitude z)
;((get 'magnitude '(complex))(contents z))
;as we put 'magnitude 'complex into the table we can get it out now
;(magnitude (contents z))
;(apply-generic 'magnitude (contents z))
;((get 'magnitude 'rectangular)(contents(contents z)))
;and we can now get the magnitude from rectangular package


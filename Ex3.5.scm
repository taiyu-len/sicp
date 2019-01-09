;mote carlo integration is a method of estimating definite integrals by means of
;monte carlo simulation. consider computing the area pof a region of space
;described by a predicate P(x,y) that is true for points (x,y) in the region and
;false for point not in the region. for example, the region contained within a
;circle of radius 3 centered at (5,7) is described by the predicate that tests
;whether (x-5^2+(y-7)^2<=3^2. to estimate the area of the region described by
;such a predicate, begin by choosing a rectangle that contains the region, for
;example, a rectangle with diagonally opposite corners at (2,4) and (6,19)
;cotntains the circle above. the desired inegral is the area of that portion of
;the rectangle that lies in the region. we can estimate the integral by picking
;at random points (x,y) that lie in the rectangle and testing P(x,y) for each
;point to determine whether that point lies in the region. if we try this with
;many points, then the fraction of points that fall in the region should give an
;estimate of the proportion of the rectangle that lies in the region. hence
;multiplyin this fraction by the area of the entire rectangle should produce an
;estimate of the integral

;implement monte carlo integration as a procedure  estimate-integral  that takes
;as arugments a predicate P, upper and lower bounds  x1,x2,y1,y2 for the
;rectangle and the number of trials to perform in order to produce the estimate.
;your procedure should use the same monte-carlo procedure that was used above to
;estimsate  /pi.  use your estimate-integral to produce an estimte of /pi by
;measuring the area of a unit circle.

;you will find it useful to have a procedure that retunrs a number chosen at
;random from a give range. the following random-in-range procedure implements
;his in terms of the random procedure used in section 1.2.6 which returns a
;nonnegative number less then its inputs

(define (random-in-range low high)
  (let ((range (- high low)))
   (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (test pass count)
    (if (= 0 count)
      (/ (* pass 1.0) trials)
      (test (if (let ((x (random-in-range x1 x2))
                      (y (random-in-range y1 y2)))
                (P x y))(+ pass 1) pass)
            (- count 1))))
  (test 0 trials))


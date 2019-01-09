;exercise 3.6 discussed generalizing the random-number generator to allow one to
;reset the random number sequence so as to produce repeatable sequences of
;"random" numbers. produce a stream formulation of this same generator that
;operates on an input stream of requests to generate a new random number or to
;reset the sequence to a specified value and that produces the desired stream of
;random numbers. dont use assignment in the soltuion

(define (random-update x)
  (+ (* (remainder (expt x 2) 551)
        (remainder (* x 15) 423)
        (remainder (* x 19) 391))
     (remainder (* x 913) 5257)))
(define random-init (random-update (expt 2 32)))

(define (random-stream command-stream)
  (define random-number
    (cons-stream
      random-init
      (stream-map (lambda (num cmd)
                    (cond ((null? cmd)the-empty-stream)
                          ((eq? cmd 'generator)
                           (random-update num))
                          ((and (pair? cmd)
                                (eq? (car cmd)'reset)))
                          (else
                            (error "bad command --" cmd))))
                  random-stream
                  command-stream)))
  random-number)

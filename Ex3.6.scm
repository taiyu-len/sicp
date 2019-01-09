;it is useful to be able to reset a random-number generator to produce a
;sequence starting from a given value, design a new rand procedure that is
;called with an argument that is either the symbol generate or the symbol reset
;and behaves as follows:  (rand ' generate) produces a new random number
;((rand 'reset) <+new_value+> resets the internal state variable to the
;designated <+new_value+> thus by reseting the state, one can generate
;repeatable sequences. these are very handy when testing and debugging programs
;that use random numbers.

;ok using since i dont have the seeding function yet we will just assume we have
;it
(define (seed . x)
  (let ((init 0))
    (if (null? x)
      init
      (set! init (car x)))))

(define (rand)
  (define init-rand seed)
  (let ((randfunc (init-rand 1)))
   (lambda (act)
     ((cond ((eq? act 'generate)
             (random 1.0))
            ((eq? act 'reset)
             seed)
            (else "LOLFAIL"))))))



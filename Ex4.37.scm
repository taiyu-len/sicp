;ben claims thjat the folllwing method forgenerating pythagorean triples is more
;efficient that the one in exercise 4.35. is he correct? (hint consider the
;number of possibilites that must be explored)

(define (a-pythagorean-triple-between2 low high)
  (let* ((i (an-integer-between low high))
         (hsq (* high high))
         (j (an-integer-between i high))
         (ksq (+ (* i i) (* j j))))
    (require (>= hsq ksq))
    (let ((k (sqrt ksq)))
     (require (integer? k))
     (list i j k))))

;seems fasterish i guess.

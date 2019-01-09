;modify the pairs procedure so that (pairs integers integers) will produce the
;stream of all pairs of integers (without the condition i<j). hint you will need
;to mix in another stream.

(define (all-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (interleave
        (stream-map (lambda (x) (list (stream-car s)x))
                    (stream-cdr t))
        (all-pairs (stream-cdr s) (stream-cdr t)))
      (stream-map (lambda (x) (list x (stream-car t)))
                  (stream-cdr s)))))


;00,01,02,03,04
;10,11,12,13,14
;20,21,22,23,24
;30,31,32,33,34
;40,41,42,43,44
;50,51,52,53,54
;60,61,62,63,64


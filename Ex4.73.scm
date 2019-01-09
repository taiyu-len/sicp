;why does flatten-stream use delay explicitly? what would be wrong with defining
;it as follows

(define (flatten-stream stream)
  (if (stream-null? stream)
    the-empty-stream
    (interleave
      (stream-car stream)
      (flatten-stream (stream-cdr stream)))))
;cause it might not be defined yet.

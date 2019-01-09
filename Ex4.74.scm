;alyssa proposes to use a simpler version of stream-flatmap in negate.
;lisp-value and findassertions. she  observes that the procedure that is mapped
;over the frame stream in these cases always produces either the empty stream or
;a singleton stream, so no interleaving is needed when combining these streams

;a;fill in the missing expressions in alyssa program

(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter
                (lambda (s) (not (stream-null? s)))
                stream)))

;no



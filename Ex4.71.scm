;louis reasoner wonders why the simple-query and disjoin procedures are
;implemented using explicit delay operations, rather than being defined as
;follows.

(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (stream-append (find-assertions query-pattern frame)
                     (apply-rules query-pattern frame)))
    frame-stream))

(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
    the-empty-stream
    (interleave
      (qeval (first-disjunct disjuncts) frame-stream)
      (disjoin (rest-disjuncts disjuncts) frame-stream))))

;cause it would try to evaluate the (apply-rule...) stuff.

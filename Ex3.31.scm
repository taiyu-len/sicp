;the internal procedure  accept-action-procedure!  defined in  make-wire
;specifies that when a new action procedure is added to a wire, theprocedure is
;immediately run. explain why this initialization is necessary. in particular,
;trace though the half-adder example in the paragraphs above and say how the
;systems response would differ if we had defined  accept-action-procedure as

;(define (accept-action-procedure! proc)
;  (set! action-procedures (cons proc action-procedures)))

;when you create a logic gate, it calls it once on each wire to update the state
;of the entire system that it affects.
;or something like that

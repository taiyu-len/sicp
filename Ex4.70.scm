;what is the purpose of the let bindings in the procedure add-assertion! and
;add-rule!? what would be wrong witht he following implementation of
;add-assertion! ? Hint: recall the definition of the infinite stream of ones in
;section 3.5.2: (define ones (cons-stream 1 ones))

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
    (cons-stream assertion THE-ASSERTIONS))
  'ok)

;cause it uses delay, the  THE-ASSERTIONS when finally accessed would be

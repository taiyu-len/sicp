;consider an alternative strategy for scanning out definitions that translate
;the example in the text to 


(lambda <vars>
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (let ((a <e1>)
          (b <e2>))
      (set! u a)
      (set! v b))
    <e3>))


(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;will this procedure work if internal definitions are scanned out as shown in
;this exercise? what if they are scanned out as shown in the text? explain.

;noworky

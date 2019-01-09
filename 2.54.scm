;2.54; two lists are said to be equal? if they contain equal elements arrange in
;the same order.

(define (equal? first . rest)
  (define (equal-pair a b)
    (cond ((and (null? a) (null? b))#t)
          ((or  (null? a) (null? b))#f)
          ((not (eq? (car a) (car b)))#f)
          (else (equal-pair (cdr a) (cdr b)))))
  (if (null? (car rest))
    #t
    (if (equal-pair first (car rest))
      (equal? first (cdr rest))
      #f)))


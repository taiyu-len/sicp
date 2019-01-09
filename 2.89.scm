;define procedures that implement the term-list representation described above
;as appropriate for dense polynomials

(define (adjoin-term term term-list)
  (let ((l1 (order term)) (l2 (order term-list)))
   (cond ((= l1 l2) (map + term term-list))
         ((< l1 l2) (adjoin-term (cons 0 term) term-list))
         ((> l1 l2) (adjoin-term term (cons 0 term-list))))))
(define (the-empty-termlist) '())
(define (first-term term-list) term-list)
(define (rest-term term-list)(cdr term-list))
(define (empty-termlist? tl) (null? tl))
(define (make-term order coeff)
  (if (= order 0)
    (cons coeff '())
    (cons coeff (make-term (- order 1) 0))))
(define (order term) (- (length term 1)))
(define (coeff term) (car term))

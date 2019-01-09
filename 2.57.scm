;extend the differnetiation program to handle sums and products of arbitrary
;numbers of terms. 

(define (sum a)
  (if (null? a)
    0
    (+ (car a) (sum (cdr a)))))

(define (make-sum . a)
  (let ((numbers (sum (filter number? a)))
        (rest (filter (lambda (x) (not (number? x)))a)))
    (cond ((null? rest)numbers)
          ((= numbers 0)
           (if (null? (cdr rest))
             (car rest)
             (append '(+) rest)))
          (else (append '(+) (list numbers rest))))))
(define addend cadr)
(define augend cddr)
(define (product a)
  (if (null? a)
    1
    (* (car a) (product (cdr a)))))

(define (make-product . m)
  (let ((numbers (product (filter number? m)))
        (rest (filter (lambda (x) (not (number? x)))m)))
    (cond ((= numbers 0)0)
          ((null? rest)numbers)
          ((= numbers 1)
           (if (null? (cdr rest))
             (car rest)
             (append '(*) rest)))
          (else (append '(*) (list numbers rest))))))
(define multiplier cadr)
(define multiplicand cddr)


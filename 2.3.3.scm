;2.3.3

(define (element-of-set? x set)
  (cond ((null? set)#f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))
(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2))'())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1)set2)))
        (else (intersection-set (cdr set1) set2))))

(load "/home/project/scheme/2.59.scm")
(load "/home/project/scheme/2.60.scm")

(define (element-of-set? x set)
  (cond ((null? set)#f)
        ((= x (car set))#t)
        ((< x (car set))#f)
        (else (element-of-set? x (cdr set)))))
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
     (cond ((= x1 x2)
            (cons x1
                  (intersection-set (cdr set1)
                                    (cdr set2))))
           ((< x1 x2)
            (intersection-set (cdr set1) set2))
           ((> x2 x1)
            (intersection-set set1 (cdr set2)))))))
(load "/home/project/scheme/2.61.scm")
(load "/home/project/scheme/2.62.scm")

(define entry car)
(define left-branch cadr)
(define right-branch caddr)
(define make-tree list)

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set))#t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))
(load "/home/project/scheme/2.63.scm")

(load "/home/project/scheme/2.64.scm")

(load "/home/project/scheme/2.65.scm")

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

(load "/home/project/scheme/2.66.scm")



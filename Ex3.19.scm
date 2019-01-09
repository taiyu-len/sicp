;redo 3.18 using an algorithm that only takes a constant amount of space. (this
;requires a very clever idea)


(define (cycle? lst)
  (define (in-lst? x y n)
    (if (= n 0) #f
      (if (eq? x y) #t
        (in-lst? x (cdr y)(- n 1)))))
  (define (check x n)
    (if (null? x) #f
      (if (in-lst? x lst n) #t
        (check (cdr x) (+ n 1)))))
  (check lst 0))

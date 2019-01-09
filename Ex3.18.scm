;write a procedure that examines a list and determines whether it contains a
;cycle, that is whether a program that tried to find the end of the list by
;taking successive cdrs would go into a infinite loop. exersize 3.13
;constructed such lists.

(define (cycle? x)
  (let ((checked '()))
   (define (check x)
     (cond ((null? x)#f)
           ((memq x checked)#t)
           (else
             (set! checked (cons x checked))
             (check (cdr x)))))
   (check x)))

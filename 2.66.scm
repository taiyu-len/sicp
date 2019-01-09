; implement the lookup procedure for the case where the set of records is
; structures as a binary tree, ordered by the numerical value of keys.

(define (lookup id records)
  (let ((this (key (entry records))))
   (cond ((null? records)#f)
         ((= id this)
          (entry records))
         ((< id this)
          (lookup key (left-branch records)))
         ((> id this)
          (lookup key (right-branch records))))))


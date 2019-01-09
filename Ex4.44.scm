;write a non deterministic program to solve an N queens puzzle.

(define (enumerate-interval l h)
  (if (> l h)
    '()
    (cons l (enumerate-interval (+ l 1) h))))
(define (attacj? row1 col1 row2 col2)
  (or (= row1 row2)
      (= col1 col2)
      (= (abs (- row1 row2)) (abs (- col1 col2)))))
(define (safe? k positions)
  (let ((kth-row (list-ref positions (- k 1))))
   (define (safe-iter p col)
     (if (>= col k)
       #t
       (if (attack? kth-row (car p) col)
         #f
         (safe-iter (cdr p) (+ col 1)))))
   (safe-iter positions 1)))
(define (list-amb li)
  (if (null? li)
    (amb)
    (amb (car li) (list-amb (cdr li)))))

(define (queens n)
  (define (queen-iter k positions)
    (if (= k n)
      positions
      (let* ((row (list-amb (enumerate-interval 1 n)))
             (new-pos (append positions (list row))))
        (require (safe? k new-pos))
        (queen-iter (+ k 1)new-pos))))
  (queen-iter 1 '()))

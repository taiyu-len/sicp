;a deque, is a sequence in which items can be inserted and dleted at either the
;front or the rear. operations on deques are the 
;Constructor
;  make-deque
;Predicate
;  empty-deque?
;Selectors
;  front-deque, rear-deque
;Mutators
;front-insert-deque!,rear-insert-deque!,front-delete-deque!,rear-delete-deque!

;hsow how to represent deques using pairs, and give implementations of the
;operations. all operations should be accomplished in O(1) steps

(define (make-deque)(cons '() '()))
(define (empty-deque? d) (null? (car d)))

(define (make-deque-obj i last next)
  (let ((obj (cons last (cons (cons i 'A) next))))
   (set-cdr! (cadr obj) obj)
   obj))
(define (next-obj d) (cddr d))
(define (last-obj d) (car d))
(define (deque-item d) (caadr d))

(define (front-deque q) (car q))
(define (rear-deque q) (cdr q))

(define (forward-deque? d);using this cause cycles
  (define (make d)
    (if (null? d)
     '()
      (cons (deque-item d)(make (next-obj d)))))
  (make (car d)))
(define (backward-deque? d)
  (define (make d)
    (if (null? d)
     '()
      (cons (deque-item d) (make (last-obj d)))))
  (make (cdr d)))

(define (front-insert-deque! q i)
  (let ((new (make-deque-obj i '() (front-deque q))))
   (if (empty-deque? q)
     (begin (set-car! q new) (set-cdr! q new))
     (begin (set-car! (front-deque q) new) (set-car! q new)))))
(define (rear-insert-deque! q i)
  (let ((new (make-deque-obj i (rear-deque q) '())))
   (if (empty-deque? q)
    (begin (set-car! q new) (set-cdr! q new))
    (begin (set-cdr! (cdr (rear-deque q)) new) (set-cdr! q new)))))
(define (front-delete-deque! q)
  (if (empty-deque? q);no objects
    "Error Empty"
    (if (eq? (front-deque q) (rear-deque q))
      (begin (set-cdr! q '()) (set-car! q '()))
      (begin
        (set-car! q (next-obj (front-deque q)))
        (set-car! (front-deque q) '())))))
(define (rear-delete-deque! q)
  (if (empty-deque? q)
    "Error Empty"
    (if (eq? (front-deque q) (rear-deque q));one obj
      (begin (set-cdr! q '()) (set-car! q '()))
      (begin
        (set-cdr! q (last-obj (rear-deque q)))
        (set-cdr! (cdr (rear-deque q)) '())))))



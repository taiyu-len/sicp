;Representing Queues

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
    (error "Front Called With Empty Queue" queue)
    (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
   (cond ((empty-queue? queue)
          (set-front-ptr! queue new-pair)
          (set-rear-ptr! queue new-pair)
          queue)
         (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (if (empty-queue? queue)
        (error "Delete! called with empty queue" queue)
        (begin
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue)))

(load "/home/project/scheme/Ex3.21.scm")
(load "/home/project/scheme/Ex3.22.scm")
(load "/home/project/scheme/Ex3.23.scm")

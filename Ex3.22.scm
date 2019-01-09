;instaead of preresenting a queue as a pair of pointers. we can build a queue as
;a procedure with local state. the local state will consist of pointers to the
;beginning and the end of an ordinary list thus make-queue procedure will have
;the form 

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty?) (null? front-ptr))
    (define (insert! data)
      (let ((new (cons data '())))
       (cond ((empty?)
              (set! front-ptr new)
              (set! rear-ptr new)
              front-ptr)
             (else
              (set-cdr! rear-ptr new)
              (set! rear-ptr new)
              front-ptr))))
    (define (delete!)
      (cond ((empty?)
             (error "Nothing To Delete"))
            (else
              (set! front-ptr (cdr front-ptr)))))
    (define (dispatch m)
      (cond ((eq? m 'insert!)insert!)
            ((eq? m 'empty? )(empty?))
            ((eq? m 'delete!)(delete!))
            (else
              "Unknown Function")))
    dispatch))

;complete the definition of make-queue and provide implementations of the queue
;operations using this representation

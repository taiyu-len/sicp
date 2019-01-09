;a semaphore (of size n) is a generalization of a mutex. like a mutex, a
;semaphore supports acquire and release operations, but it is more general in
;that up to n processes can acquire it concurrently. additional processes that
;attempt to acquire the semaphore must wait for realease operations. give
;implemenation of semaphore


(define (make-semaphore max)
  (let ((n 0))
    (define (the-semaphore s)
      (cond ((eq? s 'acquire)
             (if (= n max)
               (the-semaphore 'acquire)
               (set! n (+ n 1))))
            ((eq? s 'release) (set! n (- n 1)))))
    the-semaphore))

;lol woops didnt read next page
;just make N have an accociated inc function and mutex it

;in the table  implementation above, the keys are tested for equality using
;equal? (called by assoc). this is not always the appropriate test. for
;instance, we might have a table with numeric keys in which we dont need an
;exacyt match to the number were looking up, but only a number wihtiin some
;tolerance of it. design a table constructuor  make-table  that takes as an
;argument  a  same-key? procedure that will be used to test equality of keys.
;make-table should returna dispatch procedure that can be used to access
;appropriate lookup and insert! procedures for a local tables
;3.3.3 representing tables


(define (make-table same-key?)
  (let ((local-table (list '*table*)))
   (define (assoc key table)
     (cond ((null? records)#f)
           ((same-key? key (caar records)) (car records))
           (else (assoc key (cdr records)))))
   (define (lookup key-1 key-2)
     (let ((subtable (assoc key-1 (cdr local-table))))
      (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
         (if record (cdr record) #f))
        #f)))
   (define (insert! key-1 key-2 value)
     (let ((subtable (assoc key-1 (cdr local-table))))
      (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
         (if record
           (set-cdr! record value)
           (set-cdr! subtable
                     (cons (cons key-2 value)
                           (cdr subtable)))))
        (set-cdr! local-table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr local-table)))))
     'ok)
   (define (dispatch m)
     (cond ((eq? m 'lookup-proc)lookup)
           ((eq? m 'insert-proc!)insert!)
           (eles (error "Unknown Operation -- TABLE" m))))
   dispatch))

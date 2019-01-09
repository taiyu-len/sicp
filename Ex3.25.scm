;generalzing one- and two- dimensional tables, show how to implement a table in
;which values are stored under an arbitrary number of keys and different values
;may be stored under different numbers of keys. the lookup and insert!
;procedures should take as input a list o keys used to access the table

;
(define (make-table)
  (define (lookup key-list table)
    (let ((subtable (assoc (car key-list) (cdr table))))
     (if subtable                         ;if our key gets a result
       (if (null? (cdr key-list))         ;and if we have no more keys
         (cdr subtable)                   ;return the answer
         (lookup (cdr key-list) subtable));search keys in the new subtable
       #f)));couldent find anything
  (define (insert-new! key-list value)
    (if (null? (cdr key-list))
      (cons (car key-list) value)
      (cons (car key-list) (insert-new! (cdr key) value))))
  (define (insert! key-list value table)
    (let ((record (assoc (car key-list) (cdr table))))
     (if record    ;if we hit something
       (if (null? (cdr key-list));and if we have more keys to go through
           (set-cdr! record value);we stick it in 
           (insert! (cdr key-list) value record))
       (if (null? (cdr key-list)); nomore
           (set-cdr! table
                     (cons (cons (car key-list) value) (cdr table)))
           (set-cdr! table
                     (cons (insert-new! key-list value)
                           (cdr table))))))
    'ok))

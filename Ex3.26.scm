;to search a table as implemented above, one needs to scan through the list of
;records. this is basically the unordered list representatiion of section 2.3.3
;for large tables, t ame by more efficient to structure the table in a different
;manner. describe a table implmentation where the (key,value) records are
;orgaanized using a binary tree, assuming that keys can be ordered in some way
;(numercally or alphabetically) (compare exercise 2.66 of ch 2);


(define (make-table)
  (let ((table (cons '*table '())));setup the table data
   (define (key? entry) (car entry))
   (define (value? entry) (cadr entry))
   (define (left-entry? entry) (caddr entry))
   (define (right-entry? entry) (cdddr entry))
   (define (table? entry) (pair? (value? entry)))
   (define (make-entry key value left right)
     (cons key (cons value (cons left right))))
   (define (key-cmp a b) (- b a))
   (define (lookup-key key entry)
     (cond ((null? entry)#f)
           ((= 0 (key-cmp key (key? entry)))(value? entry))
           ((> 0 (key-cmp key (key? entry)))(lookup-key key (left-entry? entry)))
           ((< 0 (key-cmp key (key? entry)))(lookup-key key (right-entry? entry)))))
   (define (lookup key-list record)
     (let ((search (lookup-key (car key-list) record)))
      (if search
        (if (null? (cdr key-list))
          (value? search)
          (lookup (cdr key-list) (value? search)))
        #f)))
   (define (insert-new! key-list value)
     (if (null? (cdr key-list))
       (cons (car key-list) (cons value (cons '() '())))
       (cons (car key-list) (cons (insert-new! (cdr key-list value)) (cons '()'())))))
   (define (insert! key-list value record)
     (let ((entry (lookup-key (car key-list)record)))
      (if entry
        (if (null? (cdr key-list))
          (set-car! (cdr entry) value)
          (insert! (cdr key-list) value (value? entry)))
        (set-cdr! record
                  (cons (insert-new! key-list value)
                        (cdr record))))
      'ok))
   ))



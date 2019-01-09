;the encode procedure takes as arguments a message and a tree and produces the
;list of bits that gives the encoded message
(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message)tree)
            (encode (cdr message) tree))))

;encode-symbol is a procedure,which you must write, that returns the list of
;bits that encodes a given symbol according to a given tre. you should design
;encode-symbol so that it signals an eror if the symbol is not in the tree at
;all. test your procedure by encoding the result you obtained in exercise 2.67
;with the sample tree and seeing whehter it is the same as the original message

(define (encode-symbol sym tree)
  (cond ((leaf? tree)
         ())
        ((memq sym (symbols (left-branch tree)))
         (cons 0 (encode-symbol sym (left-branch tree))))
        ((memq sym (symbols (right-branch tree)))
         (cons 1 (encode-symbol sym (right-branch tree))))
        (else (error "symbol " sym "does not exist in tree"))))


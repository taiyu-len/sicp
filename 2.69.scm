;the following procedure takes as its argument a list of symbol-frequency pairs
;and generates a huffman encoding tree according to the huffman algorithm
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;make-leaf-set is the procedure given above that transforms the list of pairs
;into an ordered set of leaves. successive-merge is the procedure you must
;write, using make-code-tre to successivly merrge the smallest-weight elements
;of hte set until there is only one element left ,which is the desired huffman
;tree

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (cons (make-leaf (caar pairs) (cadar pairs))
          (make-leaf-set (cdr pairs)))))
(define (successive-merge leaves)
  (if (smallest? leaves)
    leaves
    (successive-merge (merge-smallest leaves))))
(define smallest? (lambda (x)
                    (null? (cdr x))))
(define (merge-smallest leaves)
  (if (and
        (>= (pair-weight leaves) (pair-weight (cdr leaves)))
        (not (null? (cddr leaves))))
    (cons (car leaves) (merge-smallest (cdr leaves)))
    (cons (make-code-tree
            (car leaves)
            (cadr leaves))
          (cddr leaves))))
(define (pair-weight leaves)
  (+ (weight (car leaves))
     (if (null? (cdr leaves))
       0
       (weight (cadr leaves)))))

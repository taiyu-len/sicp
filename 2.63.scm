;each of the following two procedures converts a binary tree to a list

(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list (right-branch tree)
                                        result-list)))))
  (copy-to-list tree '()))

;do the two procedures produce the same result for every tree? if not how do the
;results differ? what lists do the two procedure produce for the trees in figure
;2.16;

;(1 3 5 7 9 11)
; so the same
;they have the same order of growth




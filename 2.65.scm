;use the results of 2.63 and 2.64 to give O(n) implementation of union-set and
;intersection-set for sets implemented as balanced binary trees

;basically
(define (union-tree-from-set set1 set2)
  (list->tree
    (union set1 set2)))
(define (union-tree set1 set2)
  (list->tree
    (union (tree->list set1) (tree->list set2))))

;and the same for intersection


;the following prcedure list->tree converts an ordered list to a balanced binary
;tree. the helper procedure partial-tree takes as arguments an integer n and  a
;list of at least n elements and constructs a balanced tree contatining the
;first n elemnts of hte list. the result returned by partial-tree is a pair
;whose car is the constructed tree and whose cdr is the list of elements not
;included in the tree

(define (list->tree elements)
  (define (partial-tree elts n)
      (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2)))
         (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
  (car (partial-tree elements (length elements))))

;write a short paragraph explaining as clearly as you can how partial tre works.
;draw the tree produced by list->tree for the list (1 3 5 7 9 11)
;
;it splits it into 2 parts first  (left)(nonleft).
;it the recursivly does the same to the (left) subtree until it is empty
;the tree
;
;now in the lowest recursion it takes the (nonleft) and splits it into
;(entry)(right). and now it does the same to (right) as it did left.
;once it does that is makes a tree of (entry)(left)(right) which itself is
;either a left branch or right branch or the root. and then its finishes itself
;and its done.

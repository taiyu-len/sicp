;the following procedure for appending litss was introduced in section 2.2.1

(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x)y))))

;append forms a new list by successibly consing the elements of x onto 6. the
;procedure append! is similar to append, but it is a mutator rather then a
;constructor. it appends the lists by splicing htme together, modifying the
;final pair of x so that its cdr is now y. (it is an error to call append! with
;an empty x

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

;here last-pair is a procedure that returns the last pair in its argument.

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

;consider the interaction

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
;z = (a b c d)
(cdr x)
;(b)
(define w (append! x y))
;w = (a b c d)
(cdr x)
;(b c d)


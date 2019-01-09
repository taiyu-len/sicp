;lous intutition in exersize 4.20 is correct, it is indeed possible to specifiy
;recursive procedures without using letrec (or even define), although the method
;for accomplishing this is much more subtle than louis imagined. the following
;expression computes 10 factorial by applying a recusive factorial procedure

'((lambda (n)
    ((lambda (fact)
       (fact fact n))
     (lambda (ft k)
       (if (= k 1)
         1
         (* k (ft ft (- k 1)))))))
  10)

;check that this really does compute factorials devise an analogous expression
;for computing fibonaci numbers.

'((lambda (n)
    ((lambda (fib)
       (fib fib 1 0 1))
     (lambda (fi x a b)
       (if (= x n)
         a
         (fi fi (+ x 1)b (+ a b) )))))
  10)

;real fucking neato


;consider the following procedure, which includes mutually recursive internal
;defintions:

(define (f x)
  (define (even? n)
    (if (= n 0)
      true
      (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0)
      false
      (even? (- n 1))))
  (even? x))

;fill in the missing expresisons to coplete an alternative defintion of f, which
;uses neither internatl defintions nor letrec:

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0)#t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0)#f (ev? ev? od? (- n 1))))))

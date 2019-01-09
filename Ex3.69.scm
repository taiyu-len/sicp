;write a procedure triples that takes three infinite streams, S,T,U and produces
;the stream of triples (S_i,T_j,U_k) such that  i<j<k. use triples to generate
;the tsream of all pythagorean triples of positive integers i.e. the triples
;such that i<j and i^2+j^2=k^2


;weaves anynumber of streams
(define (weave . slist)
  (if (stream-null? (car slist))
    (apply weave (cdr slist))
    (cons-stream (stream-car (car slist))
                 (apply weave (append (cdr slist)
                                      (list (stream-cdr (car slist))))))))

(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map (lambda (x) (cons (stream-car s) x))
                  (stream-cdr (pairs t u)))
      (triples (stream-cdr s)
               (stream-cdr t)
               (stream-cdr u)))))

(define (pythagorian-numbers)
  (define (square x) (* x x))
  (define numbers (triples integers integers integers))
  (stream-filter (lambda (x)
                   (= (square (caddr x))
                      (+ (square (car x)) (square (cadr x)))))
                 numbers))


;lol forgot the infinite loop pairs from before

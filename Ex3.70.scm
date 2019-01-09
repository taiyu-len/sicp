;it would be nice to be able to generate streams in which the paairs appear in
;some usefulorder, rather than in the order that results from an adhoc
;interleaving process, we can use atechnique similar to the merge procedure of
;exercize 3.56, if we define a way to say that one pair of integers is less then
;another. one way to do this is to define a "weighting function" W(i,j) and
;stipulate that (i_1,j_1) is less then (i_2,j_2) if the wieight is less. write a
;procedure merge-weighted that is like merge, except that merge-weighted takes
;an additional argument weight, which is a pocedure that computes the weight of
;a pair, and is used to determine the order inw hich elements wshould appear in
;the resulting merged stream. using this, generalize pairs to procedure
;weighted-pairs thta takes two streams, together with a procedure that computes
;a weighting function and generates the stream of pairs, ordered according to
;weight. use your procedure to generate
(define (weighted-pairs s t weight)
  (define (merge-weighted s1 s2)
    (cond ((stream-null? s1) s2)
          ((stream-null? s2) s1)
          (else
            (let ((car1 (stream-car s1))
                  (car2 (stream-car s2)))
              (cond ((<(weight car1)(weight car2))
                     (cons-stream car1
                                  (merge-weighted (stream-cdr s1) s2)))
                    ((= (weight car1) (weight car2))
                     (cons-stream car1
                                  (merge-weighted (stream-cdr s1) s2)))
                    (else
                      (cons-stream car2
                                   (merge-weighted s1
                                                   (stream-cdr s2)))))))))
  (cons-stream
    (cons (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (cons(stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight))))

;a:the stream of al pairs of positive intgers (i,j) with i<j ordered according
;to the sum i+j

(define (w a)
  (+ (car a)(cdr a)))
(define S-high (weighted-pairs integers integers w))


;b:the stream of all pairs of positive integers (i,j) with i<j where neither i
;nor j is divisible by 2,3,5 and the pairs are orderd according to the sum
;2i+3j+5ij.

(define (w2 a)
  (+ (* (car a) 2) (* (cdr a) 3) (* (car a) (cdr a) 5)))

(define Stream235 
  (stream-filter (lambda (x) (not (or (= (remainder 2 x) 0)
                                      (= (remainder 3 x) 0)
                                      (= (remainder 5 x) 0))))
                 integers))
(define s235 (weighted-pairs stream235 stream235 w2))

;Cy D Fect, a reformed C programmer, is worried that some side effect may never
;take place, because the lazy evaluator doesnt for the expressions in a
;sequence. since the value of an expression i a sequence other then the lsat on
;is not used. (the expressino is htere only for its effect, usc as asigning to a
;variable or printing, there can be no subsequent use of this value (e.g, as an
;argument to a primitive procedure that will cause it to be forced. cy thus
;thinks that when evaluating sequences, we must force all expressions in the
;sequence except the final one. he proposes to modify eval-sequence from section
;4.1.1 to use actual-value rather then eval

;(define (eval-sequence exps env)
;  (cond ((last-exp? exps) (eval (first-exp exps)env))
;        (else (actual-value (first-exp exps)env)
;              (eval-sequence (rest-exps exps)env))))


;ben thnks cy is wrong. he shows cy the for-each procedure described in 2.23.
;which gives an imporatant example of a sequence with sideeffects:

(define (for-each proc items)
  (if (null? items)
    'done
    (begin (proc (car items))
           (for-each proc (cdr items)))))

;he claims that the evaluator in the text (with the original eval-sequence)
;handles this correctly;

;;;input
;(for-each (lambda(x)(newline)(display x))
;          (list 57 321 88))
;57
;321
;88
;;;value
;done
;
;explain why ben is right about the behavior of for-each
;cause dats what begin does

;cy agrees that ben is right about the for-each example, but says that thats not
;the kind of programhe was thinking about when he proposed his change to
;eval-sequcne. he defines the following two procedures in the lazy evaluator

(define (p1 x)
  (set! x (cons x '(2)))
  x)
(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))

;what are the values of (p1 1) and (p2 1) with the oringial eval-sequence? what
;would the values be with cy's proposed change to eval-sequence?
;(1.2)
;1
;(1.2)
;(1.2)
;
;cy also points out that changing eval-sequence as he proposes does not affect
;the behavior of the example in part a, explain why.
;
;actual value will evaluate it all the same

;d;how do you think sequences ought to be treated in the lazy evaluator? do you
;like Cy's approach, the text, or some other approach.

;depends on whats important. so probably the changed one

;alyssa doesnt understand why analyze-sequence needs to be so complicated. all
;the other analysis procedures are straightforward transformations of the
;corresponding evaluation procedures. (or eval clauses) in 4.1.1. she expected
;analyze-sequence to look like 

'(define (analyze-sequence exps)
   (define (execute-sequence procs env)
     (cond ((null? (cdr procs)) ((car procs) env))
           (else ((car procs)env)
                 (execute-sequence (cdr procs)env))))
   (let ((procs (map analyze exps)))
    (if (null? procs)
      (error "Empty sequence -- ANALYZE"))
    (lambda (env) (execute-sequence procs env))))

;ava explains to alyssa that the version in the text does more of the work of
;evaluating a sequence at analysis time. alyssas sequence- execution procedure,
;rather than having the calls to the indiviual execution procedures built in,
;loops through the procedure in order to call them:in effect, although the
;individual expresisons in the sequence have been analyzed the sequence itself
;has not been.

;compare the two versions of analyze-sequence. for example, consider the common
;case where the equecen has just one expression. what work will the execution
;procedure produced by alyssas do? what bout the execution procedure produced by
;the program in the text above? how do the two versions compare for a sequence
;with two expressions?



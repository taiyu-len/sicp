;specify register machines that implement each of the following procedures. for
;each machine,write a controller instruction sequence and draw a diagram showing
;the data paths,,

;a; recursive exponentiation

'(define (expt b n)
  (if (= n 0)
    1
    (* b (expt b (- n 1)))))

(controller
 expt-start
  (assign continue (label expt-done))
 expt-loop
  (test (op =) (reg n) (const 0))
  (branch (label base-case))
  ;;setup recursion
  (save continue) ;push onto stakc
  (assign n (op -) (reg n) (const 1))  ;decrement n
  (assign continue (label expt-return));setup return address
  (goto (label expt-loop))
 expt-return
  (restore continue) ;pop stack
  (assign n (op *) (reg n) (reg b))
  (goto (reg continue))
 base-case
  (assign n (const 1))
  (goto (reg continue))
 expt-done)


;iterative;
'(define (expt b n)
  (define (expt-iter counter product)
    (if (= counter 0)
      product
      (expt-iter (- counter 1) (* b product))))
  (expt-iter n 1))

(controller
 expt-start
  (assign counter (reg n))
  (assign product (const 1))
 expt-loop
  (test (op =) (reg counter) (const 0))
  (branch (label expt-done))
  (assign counter (op -) (reg counter) (const 1))
  (assign product (op *) (reg product) (reg b))
  (goto (label expt-loop))
 expt-done)

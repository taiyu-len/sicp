;memoization is a technique that enables a procedure to record, in a local
;table, values that have previously been computed. this technique can make a
;vast difference in the performance of a program. a memoized procedure maintinas
;a table in which values of previous calls are stored using as keys the
;arguments that produced the values. ewhen the memoized procedure is asked to
;compute a value, it first checks the table to see if the value is already there
;and if so just returns that value, otherwie it ocmputed the new value in the
;ordinary way and stores this in the table. as an example of memoization, recall
;from section 1.2.2 the xponential process form computing fibonaacci numners


;where the momoizer is defined as 

(define (memoize f)
  (let ((table (make-table)))
   (lambda (x)
     (let ((previously-computed-result (lookup x table)))
      (or previously-computed-result
          (let ((result (f x)))
           (insert! x result table)
           result))))))



(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;the memoized version of the same procedure is 

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

;draw an enviroemnt diagram to analyze the computation of (memo-fib 3). explain
;why memo-fib computes the nth fibonacci number in a number of ssteps
;proportional to n. would the scheme still work if we had simply defined
;memo-fib to be (memoize fub)?

;it will create an enviroment for memoize. it will hold the table, and f which i
;sthe fib lambda . this procedure then takes 3.
;
;[E1]table,f,
;    procedure(x), 
;[E2]x=3
;[e3]  [e4]
;[5][6]
;1   1  2 3 5 7; funny 

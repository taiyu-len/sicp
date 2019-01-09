;implment a new construct called if-fail that permits the user to catch the
;failure of an expression. if-fail takes two expressions. it evaluates the first
;expression as usual and returns as usual if the evaluation succeeds. if the
;evaluation fails, however the value of the second expression is returned as in
;the following example.

;amb-eval input
;(if-fail(let((x(an-element-of '(1 3 5))))
;         (require(even? x))
;         x)
;  'all-odd)
;;starting a new
;; amv-eval value
;all-odd
;;starting a new
;(if-fail (let ((x (an-element-of '(1 3 5 8))))
;          (require (even? x))
;          x
;          'all-odd))
;;
;8

(define (if-fail? exp) (tagged-list? exp 'if-fail))
(define (if-fail-failed exp) (cadr exp))
(define (if-fail-success exp) (caddr exp))
(define (analyze-if-fail exp)
  (let ((first (analyze (cadr exp)))
        (second (analyze (caddr exp))))
    (lambda (env succeed fail)
      (first env
             (lambda (value fail2)
               (succeed value fail2))
             (lambda ()
               (second env succeed fail))))))

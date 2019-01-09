;implement a new  kind of assignment called permanent-set! that is not undone
;upon failure. for example, we can choose two distinct elements form a list and
;count the number of trial required to make a successful choice as follows

(define count 0)
(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
  (permanent-set! count (+ count 1))
  (require (not (eq? x y)))
  (list x y count))

;1 both times i think...

(define (permanent-set? exp) (tagged-list? exp 'permanent-set!))
(define (analyze-permanent-set exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (set-variable-value! var val env)
               (succeed 'ok fail2))
             fail))))



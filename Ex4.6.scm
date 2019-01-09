;let expessions are derived expessions, becuase

;(let ((<var1> <exp1>) ... (<varn <expn>))
;  <body>)

;is equivalent to

;((lambda (<var1> ... <varn>)
;  <body>)
;  <exp1> ... <expn>)

;implement a syntatic transformation let->combination that reduces evaluateing
;let expessions to evaluating combinations of type shown above, and add the
;appropriate clause to eval to handle let expessions

(define (let? exp) (tagged-list? exp 'let))
(define (let-vars exp) (map car  (cadr exp)))
(define (let-init exp) (map cadr (cadr exp)))
(define (let-body exp) (cddr exp))
(define (let->combination exp)
  (cons (make-lambda (let-vars exp) (let-body exp))
        (let-init exp)))

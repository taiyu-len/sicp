;"named let" is a variant of let that has the form 

;the <binding> and <body> are just as in ordinary let, except that <var> is
;bound within body to a procedure whose body is <body> and whose parameter are
;the variables i the <bindings>. thus one can repeatedly execute the <body> by
;invoking the procedure named <var>. for example, the iterative fibonacci
;procedure can be rewritten using named let as follows
;modify  let->combination of 4.6 to also support a named let

(define (named-let? exp) (and (let? exp) (symbol? (cadr exp))))
(define (named-let-name exp) (cadr exp))
(define (named-let-body exp) (cadddr exp))
(define (named-let-args exp) (map car (caddr exp)))
(define (named-let-init exp) (map cadr (caddr exp)))
(define (named-let->func exp)
  (list 'define
        (cons (named-let-name exp) (named-let-args exp))
        (named-let-body exp)))
(define (let->combination exp)
  (if (named-let? exp)
   (sequence->exp
      (list (named-let->func exp)
            (cons (named-let-name exp) (named-let-init exp))))
   (cons (make-lambda (let-vars exp)
                      (list (let-body exp)))
         (let-init exp))))

(define (eval-let exp env)
  (eval (let->combination exp) env))
(put 'eval 'let eval-let)

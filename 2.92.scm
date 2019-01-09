;copying an answer

(define (install-polynomial-package)
  ;;internal procedures
  ;;representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (polynomial? p)
    (eq? 'poly (car p)))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (variable? x)
    (symbol? x))
  (define (same-variable? x y)
    (and (variable? x) (variable? y) (eq? x y)))

  ;;representation of terms and term lists
  (define (add-poly p1 p2)
    ;(display "var p1 " p1)(newline)
    ;(display "var p2 " p2)(newline)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (let ((ordered-polys (order-polys p1 p2)))
       (let ((high-p (higher-order-poly ordered-polys))
             (low-p (lower-order-poly ordered-polys)))
         (let ((raised-p (changed-poly-var low-p)))
          (if (same-variable? (variable high-p)
                              (variable (cdr raised-p)))
            (add-poly high-p (cdr raised-p))
            (error "poly not in same variable, and cant change either --ADD-poly"
                   (list high-p (cdr raised-p)))))))))
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1)L2)
          ((empty-termlist? L2)L1)
          (else
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin-term
                       t1 (add-terms (rest-terms L1)L2)))
                    ((< (order t1) (order t2))
                     (adjoin-term
                       t2 (add-terms L1 (rest-terms L2))))
                    (else
                      (adjoin-term
                        (make-term (order t1)
                                   (add (coeff t1) (coeff t2)))
                        (add-terms (rest-terms L1)
                                   (rest-terms L2)))))))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (let ((ordered-polys (order-polys p1 p2)))
       (let ((high-p (higher-order-poly ordered-polys))
             (low-p  (lower-order-poly ordered-polys)))
         (let ((raised-p (change-poly-var low-p)))
          (if (same-variable? (variable high-p)
                              (variable (cdr raised-p)))
            (mul-poly high-p (cdr raised-p))
            (error "Poly Not In Same Variable And Cant be Raised -- MUL-POLY"
                   (list high-p (cdr raised-p)))))))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist L1)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
      (the-empty-termlist L)
      (let ((t2 (first-term L)))
       (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))
  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (let ((answer (div-terms (term-list p1)
                               (term-list p2))))
        (list (tag (make-poly (variable p1) (car answer)))
              (tag (make-poly (variable p1) (cadr answer)))))
      (let ((ordered-polys (order-polys p1 p2)))
       (let ((high-p (higher-order-poly ordered-polys))
             (low-p  (lower-order-poly ordered-polys)))
         (let ((raised-p (change-poly-var low-p)))
          (if (same-variable? (variable high-p)
                              (variable (cdr raised-p)))
            (div-poly high-p (cdr raised-p))
            (error "Poly not in same variable,and cant raise.--DIV-POLY"
                   (list high-p (cdr raised-p)))))))))
  (define (div-terms L1 L2)
    (define (div-help L1 L2 quotient)
      (if (empty-termlist? L1)
        (list (the-empty-termlist L1) (the-empty-termlist L1))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
            (list (cons (type-tag L1) quotient) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (div-help
                (add-terms L1
                           (mul-term-by-all-terms
                             (make-term 0 -1)
                             (mul-term-by-all-terms
                               (make-term new-o new-c)
                               L2)))
                L2
                (append quotient (list (list new-o new-c)))))))))
    (div-help L1 L2 '()))
  (define (zero-pad x type)
    (if (eq? type 'sparse)
      '()
      (cond ((= x 0)'())
            ((> x 0) (cons 0 (zero-pad (- x 1)type)))
            ((< x 0) (cons 0 (zero-pad (+ x 1)type))))))
  (define (adjoin-term term-list)
    (define (adjoin-help term acc term-list)
      (let ((preped-term ((get 'prep-term (type-tag term-list))term))
            (preped-first-term ((get 'prep-term (type-tag term-list))
                                (first-term term-list)))
            (empty-termlst (the-empty-termlist term-list)))
        (cond ((=zero? (coeff term))term-list)
              ((empty-termlist? term-list)
               (append empty-termlst
                       acc
                       (zero-pad (order-term)
                                 (type-tag term-list))))
              ((> (order term) (order (first-term term-list)))
               (append (list (car term-list))
                       acc
                       preped-term
                       (zero-pad (- (- (order term)
                                       (order (first-term term-list)))
                                    1)
                                 (type-tag term-list))
                       (cdr term-list)))
              ((= (order term) (order (first-term term-list)))
               (append (list (car term-list))
                       acc
                       preped-term
                       (zero-pad (- (- (order term)
                                       (order (first-term term-list)))
                                    1)
                                 (type-tag term-list))
                       (cddr term-list)))
              (else
                (adjoin-help term
                             (append acc preped-first-term)
                             (rest-terms term-list))))))
    (adjoin-help-term '() term-list))
  (define (negate p)
    (let ((neg-p ((get 'make-polynomial (type-tag (term-list p)))
                  (variable p) (list (make-term 0 -1)))))
      (mul-poly (cdr neg-p)p)))
  (define (zero-poly? p)
    (define (all-zero? term-list)
      (cond ((empty-termlist? term-list)#t)
            (else
              (and (= zero? (coeff (first-term term-list)))
                   (all-zero? (rest-terms term-list))))))
    (all-zero? (term-list p)))
  (define (equal-poly? p1 p2)
    (and (same-variable? (variable p1) (variable p2))
         (equal? (term-list p1) (term-list p2))))
  (define (the-empty-termlist term-list)
    (let ((proc (get 'the-empty-termlist (type-tag term-list))))
     (if proc
       (proc)
       (error "No Procedure found for THE-EMPTY-TERMLIST" term-list))))
  (define (rest-terms term-list)
    (let ((proc (get 'rest0terms (type-tag term-list))))
     (if proc
       (proc term-list)
       (eror "No Proecedure found for REST-TERMS" term-list))))
  (define (empty-termlist? term-list)
    (let ((proc (get 'empty-termlist? (type-tag term-list))))
     (if proc
       (proc term-list)
       (error "NO PROCEDURE FOR EMPTY-TERMLIST?"))))
  (define (make-term order coeff) (list order coeff))
  (define (order term)
    (if (pair? term)
      (car term)
      (error "Term Not Pair -- ORDER" term)))
  (define (coeff term)
    (if (pair? term)
      (cadr term)
      (error "Term not pair -- COEFF" term)))
  (define (mixed-add x p)
    (define (zero-order L)
      (let ((t1 (first-term L)))
       (cond ((empty-termlist? L)#f)
             ((= 0 (order t1))t1)
             (else
               (zero-order (rest-terms L))))))
    (let ((tlst (term-list p)))
     (let ((last-term (zero-order tlst)))
      (if last-term
        (make-poly (variable p) (adjoin-term
                                  (make-term 0
                                             (add x (coeff last-term)))
                                  tlst))
        (make-poly (variable p) (adjoin-term (make-term 0 x) tlst))))))
  (define (mixed-mul x p)
    (make-pol (variable p)
              (mul-term-by-all-terms (make-term 0 x)
                                     (term-list p))))
  (define (mixed-div p x)
    (define (div-term-by-all-terms t1 L)
      (if (empty-termlist? L)
        (the-empty-termlist L)
        (let ((t2 (first-term L)))
         (adjoin-term
           (make-term (- (order t1) (order t2))
                      (div (coeff t1) (coeff t2)))
           (div-term-by-all-terms t1 (rest-terms L))))))
    (make-poly (variable p)
               (div-term-by-all-terms (make-term 0 x)
                                      (term-list p))))
  ;;transformers
  (define (variable-order v)
    (if (eq? v 'x)1 0))
  (define (order-polys p1 p2)
    (let ((v1 (variable-order (variable p1)))
          (v2 (variable-order (variable p2))))
      (if (> v1 v2) (cons p1 p2) (cons p2 p1))))
  (define (higher-order-poly ordered-polys)
    (if (pair? ordered-polys) (car ordered-polys)
      (error "ordered-polys not pair -- HIGHER-ORDER-POLY" ordered-polys)))
  (define (lower-order-poly ordered-polys)
    (if (pair? ordered-polys) (cdr ordered-polys)
      (error "ordered-polys not pair -- LOWER-ORDER-POLY" ordered-polys)))
  (define (change-poly-var p)
    (define (helper-change TL)
      (cond ((empty-termlist? TL) '())
            (else
              (cond (change-term-var (variable p)
                                     (type-tag TL)
                                     (first-term TL))
                    (helper-change (rist-terms TL))))))
    (define (add-poly-list acc poly-list)
      (if (null? poly-list)
        acc
        (add-poly-list (add acc (car poly-list))
                       (cdr poly-list))))
    (add-poly-list 0 (helper-change (TL p))))
  (define (change-term-var original-var original-type term)
    (make-polynomial original-type (variable (cdr (coeff term)))
                     (map (lambda (x)
                            (list (order x)
                                  (make-polynomial
                                    original-type
                                    original-var
                                    (list
                                      (list (order term)
                                            (coeff x))))))
                          (cdr (term-list (cdr (coeff term)))))))
  ;;interface
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'negate '(polynomial)
       (lambda (p) (tag (negate p))))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (tag (div-poly p1 p2))))
  (put 'zero-poly? '(polynomial)
       (lambda (p) (tag (zero-poly? p))))
  (put 'equal-poly? '(polynomial polynomial)
       (lambda (p1 p2) (tag (equal-poly?-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  ;;interface for mixed
  (put 'add '(scheme-number polynomial)
       (lambda (x p) (tag (mixed-add x p))))
  (put 'add '(rational polynomial)
       (lambda (x p) (tag (mixed-add (cons 'rational x)p))))
  (put 'add '(real polynomial)
       (lambda (x p) (tag (mixed-add x p))))
  (put 'add '(complex polynomial) 
       (lambda (x p) (tag (mixed-add (cons 'complex x) p)))) 
;; Subtraction 
  (put 'sub '(scheme-number polynomial) 
       (lambda (x p) (tag (mixed-add x (negate p))))) 
  (put 'sub '(polynomial scheme-number) 
       (lambda (p x) (tag (mixed-add (mul -1 x) p)))) 
  (put 'sub '(rational polynomial) 
       (lambda (x p) (tag (mixed-add (cons 'rational x) (negate p))))) 
  (put 'sub '(polynomial rational) 
       (lambda (p x) (tag (mixed-add (mul -1 (cons 'rational x)) p)))) 
  (put 'sub '(real polynomial) 
       (lambda (x p) (tag (mixed-add x (negate p))))) 
  (put 'sub '(polynomial real) 
       (lambda (p x) (tag (mixed-add (mul -1 x) p)))) 
  (put 'sub '(complex polynomial) 
       (lambda (x p) (tag (mixed-add (cons 'complex x) (negate p))))) 
  (put 'sub '(polynomial complex) 
       (lambda (p x) (tag (mixed-add (mul -1 (cons 'complex x)) p)))) 
;; Multiplication 
  (put 'mul '(scheme-number polynomial) 
       (lambda (x p) (tag (mixed-mul x p)))) 
  (put 'mul '(rational polynomial) 
       (lambda (x p) (tag (mixed-mul (cons 'rational x) p)))) 
  (put 'mul '(real polynomial) 
       (lambda (x p) (tag (mixed-mul x p)))) 
  (put 'mul '(complex polynomial) 
       (lambda (x p) (tag (mixed-mul (cons 'complex x) p)))) 
  ;; Division 
  ;; Using a polynomial as a
  ;; divisor will leave me wiht
  ;; negative orders. Which I
  ;; donno how to 
  ;; handle yet. 
  (put 'div '(polynomial scheme-number) 
       (lambda (p x) (tag (mixed-mul (/ 1 x) p)))) 
  (put 'div '(scheme-number polynomial) 
       (lambda (x p) (tag (mixed-div p x)))) 
  (put 'div '(polynomial rational)      ;multiply by the denom, and divide by the numer. 
       (lambda (p x) (tag (mixed-mul (make-rational (cdr x) (car x)) p)))) 
  (put 'div '(rational polynomial) 
       (lambda (x p) (tag (mixed-div p (cons 'rational x))))) 
  (put 'div '(polynomial real)
       (lambda (p x) (tag (mixed-mul (/ 1.0 x) p)))) 
  (put 'div '(real polynomial) 
       (lambda (x p) (tag (mixed-div p x)))) 
  (put 'div '(polynomial complex) 
       (lambda (p x) (tag (mixed-mul (div 1 (cons 'complex x)) p)))) 
  (put 'div '(complex polynomial) 
       (lambda (x p) (tag (mixed-div p (cons 'complex x)))))
  'done) ; this fucking parentheses. its paird with the one 336 lines above

  
 (install-polynomial-package) 
  
 ; this takes an extra argument type to specify if it is dense or sparse. 
 (define (make-polynomial type var terms) 
   (let ((proc (get 'make-polynomial type))) 
     (if proc 
         (proc var terms) 
         (error "Can't make poly of this type -- MAKE-POLYNOMIAL" 
                (list type var terms))))) 
  
 ; the generic negate procedure needed for subtractions.  
  
 (define (negate p) 
   (apply-generic 'negate  p)) 
  
 ; And the generic first-term procedure with it's package to work with dense and 
 ; sparse polynomials. 
  
 (define (first-term term-list) 
   (let ((proc (get 'first-term (type-tag term-list)))) 
     (if proc 
         (proc term-list) 
         (error "No first-term for this list -- FIRST-TERM" term-list)))) 
  
 (define (install-polynomial-term-package) 
   (define (first-term-dense term-list) 
     (if (empty-termlist? term-list) 
         '() 
         (list 
          (- (length (cdr term-list)) 1) 
          (car (cdr term-list)))))   
   (define (first-term-sparse term-list) 
     (if (empty-termlist? term-list) 
         '() 
         (cadr term-list))) 
   (define (prep-term-dense term) 
     (if (null? term) 
         '() 
         (cdr term)))                            ;-> only the coeff for a dense term-list 
   (define (prep-term-sparse term) 
     (if (null? term) 
         '() 
         (list term)))         ;-> (order coeff) for a sparse term-list 
   (define (the-empty-termlist-dense) '(dense)) 
   (define (the-empty-termlist-sparse) '(sparse)) 
   (define (rest-terms term-list) (cons (type-tag term-list) (cddr term-list))) 
   (define (empty-termlist? term-list)  
     (if (pair? term-list)  
         (>= 1 (length term-list)) 
         (error "Term-list not pair -- EMPTY-TERMLIST?" term-list))) 
   (define (make-polynomial-dense var terms) 
     (append (list 'polynomial var 'dense) (map cadr terms))) 
   (define (make-polynomial-sparse var terms) 
     (append (list 'polynomial var 'sparse) terms)) 
   (put 'first-term 'sparse  
        (lambda (term-list) (first-term-sparse term-list))) 
   (put 'first-term 'dense 
        (lambda (term-list) (first-term-dense term-list))) 
   (put 'prep-term 'dense 
        (lambda (term) (prep-term-dense term))) 
   (put 'prep-term 'sparse 
        (lambda (term) (prep-term-sparse term))) 
   (put 'rest-terms 'dense 
        (lambda (term-list) (rest-terms term-list))) 
   (put 'rest-terms 'sparse 
        (lambda (term-list) (rest-terms term-list))) 
   (put 'empty-termlist? 'dense 
        (lambda (term-list) (empty-termlist? term-list))) 
   (put 'empty-termlist? 'sparse 
        (lambda (term-list) (empty-termlist? term-list))) 
   (put 'the-empty-termlist 'dense 
        (lambda () (the-empty-termlist-dense))) 
   (put 'the-empty-termlist 'sparse 
        (lambda () (the-empty-termlist-sparse))) 
   (put 'make-polynomial 'sparse 
        (lambda (var terms) (make-polynomial-sparse var terms))) 
   (put 'make-polynomial 'dense 
        (lambda (var terms) (make-polynomial-dense var terms))) 
   'done)
 (install-polynomial-term-package)


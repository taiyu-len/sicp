;2.1 Data Abstraction
;shitty intro
(define <++> (display "<++>"))
;2.1.1 
;methods to act on rational numbers
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (denom y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

; representation of rational numbers
(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
; displaying rational number
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
;fix rational number representation
(define (make-rat n d)
  (let ((g (gcd n d)))
   (cons (/ n g) (/ d g))))

;Exersize 2.1
;define a better version of make-rat that handles both positive and negative
;arguments. make-rat should normalize the sign so that if the rational number is
;positive, both num&den are positive, and if negative only numerator
(define (make-rat n d)
  (let ((g (gcd n d )))
   (cons
     (if (> (* n d)0)
       (/ (abs n)g)
       (- (/ (abs n)g)))
     (/ (abs d)g))))

;2.1.2 abstraction barriers

;alternate version of rationals
(define (make-rat n d)
  (cons n d))
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
   (/ (car x)g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
   (/ (cdr x)g)))

;exersize 2.2
;consider the problem of representing line segments in a plane. each segment is
;represented as a pair of points: a starting point nad an edning point. define a
;constructor make-segment and selectors start-segment and end-segment that
;define the representation of segments in terms of points. furthermore, a point
;can be represneted as a pair of numbers: the x coordinate and the y coordinate.
;accordingly, specify a constructor make-point and slecectors x-point and
;y-point gthat define the represtentation. finally using your selectors and
;constructors, define a procedure midpoint-segment that takes a line segment as
;arugment and returns its midpoint.\\
(define (print-point p)
  (newline)
  (display "(")(display (x-point p))(display (","))
  (display (y-point p)) (display ")"))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)
(define make-point cons)
(define x-point car)
(define y-point car)
(define (midpoint-segment segment)
  (print-point
    (make-point
      (/ (+ (x-point (start-segment segment))
            (x-point (end-segment segment)))
         2)
      (/ (+ (y-point (start-segment segment))
            (y-point (end-segment segment)))
         2))))

;exersize 2.3
;implement a representation for rectangles in a plane. in terms of your
;constructors and selectors, reate procedures that compute the perimiter and
;area of a given rectangle. now implement a different representaiton. can you
;design you system with suitable abstration barriers so that the same perimiter
;and area procedures will work uing either representation.

;2 methods we can use. 3points, 2 vecotrs + 1point 
(define (make-rect a b c)
  (cons a (cons b c)))
(define (segment-length a)
  (let ((x (- (x-point (end-segment a))
              (x-point (start-segment a))))
        (y (- (y-point (end-segment a))
              (y-point (start-segment a)))))
    (sqrt (+ (* x x) (* y y)))))
(define (perimeter x)
  (* (+ (segment-length (make-point (car x) (cdar x)))
        (segment-length (make-point (car x) (cddr x))))
     2))
(define (area x)
  (* (segment-length (make-point (car x) (cdar x)))
     (segment-length (make-point (car x) (cddr x)))))
;and now for vector
;same make-rect as before
(define make-vector cons)
(define (vector-length x)
  (sqrt (+ (* (car x) (car x))
           (* (cdr x) (cdr x)))))
(define (perimeter x)
  (* (+ (vector-length (cadr x))
        (vector-length (cddr x)))
     2))
(define (area x)
  (- (* (caadr x) (cdddr x))
     (* (cdadr x) (caddr x))))

;2.1.3 data

;2.4
;ya it works pretty neato.
;(define (cdr z)
;  (z (lambda (p q) q)))
; is the answer

;exersize 2.5
;show that we can represent pairs of nonnegative integers using only numbers and
;aritmetic operations if we represent the pair a and b as the intger that is th
;product 2^a3^b. give the corresponding definitions of the procedure
;cons,car,cdr


;(define (cons x y) (* (expt 2 x) (expt 3 y)))
;
;(define (car x)
;  (if (= (remainder x 2) 0)
;    (+ 1 (car (/ x 2)))
;    0))
;(define (cdr x)
;  (if (= (remainder x 3)0)
;    (+ 1 (car (/ x 3)))
;    0))

;exersize 2.6. in case representing pairs as procedures wasnt mind-boggling
;enough. consider that, in a language that can manipulate procedures. we can get
;by without numbers by implementing 0 and the operation of adding 1 as
(define zero (lambda (f) (lambda (x)x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f)x)))))
;this representation is known as church numeals, after invetor alonzo churhc
;define one and two directly. give proecdure +
(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f)x))))
(lambda (f) (lambda (x) (f (( (lambda (f) (lambda (x)x)) f)x))))
(lambda (f) (lambda (x) (f x)))
(define one (lambda (f) (lambda (x) (f x))))
(add-1 one)
(lambda (f) (lambda (x) (f ((one f)x))))
(lambda (f) (lambda (x) (f ((  (lambda (f) (lambda (x) (f x)))   f)x))))
(lambda (f) (lambda (x) (f ( (lambda (x) (f x))  x))))
(lambda (f) (lambda (x) (f (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))
(define (lambda-sum a b)
  (lambda (f) (lambda (x)
                ((a f) ((b f)x)))))

;2.1.4 extended exersize. interval arithmetic

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;exersize 2.7 
;alyssas proram is incomplete because she has not specified the implemenation of
;the interval abstraction. here is a definition of the tinterval constructor

(define make-interval cons)
;define selectors upper-bound and lower-boudn
(define upper-bound car)
(define lower-bound cdr)

;exersize 2.8 
;using reasoning analogous to alyssa describe how the difference of two
;intervals may be computed. define a corresponding subtraction procedure,
;called sub-interval

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))


;exersize 2.9
;the width of an interval is half of the difference between its upper and lower
;bounds. the width is a measure of uncertainty of the number specified by the
;interval. for some arithmetic operations the width of the result of combining
;two intervals is a function only of the widths of the argument intervals,
;whereas for others the width of the sum of two interval is a fucnction only of
;widths of intervals being added orsubstracted. give examples to show this is
;not true for * or /

;already did this else where. too lazy to do it again

;exersize 2.10
;ben bitdidle an expert systems programmer, looks over alyssa shoulder and
;commments that it is not clear what it means to divide by an interval that
;spans zero. modify to check for this condition.

(define (div-interval x y)
  (if (= 0 (* (upper-bound y) (lower-bound y)))
    ((display "Error"))
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))


;exersize 2.11, in passing ben also crypticall coments, by testing the signs of
;the endpoints of hte interval, it is possible to break mul-interval into nine
;cases. only one of which requires more then two multiplications.

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (if(< (lower-bound x) 0);-A
      (if (< (upper-bound y)0);-ACD
        (make-interval (if (> (upper-bound x)0)
                         p3 ;-acd+b  1
                         p4);-abcd   2
                       p1)
        (make-interval (min p2 p3);-a +d 3
                       (max p1 p4))) 
      (if (< (lower-bound y)0);+ab-c 4
        (make-interval p3
                       (if (< (upper-bound y)0)
                         p2 ;+ab-cd 5
                         p4)) ;+abd-c 6
        (make-interval p1;+ab+cd 7
                       p4)))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i))2))
(define (width i)
  (/ (- (lower-bound i) (upper-bound i))2))

;define a construtor make-center-percent that takes a center and a percentage
;tolerance and produces the desired interval. you must also define a selector
;percent that produces the percentage tolerance for a given interval. the center
;selector is the same as the one whoen above
(define (make-center-percent c p)
  (make-interval (- c (* c p)) (+ c (* c p))))
(define (percent i)
  (/ (- (upper-bound i) (lower-bound i))
     (+ (upper-bound i) (lower-bound i))))

;2.13 show that under the assumption of small percentage tolderances there is a
;simple formul for approximating percentage tolerance of the product of two
;intervals in terms of otlerances of the fac

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
   (div-interval one
                 (add-interval (div-interval one r1)
                               (div-interval one r2)))))

;exersize 2.14 demonstrat that laem is right. investigate the behavior of the
;system on a variety of arithmetic expressions. make some intervals A and B and
;use them in computing the epxressions A/A and A/B. you will get the most
;insight by using intervals whose idth is a small pecentage of the center value.
;examine the result of the computation in center-percent form

;multiplying fucks up the widths


;exersize 2.15
;eva lu lator, another user, has also noticed the different intervals compted by
;different but algegraically equivalent expressions. she says that a formula to
;compt with intervals using alyssa system will produce tighter error bounds if
;it can be written in suc a form that no varibale that represent an uncertain
;number is repeated. htus she says par2 is a betterprogram. why is she right.

;as R_x is a pair of numbers the results are quite different for multiples and
;division then with single numbers. so less numbers in it will cause less
;errors

;exersize 2.16 explain in general why equivalent algebraic ....
;look above

;2.2 hierachical data and the closure property
;
(define (list-ref items n)
  (if (= n 0)
    (car items) 
    (list-ref (cdr items) (- n 1))))
(define  square (list 1 4 9 16 25))
(list-ref square 3)


(define (length i)
  (if (null? i)
    0
    (+ 1 (length (cdr i)))))
(define (length i)
  (define (length-iter a c)
    (if (null? a)
      c
      (length-iter (cdr a) (+ 1 c))))
  (length-iter i 0))

;define a procedure last-pair tat returns the list that cointains only the last
;element of a given nonempty list:

(define (last-pair x)
  (if (null? (cdr x))
    (car x)
    (last-pair (cdr x))))
;2.18 define a procedure reverse that takes a list as argument and returns a
;list of the same elements in reverse ordero
(define (reverse x)
    (define (iter a l)
        (if (null? l)
            a
            (iter (cons (car l) a) (cdr l))))
    (iter () x))
;2.19 consider the change-counting program of section 1.2.2. it would be nice to
;be able to easily change the currency used by the program so that we ould
;compute tht enumber of ways to change british pounds for example. as the
;program is written the knowledge of the currenc y is distribbuted partly into
;the procedure first-denomination and partly into the procedure cound-change.
; it would be nicer to be able to supply a list of coins to be used for making
; change.
;we want to rewrite the procedure cc so that its second argument is a list of
;the valules of the coins to use rather then an integer specifiyng which coins
;to use. we could then have lists that defined each kind of currency.
;to do this we will require changing the program cc somewhat. it will still have
;the same form. but it will access its second argument differently as follows

(define (cc amt cv)
  (cond (( amt 0)1)
        ((or (< amt 0) (no-more? cv))0)
        (else
          (+ (cc amt
                 (except-first-denomination cv))
             (cc (- amt
                    (first-denomination  cv))
                 cv)))))
;define theprocedure first-denomination, except-first-denomination, and no-more?
;in terms of primitive operations on list structure. does the order of the list
;cv affet the answer produced by cc? why or whynot.


(define except-first-denomination cdr)
(define first-denomination car)
(define no-more? null?)
;order of coins dont matter much other then the time to do it

;2.20 the procedures +,*, and list take aribtrary numbers of arguments., one way
;to define suhc procedures is to use define with dotted-tail notation. in a
;procedure defininition. a parameter list that has a dot before the last
;parameter name indicates that, when the procedure is called the initial
;parameter will have as values the initial arguments, as usual, but the final
;parameters value will be a list of any remiaining arguments.
;blabla dot lists

;use this notation to write a procedure same-parity that takes one or more
;integers and returns a lits of all the arguments that have the same parity of
;the first argument.

(define (same-parity a . l)
  (define (spi b)
    (if (null? b)
      ()
      (if (even? (+ a (car b)))
        (cons (car b) (spi (cdr b)))
        (spi (cdr b)))))
  (spi l))



(define (scale-list item factor)
  (if (null? item)
    ()
    (cons (* (car items)factor)
          (scale-list (cdr item)factor))))

;(define (map proc items)
;  (if (null? items)
;    ()
;    (cons (proc (car items))
;          (map proc (cdr items)))))

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))


;2.21 the procedure square-list takes a list of number as arguments and returns
;a list of the squares of those numbers
;here are two different definitions. complete the both of them

(define (square-list items)
  (if (null? items)
    ()
    (cons (* (car items) (car items)) (square-list (cdr items)))))
(define (square-list items)
  (map (lambda (x) (* x x)) items ))

;exersize 2.22 lous reasoner tries to rewrite te first square-list so that it
;evolves an iterative process:
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items ()))
;unfortunatly defineiny it this way produces it in reverse. why
;first iteration puts first elemnt A into answer  (A) = (cons A ())
;then  it puts the second B  (B A) = (cons B (cons A ())
; and so on until its reversed
;
;she then tries to fix it b doing this
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things)))))))
;first  (cons () A) = (().A)
;second (cons (().A) B) = ((().A).B) and so on

;2.23 the procedure for-each is similar to map. it takes as arguments a
;procedure and a list of elements. however rather then forming a list of the
;results, for-each just applies the proedure to each of the elemtns in turn,
;from left tor ight. the values returned by aplying the procedure to the elemnts
;ar enot used at all -- for-each is used with procedures that perform and
;action, such as printing. 

(define (for-each func item)
  (if  (pair? item)
    (begin
      (func (car item))
      (for-each func (cdr item)))))

;2.2.2
(define (count-leaves x)
  (cond ((null? x)0)
        ((not (pair? x))1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;exersize 2.24;; suppose we evaluate the expressions (list 1(list 2(list 3 4)))
;give the result printed by the interpreter. the corresponding boxpointer and
;interpretation as a tree

;(1 (2 (3 4)))
;[]-[]-[]-4 
;1  2  3
; ^
;1 ^
; 2 ^
;  3 4

;2.25. give a combination of cars and cdrs that will pick 7  from each of the
;following

(car (cdaddr (list 1 3 (list 5 7) 9)))
(caar (list (list 7)))
(cadadr (cadadr (cadadr (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))))

;2.26 suppose we define x and y to be two lists
(define x (list 1 2 3))
(define y (list 4 5 6))
;what result is printed by the terpreer in response to evaluating the following
(append x y);(1 2 3 4 5 6)
(cons x y)  ;((1 2 3)4 5 6)
(list x y)  ;((1 2 3)(4 5 6))

;2.27 modify your reverse procedure to produce deep-reverse procedure that
;reverses al sublists


(define (reverse x)
    (define (iter a l)
        (if (null? l)
            a
            (iter (cons (car l) a) (cdr l))))
    (iter () x))

(define (deep-reverse x)
    (define (iter a l)
        (if  (null? l)
          a
          (iter
            (cons 
              (if (pair? (car l))
                (iter () (car l))
                (car l)) 
              a)
            (cdr l))))
    (iter () x))

;2.28; write a procedure fringe that takes as argument a tree and returns a list
;whose elements are all the leaves of the tre aranged in left-to-right order.
;for example.
;
(define (fringe x)
  (cond ((null? x) ())
        ((pair? x)
         (append (fringe (car x)) (fringe (cdr x))))
        (else (list x))))

;2.29a binary mobile consists of two brances, a left and a right. each branch is
;a rod of a cetrain length, from which hangs a weight or another binary mobile.
(define make-mobile cons)
(define make-branch cons)
;a write the corresponding selectors left-branch and right-branch.
;branch-length and branch-structure
(define mobile? pair?)
(define left-branch car)
(define right-branch cdr)
(define branch-length car)
(define branch-structure cdr)
;using selectors defie procedure total weight.
(define (total-weight x);takes in a mobiel
  (+ (if (mobile? (branch-structure (left-branch x)))
       (total-weight (branch-structure (left-branch x)))
       (branch-structure (left-branch x)))
     (if (mobile? (branch-structure (right-branch x)))
       (total-weight (branch-structure (right-branch x)))
       (branch-structure (right-branch x)))))
;a mobile is said to be balaced if the torque applied to all branches are equal.
(define (balanced? x)
  (if (mobile? x)
    (and (balanced? (branch-structure (left-branch x)))
         (balanced? (branch-structure (right-branch x)))
         (= (* (branch-length (left-branch x))
               (if (mobile? (branch-structure (left-branch x)))
                 (total-weight (branch-structure (left-branch x)))
                 (branch-structure (left-branch x))))
            (* (branch-length (right-branch x))
               (if (mobile? (branch-structure (right-branch x)))
                 (total-weight (branch-structure (right-branch x)))
                 (branch-structure (right-branch x))))))
    #t))

;suppose we change the representation of mobiles so that the constructors are 
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
;well i did this first cause using lists for pairs is stupid

(define (scale-tree tree factor)
  (cond ((null? tree) ())
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
            (scale-tree sub-tree factor)
            (* sub-tree factor)))
       tree))

;2.30 define a procedure square-tree analogous to the square list procedure of
;2.21, 

(define (square-tree tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree tree)
  (map (lambda (sub)
         (if (pair? sub)
           (square-tree sub)
           (* sub sub)))
       tree))
;2.31 abstract your answer to exercize 2.30 to [produce a procedure tree-map
;with the property that square-tree could be deffined as 
(define (square-tree tree) (tree-map square tree))
(define square (lambda (x) (* x x)))
(define (tree-map func tree)
  (cond ((null? tree) ())
        ((pair? tree)
         (cons (tree-map func (car tree))
               (tree-map func (cdr tree))))
        (else
         (func tree))))

; we can represent a set as alist of distinct elelments. and we can represent
; the set of all subsets of the set as a list of lists. forexample. if the set
; is (1 2 3). then the rest is (OMITTED). complete the following definitation of
; a procedure that generates the set of subsets of a set and give a clear
; explination of why it works

(define (subsets s)
  (if (null? s) 
    (list ())
    (let ((rest (subsets (cdr s))))
     (append rest (map 
                    (lambda (x)
                      (append (list (car s))x ))
                    rest)))))


;2.2.3 sequences as conventional interfaces
(define (sum-odd-squares tree)
  (cond ((null? tree)0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
      ()
      (let ((f (fib k)))
       (cons f (next (+ k 1)))
       (next (+ k 1)))))
  (next 0))

(define (filter predicate sequence)
    (cond ((null? sequence) ())
          ((predicate (car sequence))
           (cons (car sequence)
                 (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

(define (accumulate op ini seq)
  (if (null? seq)
    ini
    (op (car seq)
        (accumulate op ini (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
    ()
    (cons low (enumerate-interval (+ low 1)high))))
(define (enumerate-tree tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))

(define (even-fibs n)
  (accumulate cons
              ()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(define (list-fib-squares n)
  (accumulate cons
              ()
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))

(define (product-of-squares-of-odd-elements seq)
  (accumulate *
              1
              (map square
                   (filter odd? seq))))

(define (salary-of-highest-paid-programmer records)
  (accumulate max
              0
              (map salary
                   (filter programmer? records))))

;2.33; fill in the missing exprssions to complete the following definition of
;some basic list manipulation operations as acuumulations:

;(define (map p sequence)
; (accumulate (lambda (x y) (cons (p x) y)) () sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;2.34; evaluting a poly nomial in x at a given value of x can be forumlated as
;an accumulation. we evaluate the polynomial
;a_nx^n+a_{n-1}x^{n-1}+...+a_1x+a_0
;using a well known algorithm called horners rule which structures it as this
;(...(a_nx+a_{n-1})x+...+a_1)x+a_0
;in other words we start with a_n, multiply by x, add a_{n-1}, multiply by x and
;so on. until we reach a_0. fill in the following template to produce a
;procedure that evaluates a polynomial using horers rule. assume that the
;coefficients of the polynomial are arranged in a sequence. form a_0 through a_n

(define (horne-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) 
                (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))

;2.35; redefine count-leaves from 2.2.2 as an accumulation:

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x)1)
                   (enumerate-tree t))))

;2.36; the procedure accumulate-n is similar to accumulate except that it takes
;as its third argument a sequence of sequences, which are all assumed to have
;the same number of elements. it applies the designated accumulation procedure
;to combine all the first elements of the sequence. all the second elements of
;the sequence and so on. and returns a sequence of the results. for instance if
;s is a sequence contining 4 sequecnces. ((1 2 3)(4 5 6)(7 8 9)(10 11 12)), then
;the value of (accumulate + 0 s) should be the sequence (22 26 30). fill in the
;smissing exprssions in the following definition of accumulate-n

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    ()
    (cons (accumulate op init (map (lambda (x) (car x))seqs))
          (accumulate-n op init (map (lambda (x) (cdr x))seqs)))))

;2.37; suppose we represent vectors v=(v_i) as sequence of numbers. and matrices
;m=(m_ij) as sequence of vectors. with this representation.blabla matrixes
;(dot-product v w)
;(matrix-*-vector m v)
;(matrix-*-matrix m n)
;(transpose m)


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))
(define (transpose mat)
  (accumulate-n cons () mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
   (map (lambda (x) (matrix-*-vector cols x)) m)))

;2.38 the accumulate procedure is also known as fold-right. becaseu oit combines
;the first element of the sequence with the reslt of comboning all the elemnts
;to the right. there is also a fold-left. which is similar to fold-right except
;that it combines elements working in the opposite direction

(define (fold-left op ini seq)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter ini seq))

;what are the values of 
(fold-right / 1 (list 1 2 3))     ; 3/2
(fold-left / 1 (list 1 2 3))      ; 1/6
(fold-right list () (list 1 2 3)) ; (1 (2 (3 ())))
(fold-left list () (list 1 2 3))  ; (((() 1) 2) 3)

;2.39; complete the following definition of reverse in terms of fold-right and
;fold-left from 2.38;

(define (reverse seq)
  (fold-right (lambda (x y) (append y (list x))) () seq))
(define (reverse seq)
  (fold-left (lambda (x y) (cons y x)) () seq))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                 (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n)))))

(define (permutations s)
  (if (null? s)
    (list ())
    (flatmap (lambda (x)
               (map (lambda (p) (cons x p))
                    (permuatations (remove x s))))
             s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

;2.40; define a procedure unique-pairs that, given an integer n, generates the
;sequence of pairs (i,j) with 1<=j<i<=n. use unique-pairs to simplify the
;definition of prime-sum-pairs given above\\
(define (unique-pairs n)
  (flatmap (lambda (i)
         (map (lambda (j) (list i j))
              (enumerate-interval 1 (- i 1))))
       (enumerate-interval 2 n)))


;2.41 write a procedure to find all ordered triples of distnct i,j,k less then
;or equal to given integer n that sum to a given integer s

(define (ordered-triples n s)
  (filter (lambda (x) (= (accumulate + 0 x) s))
    (flatmap (lambda (i)
             (flatmap (lambda (j)
                    (map (lambda (k) (list i j k))
                         (enumerate-interval 1 (- j 1))))
                  (enumerate-interval 2 (- i 1))))
           (enumerate-interval 3 n))))


;(3,4,...,i) -> (((3,2)),((4,2),(4,3))....((i,2),(i,3)...(i,i-1))
;over an interval from (3->i) whe

;2.42; eight queens puzzle

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position col row current)
  (cons col current))

(define empty-board ())
(define (safe? row board)
  (define (safe?iter check current)
    (if (null? current)
      #t
      (cond ((= (car current) (car board))#f)
            ((= (car current) (+ (car board)check))#f)
            ((= (car current) (- (car board)check))#f)
            (else (safe?iter (+ check 1) (cdr current))))))
  (safe?iter 1 (cdr board)))



;2.2.4
;(define wave2 (beside wave (flip-vert wave)))
;
;(define wave4 (below wave2 wave2))
;
;(define (flipped-pairs painter)
;  (let ((painter2 (beside painter (flip-vert painter))))
;   (below painter2 painter2)))
;(define wave4 (flipped-pairs wave))
;
;(define (right-split painter n)
;  (if (= n 0)
;      painter
;      (let ((smaller (right-split painter (- n 1))))
;       (beside painter (below smaller smaller)))))
;
;(define (corner-split painter n)
;  (if (= n )
;    painter
;    (let ((up (up-split painter (- n 1)))
;          (right (right-split painter (- n 1))))
;      (let ((top-left (beside up up))
;            (bottom-right (below right right))
;            (corner (corner-split painter (- n 1))))
;        (beside (below painter top-left)
;                (below bottom-right corner))))))
;
;(define (square-limit painter n )
;  (let ((quater (corner-split painter n)))
;   (let ((half (beside (flip-horiz quater)quater)))
;    (below (flip-vert half)))))

;2.44; deifne the procedure up-plit used by corner-split. it is similar to
;right-split,
;(define (up-split painter n)
;  (if (= n 0)
;    painter
;    (let ((smaller (up-split painter (- n 1))))
;     (below (beside smaller smaller)painter))))

;(define (square-of-four tl tr bl br)
;  (lambda (painter)
;    (let ((top (beside (tl painter) (tr painter)))
;          (below (beside (bl painter) (br painter))))
;      (below bottom top))))

;(define (flipped-pairs painter)
;  (let ((combine4 (square-of-four identity flip-vert
;                                  identity flip-vert)))
;    (combine4 painter)))

;(define (square-limit painter n)
;  (let ((combine4 (square-of-four flip-horiz identity
;                                  rotate180 flip-vert)))
;    (combine4 (corner-split painter n))))

;2.45; right-split and up-split can be expressed as instances of a genreal
;spliting operation. define a procedure split with the property evaluating
;(define right-split (split beside below))
;(define up-split (split below beside))

;(define (split half quarter)
;  (lambda (painter n)
;;    (if (= n 0)
;      painter
;      (let ((smaller ((split half quarter) painter (- n 1))))
;       (half (quarter smaller smaller) painter)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;(define (frame-coord-map frame)
;  (lambda (v)
;    (add-vect
;      (origin-frame frame)
;      (add-vect (scale-vect (xcor-vect v)
;                            (edge1-frame frame))
;                (scale-vect (ycor-vect v)
;                            (edge2-frame frame))))))
;
;2.46; a two-dimensional vector v rnning from the origin to a pint can be
;represented as a pair consiting of an x-coordinate and a y-corrdinate.
;implement a data abstraction for vectors by giving a constructor make-vect and
;corresponding selectors xcor-vect and ycor-vect. in terms of your selctors and
;constructors implement add-vect, sub-vect and scale-vect that perform these
;operations;
;
;(define make-vect cons)
;(define xcor-vect car)
;(define ycor-vect cdr)
;(define (add-vect v1 v2)
;  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
;             (+ (ycor-vect v1) (ycor-vect v2))))
;(define (sub-vect v1 v2)
;  (make-vect (- (xcor-vect v1) (xcor-vect v2))
;             (- (ycor-vect v1) (ycor-vect v2))))
;(define (scale-vect v1 s)
;  (make-vect (* (xcor-vect v1) s)
;             (* (ycor-vect v2) s)))

;2.47; here are two possible constructors for frames
;(define (make-frame origin edge1 edge2)
;  (list origin edge1 edge2))
;(define origin car)
;(define edge1 cadr)
;(define edge2 caddr)
;
;(define (make-frame origin edge1 edge2)
;  (cons origin (cons edge1 edge2)))
;(define origin car)
;(define edge1 cadr)
;(define edge2 cddr)
;;2.47
;
;(define (segments->painter segment-list)
;  (lambda (frame)
;    (for-each
;      (lambda (segment)
;        (draw-line
;          ((frame-coord-map frame) (start-segment segment))
;          ((frame-coord-map frame) (end-segment segment))))
;      segment-list)))
;
;
;
;exersize 2.48 a directed line segment in the plane can be represented as a pair
;of vectors -- the vector running from the origin to the start-point of the
;segment, and a vector running from origin to the end-point of the segment. use
;your vector representation from 2.46 to define a representation for segments
;with a constructor make-segment and selectors start-segment and end-segment
;(define make-segment cons)
;(define start-segment car)
;(define end-segment cdr)
;
;exersize 2.49 use segments-painter to define the following primitive painters
;a. a painter that draws the outline of the frame

;
;(define DrawFrame (list (make-segment (make-vector 0 0)
;                                      (make-vector 0 1))
;                        (make-segment (make-vector 0 1)
;                                      (make-vector 1 1))
;                        (make-segment (make-vector 1 1)
;                                      (make-vector 1 0))
;                        (make-segment (make-vector 1 0)
;                                      (make-vector 0 0))))
;
;(define DrawX (list (make-segment (make-vector 0 0)
;                                  (make-vector 1 1))
;                    (make-segment (make-vector 0 1)
;                                  (make-vector 1 0))))
;
;(define DrawDiamond (list (make-segment (make-vector 0 0.5)
;                                        (make-vector 0.5 0))
;                          (make-segment (make-vector 0.5 0)
;                                        (make-vector 1 0.5))
;                          (make-segment (make-vector 1 0.5)
;                                        (make-vector 0.5 1))
;                          (make-segment (make-vector 0.5 1)
;                                        (make-vector 0 0.5))))
;
;;to lazy to do wave drawing
;
;
;(define (transform-painter painter origin corner1 corner2)
;  (lambda (frame)
;    (let ((m (frame-coord-map frame)))
;     (let ((new-origin (m origin)))
;      (painter
;        (make-frame new-origin
;                    (sub-vect (m corner1) new-origin)
;                    (sub-vect (m corner2) new-origin)))))))
;
;(define (flip-vert painter)
;  (transform-painter painter
;                     (make-vect 0.0 1.0)
;                     (make-vect 1.0 1.0)
;                     (make-vect 0.0 0.0)))
;
;(define (shrink-to-upper-right painter)
;  (transform-painter painter
;                     (make-vect 0.5 0.5)
;                     (make-vect 1.0 0.5)
;                     (make-vect 0.5 1.0)))
;
;(define (rotate90 painter)
;  (transform-painter painter
;                     (make-vect 1.0 0.0)
;                     (make-vect 1.0 1.0)
;                     (make-vect 0.0 0.0)))
;
;(define (squash-inwards painter)
;  (transform-painter painter
;                     (make-vect 0.0 0.0)
;                     (make-vect 0.65 0.35)
;                     (make-vect 0.35 0.65)))
;
;(define (beside painter1 painter2)
;  (let ((split-point (make-vect 0.5 0.0)))
;   (let ((paint-left
;           (transform-painter painter1
;                              (make-vect 0.0 0.0)
;                              split-point
;                              (make-vect 0.0 1.0)))
;         (paint-right
;           (transform-painter painter2
;                              split-point
;                              (make-vect 1.0 0.0)
;                              (make-vect 0.5 1.0))))
;     (lambda (frame)
;       (paint-left frame)
;       (paint-right frame)))))
;
;
;;2.50 define the transformation flip-horiz, which flips painters horizontally,
;;and tranformations that rotate painters CCW by 180 and 270
;
;(define (flip-horiz painter)
;  (transform-painter painter
;                     (make-vect 1.0 0.0)
;                     (make-vect 0.0 0.0)
;                     (make-vect 1.0 1.0)))
;(define (rotate180 painter)
;  (transform-painter painter
;                     (make-vect 1.0 1.0)
;                     (make-vect 0.0 1.0)
;                     (make-vect 1.0 0.0)))
;(define (rotate270 painter)
;  (transform-painter painter
;                     (make-vect 0.0 1.0)
;                     (make-vect 0.0 0.0)
;                     (make-vect 1.0 1.0)))
;
;;2.51 define the below operation for painters. below takes two painters as
;;arugmens. the resulting painter, given a frame draws with the first painter in
;;hte bottom of the frame and with the second painter in the top. define below in
;;two different ways -- first by writing a procedure that is analogous to the
;;beside procedure given above, and again in terms of beside and a suitable
;;roatioin operation
;(define (below painter1 painter2)
;  (let ((split-point (make-vect 0.0 0.5)))
;   (let ((paint-below
;           (transform-painter painter1
;                              (make-vect 0.0 0.0)
;                              (make-vect 1.0 0.0)
;                              split-point))
;         (paint-above
;           (transform-painter painter2
;                              split-point
;                              (make-vect 1.0 0.0)
;                              (make-vect 1.0 0.5))))
;     (lambda (frame)
;       (paint-below frame)
;       (paint-above frame)))))
;(define (below painter1 painter2)
;  (rotate270 
;    (beside (rotate90 painter1) (rotate90 painter2))))
;;2.52 make changes to the square limit of wave shown in figure 2.9 by working at
;;eahc levels described above. inparticual:
;;a. add some segments to the primitive wave painter of exercise
;;b. change the pattern constructed by corner-split 
;;c. modify the version of square-limit that uses square-of-four so as to
;;assemble the corners in a different pattern. 
;
;;lol too lazy to modify segments
;
;(define (corner-split painter n)
;  (if (= n )
;    painter
;    (let ((up (up-split painter (- n 1)))
;          (right (right-split painter (- n 1))))
;      (let ((corner (corner-split painter (- n 1))))
;        (beside (below painter up)
;                (below right corner))))))
;
;;fuck this shit
;
;; 2.3 symbolic data
;; 2.3.1 quotation
;
(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))


;2.53 what would the interperet in response to the following
(list 'a 'b 'c)
;(a b c)
(list (list 'george))
;((george))
(cdr '((x1 x2) (y1 y2)))
;((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;(x2)
(pair? (car '(a short list)))
;#f
(memq 'red '((red shoes) (blue socks)))
;#f
(memq 'red '(red shoes blue socks))
;#t

(load "/home/project/scheme/2.54.scm")

;2.55 evaluator types into hter interpreter and gets
(car ''abracadabra)
;quote;

;why.
;cause it creates a list (' abracadabra) and as car gets the first element...

;2.3.2 example: symbolic differentation

(define (deriv exp var)
  (cond ((number? exp)0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (mulitplier exp) var)
                         (multiplicand exp))))
        (else
          (error "unknown expression type -- DERIV" exp))))

(define variable? symbol?)
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define addend cadr)
(define augend caddr)
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define multiplier cadr)
(define multiplicand caddr)

(define (make-sum a1 a2)
  (cond ((=number? a1 0)a2)
        ((=number? a2 0)a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list '+ a1 a2))))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
 (cond ((or (=number? m1 0) (=number? m2 0))0)
       ((=number? m1 1)m2)
       ((=number? m2 1)m1)
       ((and (number? m1) (number? m2)) (* m1 m2))
       (else (list '* m1 m2))))

(load "/home/project/scheme/2.3.3.scm")
(load "/home/project/scheme/2.56.scm")
(load "/home/project/scheme/2.57.scm")
(load "/home/project/scheme/2.58.scm")

(load "/home/project/scheme/2.3.4.scm")
(load "/home/project/scheme/2.4s.scm")
(load "/home/project/scheme/2.5s.scm")

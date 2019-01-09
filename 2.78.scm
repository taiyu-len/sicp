;the internal procedures in the scheme-number package are essentially nothing
;more then calls to the primitive +,0, etc. it was not possible to use the
;primitives of the language directly because our type-tag system reuqires that
;each data object have a type attached to it. infact, however all lisp
;implementations do have a type system, which they use internally. primitive
;predicates such as symbol? number?dertmine whether data objetes have particular
;types. modify the definitions of type-tag,content, and attach-tag from section
;2.4.2 so that our generic system takes advantage of scheme's internal type
;system. that is to say the sytem should work as before except that ordinary
;numbers should be represented simly as scheme numbers rather then a pair whose
;car is the symbol scheme-number

(define (attach-tag type contents)
  (if (eq? type 'scheme-number)
    contents
    (cons type-tag contents)))
(define (type-tag datum)
  (if (number? datum)
    datum
    (if (pair? datum)
      (car datum)
      (error "Bad tagged datum --TYPE-TAG" datum ))))
(define (contents datum)
  (if (number? datum)
    datum
    (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum))))



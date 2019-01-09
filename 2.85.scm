;thissection mentiond a method for simplifying a data object by lowering it in
;the tower of types as far as possible. designa procedure drop that complishes
;this for the tower described in 2.83. the key is to decide, in some general
;way, whther an object can be lowered. for example, the complex number 1.5+0i
;can be lowered as far as a real, the complex number 1+0i can be loewred as far
;as integer, and complex 2+3i cannot be lowered at all.
;here is a plan for determining whether an obejct can be lowered: begin by
;defining a generic operation project that pushes an object down in the tower.
;for example, projecting a complex number would involve throwing away the
;imaginary part. then a number can be dropped if, when we  project it and raise
;the reul is back to the type we started with, wee end up with something equal
;to what we started with. show how to implement this idea in detail, by writing
;a drop procedure that drops an objcet as far as possible. you wil need tod
;design the various projections operations and install project as a
;genericopereration in te system you will also need to make use of a generic
;equality predicate such as described in 2.79. finally use drop to rewrite
;apply-generic from exersize 2.84 so that it simplifies its answers.

(define (drop a)
  (define (lower n)
    (apply-generic 'lower n))
  (if (equ? (raise (lower a))a)
    (drop (lower a))
    a))

;(put 'lower 'integer (lambda (x) x))
;(put 'lower 'real (lambda (x)(floor x)))
;(put 'lower 'complex (lambda(x)(real-part x)))



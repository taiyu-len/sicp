;;;Load tables
(load "/home/project/scheme/table.scm")
(define (query-table (make-table)))
(define get (query-table 'lookup-proc))
(define put (query-table 'insert-proc!))
;;;Load Streams
(load "/home/project/scheme/stream.scm")
;;;DriverLoop and isntantiation

(define input-prompt  ";;; Query Input:")
(define output-prompt ";;; Query Results:")
(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
   (cond ((assertion-to-be-added? q)
          (add-rule-or-assertion! (add-assertion-body q))
          (newline)
          (display "Assertion added to database.")
          (query-driver-loop))
         (else
           (newline)
           (display output-prompt)
           (display-stream
             (stream-map
               (lambda (frame)
                 (instantiate q
                              frame
                              (lambda (v f)
                                (contract-question-mark v))))
               (qeval q (singleton-stream '()))))
           (query-driver-loop)))))

(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
            (if binding
              (copy (binding-value binding))
              (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

;;; Evaluator
(define (qeval query frame-stream)
  (let ((qproc (get (type query) 'qeval)))
   (if qproc
     (qproc (contents query)frame-stream)
     (simple-query query frame-stream))))

;;; Simple Queries

(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (stream-append-delayed
        (find-assertions query-pattern frame)
        (delay (apply-rules query-pattern frame))))
    frame-stream))

;;compound queries
(define (conjoin conjuncts frame-stream)
  (if (empty-conjuction? conjuncts)
    frame-stream
    (conjoin (rest-conjuncts conjuncts)
             (qeval (first-conjunct conjuncts)
                    frame-stream))))
(put 'and 'qeval conjoin)
(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
    the-empty-stream
    (interleave-delayed
      (qeval (first-disjunct disjuncts) frame-stream)
      (delay (disjoin (rest-disjuncts disjuncts)
                      frame-stream)))))
(put 'or 'qeval disjoin)

;;;;Filters

(define (negate operands frame-stream)
  (stream-flatmap
    (lambda (frame)
      (if (stream-null? (qeval (negated-query operands)
                               (singleton-stream frame)))
        (singleton-stream frame)
        the-empty-stream))
    frame-stream))
(put 'not 'qeval negate)

(define (lisp-value call frame-stream)
  (stream-flatmap
    (lambda (frame)
      (if (execute
            (instantiate
              call
              frame
              (lambda (v f)
                (error "Unknown pat var -- LISP-VALUE" v))))
        (singleton-stream frame)
        the-empty-stream))
    frame-stream))
(put 'lisp-value 'qeval list-value)

(define (uniquely-asserted pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((stream (qeval (negated-query pattern)
                           (singleton-stream frame))))
        (if (singleton-stream? stream)
          stream
          the-empty-stream)))
    frame-stream))
(define (singleton-stream? s)
  (and (not (stream-null? s))
       (stream-null? (stream-cdr s))))


(put 'unique 'qeval uniquely-asserted)

(define (execute exp)
  (apply (eval (predicate exp) user-initial-environment)
         (args exp)))

(define (always-true ignore frame-stream)frame-stream)
(put 'always-true 'qeval always-true)

;;;Finding asssertions and pattern matching.

(define (find-assertions pattern frame)
  (stream-flatmap (lambda (datum)
                    (check-an-assertion datum pattern frame))
                  (fetch-assertions pattern frame)))

(define (check-an-assertion assertion query-pat query-frame)
  (let ((match-result
          (pattern-match query-pat assertion query-frame)))
    (if (eq? match-result 'failed)
      the-empty-stream
      (singleton-stream match-result))))

(define (pattern-match pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match (cdr pat)
                        (cdr dat)
                        (pattern-match (car pat)
                                       (car dat)
                                       frame)))
        (else 'failed)))

(define (extend-if-consistent var dat frame)
  (let ((binding (binding-in-frame var frame)))
   (if binding
     (pattern-match (binding-value binding) dat frame)
     (extend var dat frame))))

;;;rules and unification
(define (apply-rules pattern frame)
  (stream-flatmap (lambda (rule)
                    (apply-a-rule rule pattern frame))
                  (fetch-rules pattern frame)))

(define (apply-a-rule rule query-pattern query-frame)
  (let ((clean-rule (rename-variables-in rule)))
   (let ((unify-result (unify-match query-pattern
                                    (conclusion clean-rule)
                                    query-frame)))
     (if (eq? unify-result 'failed)
       the-empty-stream
       (qeval (rule-body clean-rule)
              (singleton-stream unify-result))))))

(define (rename-variables-in rule)
  (let ((rule-application-id (new-rule-application-id)))
   (define (tree-walk exp)
     (cond ((var? exp)
            (make-new-variable exp rule-application-id))
           ((pair? exp)
            (cons (tree-walk (car exp))
                  (tree-walk (cdr exp))))
           (else exp)))
   (tree-walk rule)))

(define (unify-match p1 p2 frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? p1 p2) frame)
        ((var? p1) (extend-if-possible p1 p2 frame))
        ((var? p2) (extend-if-possible p2 p1 frame))
        ((and (pair? p1) (pair? p2))
         (unify-match (cdr p1)
                      (cdr p2)
                      (unify-match (car p1)
                                   (car p2)
                                   frame)))
        (else 'failed)))

(define (extend-if-possible var val frame)
  (let ((binding (binding-in-frame var frame)))
   (cond (binding
           (unify-match
             (binding-value binding)val frame))
         ((var? val)
          (let ((binding (binding-in-frame val frame)))
           (if binding
             (unify-match
               var (binding-value binding) frame)
             (extend var val frame))))
         ((depends-on? val var frame) 'failed)
         (else (extend var val frame)))))

(define (depends-on? exp var frame)
  (define (tree-walk e)
    (cond ((var? e)
           (if (equal? var e)
             #t
             (let ((b (binding-in-frame e frame)))
              (if b
                (tree-walk (binding-value b))
                #f))))
          ((pair? e)
           (or (tree-walk (car e))
               (tree-walk (cdr e))))
          (else #f)))
  (tree-walk exp))

;;;;ASSERTIONS

(define THE-ASSERTIONS the-empty-stream)
(define (fetch-assertions pattern frame)
  (if (use-index? pattern)
    (get-indexed-assertions pattern)
    (get-all-assertions pattern)))
(define (get-all-assertions)THE-ASSERTIONS)
(define (get-indexed-assertions pattern)
  (get-stream (index-key-of pattern) 'assertion-stream))

(define (get-stream key1 key2)
  (let ((s (get key1 key2)))
   (if s s the-empty-stream)))

;;;;RULES
(define THE-RULES the-empty-stream)
(define (fetch-rules pattern frame)
  (if (use-index? pattern)
    (get-indexed-rules pattern)
    (get-all-rules)))
(define (get-all-rules) THE-RULES)
(define (get-indexed-rules pattern)
  (stream-append
    (get-stream (index-key-of pattern) 'rule-stream)
    (get-stream '? 'rule-stream)))

(define (add-rule-or-assertion! assertion)
  (if (rule? assertion)
    (add-rule! assertion)
    (add-assertion! assertions)))

(define (add-assertion-in-index assertion)
  (store-assertion-in-index assertion)
  (let ((old-assertions THE-ASSERTIONS))
   (set! THE-ASSERTIONS
      (cons-stream assertion old-assertions))
   'ok))
(define (add-rule! rule)
  (store-rule-in-index rule)
  (let ((old-rules THE-RULES))
   (set! THE-RULES (cons-stream rule old-rules))
   'ok))

(define (store-assertion-in-index assertion)
  (if (indexable? assertion)
    (let* ((key (index-key-of assertion))
           (current-assertion-stream
             (get-stream-key 'assertion-stream)))
      (put key
           'assertion-stream
           (cons-stream assertion
                        current-assertion-stream)))))

(define (store-rule-in-index rule)
  (let ((pattern (conclusion rule)))
   (if (indexable? pattern)
     (let* ((key (index-key-of pattern))
            (current-rule-stream (get-stream key 'rule-stream)))
       (put key
            'rule-stream
            (cons-stream rule
                         current-rule stream))))))

(define (indexable? pat)
  (or (constant-symbol? (car pat))
      (var? (car pat))))
(define (index-key-of pat)
  (let ((key (car pat)))
   (if (var? key) '? key)))

(define (use-index? pat)
  (constant-symbol? (car pat)))

(define (type exp)
  (if (pair? exp)
    (car exp)
    (error "Unkown expression TYPE" exp)))

(define (contents exp)
  (if (pair? exp)
    (cdr exp)
    (error "Unknown expression CONTENTS" exp)))

(define (assertion-to-be-added? exp)
  (eq? (type exp) 'assert!))
(define (add-assertion-body exp)
  (car (contents exp)))

(define (empty-conjunction? exps) (null? exps))
(define (first-conjunct exps) (car exps))
(define (rest-conjuncts exps) (cdr exps))
(define (empty-disjunction? exps) (null? exps))
(define (first-disjunct exps) (car exps))
(define (rest-disjuncts exps) (cdr exps))
(define (negated-query exps) (car exps))
(define (predicate exps) (car exps))
(define (args exps) (cdr exps))

(define (rule? statement)
  (tagged-list? statement 'rule))
(define (conclusion rule) (cadr rule))
(define (rule-body rule)
  (if (null? (cddr rule))
    '(always-true)
    (caddr rule)))

(define (query-syntax-process exp)
  (map-over-symbols expand-question-mark exp))

(define (map-over-symbols proc exp)
  (cond ((pair? exp)
         (cons (map-over-symbols proc (car exp))
               (map-over-symbols proc (cdr exp))))
        ((symbol? exp)
         (proc exp))
        (else exp)))

(define (expand-question-mark symbol)
  (let ((chars (symbol->string symbol)))
   (if (string=? (substring chars 0 1) "?")
     (list '?
           (string->symbol
             (substring chars 1 (string-length chars))))
     symbol)))
(define (var? exp)
  (tagged-list? exp '?))
(define (constant-symbol? exp) (symbol? exp))
(define rule-counter 0)
(define (new-rule-application-id)
  (set! rule-counter (+ 1 rule-counter))
  rule-counter)
(define (make-new-variable var rule-application-id)
  (cons '? (cons rule-application-id (cdr var))))
(define (contract-question-mark variable)
  (string->symbol
    (string-append "?"
                   (if (number? (cadr variable))
                     (string-append (symbol->string (caddr variable))
                                    "-"
                                    (number->string (cadr variable)))
                     (symbol->string (cadr variable))))))

(define (make-binding variable value)
  (cons variable value))
(define (binding-variable binding)
  (car binding))
(define (binding-value binding)
  (cdr binding))
(define (binding-in-frame variable frame)
  (assoc variable frame))
(define (extend variable value frame)
  (cons (make-binding variable value) frame))



;;;Sample Data Base

;;;;Begin Data Base Entry
(assert! (address (Bitdiddle Ben) (Slumerville (Ridge Road) 10)))
(assert! (job (Bitdiddle Ben) (computer wizard)))
(assert! (salary (bitdiddle Ben) 60000))
(assert! (supervisor (Bitdiddle Ben) (Warbucks Oliver)))

(assert! (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78)))
(assert! (job (Hacker Alyssa P) (computer programmer)))
(assert! (salary (Hacker Alyssa P) 40000))
(assert! (supervisor (Hacker Alyssa P) (Bitdiddle Ben)))

(assert! (address (Fect Cy D) (Cambridge (Ames Street) 3)))
(assert! (job (Fect Cy D) (computer programmer)))
(assert! (salary (Fect Cy D) 35000))
(assert! (supervisor (Fect Cy D) (Bitdiddle Ben)))

(assert! (address (Tweakit Lem E) (Boston (Bay State Road) 22)))
(assert! (job (Tweakit Lem E) (computer technician)))
(assert! (salary (Tweakit Lem E) 25000))
(assert! (supervisor (Tweakit Lem E) (Bitdiddle Ben)))

(assert! (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80)))
(assert! (job (Reasoner Louis) (computer programmer trainee)))
(assert! (salary (Reasoner Louis) 30000))
(assert! (supervisor (Reasoner Louis) (Hacker Alyssa P)))

(assert! (address (Warbucks Oliver) (Swellesley (Top Heap Road))))
(assert! (job (Warbucks Oliver) (administration big wheel)))
(assert! (salary (Warbucks Oliver)150000))

(assert! (address (Scrooge Eben) (Weston (Shady Lane) 10)))
(assert! (job (Scrooge Eben) (accounting chief accountant)))
(assert! (salary (Scrooge Eben) 75000))
(assert! (supervisor (Scrooge Eben) (Warbucks Oliver)))

(assert! (address (Cratchet Robert) (Allston (N Harvard Street) 16)))
(assert! (job (Cratchet Robert) (accounting scrivener)))
(assert! (salary (Cratchet Robert) 18000))
(assert! (supervisor (Cratchet Robert) (Scrooge Eben)))

(assert! (address (Aull DeWitt) (Slumerville (Onion Square) 5)))
(assert! (job (Aull DeWitt) (administration secretary)))
(assert! (salary (Aull DeWitt) 25000))
(assert! (supervisor (Aull DeWitt) (Warbucks Oliver)))

(assert! (meeting accounting (Monday 9am)))
(assert! (meeting administration (Monday 10am)))
(assert! (meeting computer (Wednesday 3pm)))
(assert! (meeting administration (Friday 1pm)))
(assert! (meeting whole-company (wednesday 4pm)))
;;;;End DataBase Entries
;;;;Start Assertions
(assert! (can-do-job (computer wizard) (computer programmer)))
(assert! (can-do-job (computer wizard) (computer technician)))
(assert! (can-do-job (computer programmer) (computer programmer trainee)))
(assert! (can-do-job (administration secretary) (administration big wheel)))
;;;;End Assertions
;;;;Rules
(assert! (rule (same ?x ?x)))
(assert! (rule (lives-near ?person1 ?person2)
               (and (address ?person1 (?town . ?rest1))
                    (address ?person2 (?town . ?rest2))
                    (not (same ?person1 ?person2)))))
(assert! (rule (outranked-by ?staff ?boss)
               (or (supervisor ?staff ?boss)
                   (and (supervisor ?staff ?middle)
                        (outranked-by ?middle ?boss)))))
(assert! (rule (can-replace ?person1 ?person2)
               (and (not (same ?person1 ?person2))
                    (job ?person1 ?job1)
                    (job ?person2 ?job2)
                    (can-do-job ?job1 ?job2))))
(assert! (rule (big-shot ?person)
               (and (supervisor ?person ?visor)
                    (job ?person (?job . ?rest))
                    (not (job ?visor (?job . ?other))))))
(assert! (rule (wheel ?person)
               (and (supervisor ?middle ?person)
                    (supervisor ?x ?middle))))

;;;;List RULES

(assert! (rule (append-to-form '() ?y ?y)))
(assert! (rule (append-to-form (?u . ?v) ?y (?u . ?z))
               (append-to-form ?v ?y ?z)))
(assert! (rule (?x next-to ?y in (?x ?y . ?u))))
(assert! (rule (?x next-to ?y in (?v . ?z))
               (?x next-to ?y in ?z)))
(assert! (rule (last-pair (?x) (?x))))
(assert! (rule (last-pair (?u . ?v) (?x))
               (last-pair ?v (?x))))
(assert! (rule (reverse () ())))
(assert! (rule (reverse ?x ?y)
               (and (append-to-form (?first) ?rest ?x)
                    (append-to-form ?rev-rest (?first) ?y)
                    (reverse ?rest ?rev-rest))))




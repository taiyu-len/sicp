;use the amb evaluator to solve the following puzzle

;mary ann moore's  father has a yacht and so has each of his 4 friends. 
;Colenel downing,  Mr Hall,  Sir Barnacle Hood,  Dr Parker. each of the 5 also
;has one daughter. and each has named his yacht after a daughter of one of the
;others.
;Sir Barnacle's yacht is gabrielle
;mr moore owns the lorna
;mr hall the rosalind
;colonel owns the melissa. named after sir barnacles daughter.
;gabrielles father owns the yacht named after dr Parkers daughter. who is lornas
;father
;

(define (father-daughter)
  (let ((Moore 'Mary)
        (Barnicle 'Melissa)
        (Hall (amb 'Gabrielle 'Lorna))
        (Downing (amb 'Gabrielle 'Lorna 'Rosalind))
        (Parker (amb 'Lorna 'Rosalind)))
    (require (cond ((eq? Hall 'Gabrielle) (eq? 'Rosalind Parker))
                   ((eq? Downing 'Gabrielle) (eq? 'Lorna Parker))
                   (else #f)))
    (require (distinct? (list Barnacle Moore Hall Downing Parker)))
    (list (list 'Barnacle Barnacle)
          (list 'Moore Moore)
          (list 'Hall Hall)
          (list 'Downing Downing)
          (list 'Parker Parker))))

;alyssa is more interested in generating interesting senentences than in parsing
;them. she reasons that by simply changing the procedure parse-word so that it
;ignores the input sentence and instead always succeeds and genereates an
;appropriate word we can use the program we had built for parsing to do
;generation insteda. implement alyssas idea and show the first half-dozen or so
;sentences.

(define (list-amb li)
  (if (null? li)
    (amb)
    (amb (car li) (list-amb (cdr li)))))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
   (set! *unparsed* (cdr *unparsed*))
   (list-amb (cdr word-list))))



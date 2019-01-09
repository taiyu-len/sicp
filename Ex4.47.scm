;louis reasoner suggests that, since a verb phrase is either a verb or a verb
;phrase followe by a preopositional phrase, it would be much more
;straightforward to define the procedure parse-verb-phrase as follows

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))

;does this work? does the programs behavior change if we interchange the order
;of expressions in the amb?

;i see an infinite loop

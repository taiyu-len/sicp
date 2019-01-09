;extend the grammer given above to handle more complex sentances. for example
;you could extend noun phrases and verb phrases to include adjectives and
;adverbs, or you could handle compound sentences.

(define adjectives '(adjective ugly stupid lazy cute pretty))
(define (parse-simple-noun-phrase)
  (amb (list 'simple-noun-phrase
             (parse-word articles)
             (parse-word nouns))
       (list 'simple-noun-phrase
             (parse-word articles)
             (parse-word adjectives)
             (parse-word nouns))))


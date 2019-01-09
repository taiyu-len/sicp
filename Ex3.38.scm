;suppose that peter, paul and mary share a join bank account that initially
;contains $100. concurently ,peter deposits $10, paul withdraws $20, and mary
;withdraws half the money in the account by executing the following commands

;(set! balance (+ balance 10))
;(set! balance (- balance 20))
;(set! balance (- balance (/ balance 2)))

;list all the different possible values for balance after these three
;transactions have been completed assuming that the banking system forces the
;three processes to run sequentially in some order
;4 outcomes
;-50,+10,-20 = 40
;+10,-55,-20 = 35
;+10,-20,-45 = 45
;-20,-40,+10 = 50

;what are some other values that could be produced if the system allows hte
;processes to be interleaved? draw atiming diagrams like the on in figure 3.29
;to explain how these values can occur
;
;ahaha fuck this, way to many of themC

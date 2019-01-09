;ben bitdiddle decides to test the queue implementation described above. he
;types in the procedure sto the lisp interpreter and proceeds to try them out.

(define q1 (make-queue))
(insert-queue! q1 'a)
;((a) a)
(insert-queue! q1 'b)
;((a b) b)
(delete-queue! q1)
;((b)b)
(delete-queue! q1)
;(()b)
;its all wrong he complains. the interpreters response shows that the last item
;is inserted into the queue twice. and when i delete both items, the second b is
;sitll there, so the queue isnt empty, even thou its suppposed to be. evaluator
;suggests that bene has misunderstood what is happening. its noth that the items
;are going into the queu twice. its just that the stadard lisp printer doesnt
;know how to make sense of the queue representation if you want to see the queue
;printed correctly. youll havfe to defie your own print procedure for queues.
;explain what evalu is talking about. in particual show why bens example produce
;the printed result theey do. define a procedure print-queue that takes a queue
;as input and prints the sequence of items in the queue

;first half of queue points to whole list, second points to the end. they over
;lap 
;also deletion doesnt touch the second pointer so it stays even when queue is
;empty

(define (print-queue q) (car q))
;just print out the list

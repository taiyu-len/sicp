;implement for the query language a new special form called unique. unique
;should succeed if there is precisely one itme in the database satisfying a
;specified query. for example.

(unique (job ?x (computer wizard)))

;should print the one-item stream

(unique (job (Bitdiddle Ben) (computer wizard)))

;since ben is th eonly computer wizard and

(unique (job ?x (computer programmer)))

;should print an empty stream

(and (job ?x ?j) (unique (job ?anyone ?j)))
;prints all the jobs with only one person working.

;there are two parts to implementing unique. the first is to write a procedure
;that handles this special form, and the second is to make qeval dispatch to
;that procedure. the second part is trivial, since qeval does its dispatching in
;a data-directed way. if your procedure is called uniquely-asserted, all you
;need to do is

;and qeva will dispatch to this procedure for every query whose type(car) is the
;symbol unique.
;the real problem is to write the procedure uniquely asserted. this should take
;as input the contents (cdr) of the unique query, together with a stream of
;frames. for each frame in the stream, it should use qeval to find the stream of
;all extensions to the frame that satisfy the given query. any stream that does
;no have exactly one item in it should be eliminatied. the remaining streams
;should be passed back to be accumulated into one big stream that is the result
;of the unique query. this is similar to the implementation of the not special
;form.

;test your implementation by forming a query that lists all people who supervise
;precisely one personc






;our implementaiton of and as a series combination of queries is elegant, but
;inefficient because in processing the second query of the and we must scan the
;database for each frame produced by the first query. if the data base has N
;elements, and a typical query produces a number of output frames proportional
;to N (say N/k), then scanning the database for each frame produced by the first
;query will require N^2/k calls to the pattern matcher. another approach would
;be to proess the two clauses of the and serperately, then look for all pairs o
;foutut frames that are compatible. if ecah query produces N/k output frames,
;that this means that we must perform N^2/k^2 compatability checks --a factor of
;k fewer than the number of matches requires in out current method

;devise an implementation of and that uses this strategy. you must implement a
;procedure that tkaes two frames as inputs, checks whether the binding in the
;frames are compatable, and if so, produces a frame that merges the two sets of
;bindings. this operation is similar to unification.

;lel no

;in section 4.4.3 we saw that not an lisp-value can cause the query language to
;give the "wrong" answers if these filtering operation are applied to frames in
;which variables are unbound. derivese a way to fix this shortcomming. one idea
;is to perform the filtering in a "delayed" manner by appending to the frame a
;"promise" to filter that is fulfilled only when enough variables ave been bound
;to make the operation possible. we could wiat to perform filtering until all
;other operations have been performed. however, for efficiencys sake. we would
;like to perform filtering as soon as possible so as to cut down on the number
;of intermediate frames generated.


;fuck this

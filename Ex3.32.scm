;the procedures to be run during each time segment of the agenda are kept in a
;queue. thus the procedure for each segment are called in the order in which
;they were added to the agenda (FIFO). explain why this order must be used. in
;particular trace the behavior of an and-gate whose inputs change from 0,1 to
;1,0 in the same segment and say how the behvaior would fifere if we stored a
;segments procedure sin an orderinary list adding and removing procedures only
;at eh front (LIFO).

;0,1 -> 1,1 -> 1,0 ; FIFO
;0,1 -> 0,0 -> 1,0 ; LIFO
;or vice versa.

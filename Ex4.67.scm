;devise a way to install a loop detector in the query system so as to avoid the
;kinds of simple loops illustrated in the text and in exercise 4.64. the general
;idea is that the system should maintain some sort of history of its current
;chain and deduction and should not begin processing a query that it is already
;working on. describe what kind of inormation (pattern and frames) is included
;in this history and how the check should be made.
;(after you study the details of the qurery-system implementation in section
;4.4.4 you may want to modify the system to include the loop detector.


;each query creates a frame, this should hold the calling query information and
;variables, and whenever it makes a new frame in a sub query it goes up the
;frames to see if its identicle. if so it stops.

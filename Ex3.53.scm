;without running the program, describe the elements of the stream defined by

(define s (cons-stream 1 (add-stream s s)))

;1 2 4 8 16
;its the powers of 2


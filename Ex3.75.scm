;;unfortunatly lyssas zero-crossing detector in exerize 3.74 proces to be
;;insufficient because the noisy signal from the sensor leads to spurious zero
;;crossings. Lem E tweakit, a hardware specialist suggests that alyssas smooth
;;the signal to filter out the oise before extracting the zero corssings. alyssa
;;takes his advice and decides to extract the zero-crossings from the signal
;;constructed by averaging each value of the sense data with the previous value.
;;she explains the problem to her assistant louis reasoner who attempts to
;;implement the ide, altering alyssa program as follows:

(define (MakeZeroCrossing InputStream LastValue)
  (let ((avpt (/ (+ (stream-car InputStream) LastValue)2)))
   (cons-stream (SignChangeDetector avpt LastValue)
                (MakeZeroCrossings (stream-cdr InputStream)
                                   avpt))))

;this does not correctly implement alyssa's plan. find the bug that louis has
;installed and fix it without changing the structure of the program(hint:you
;will first need to increase the number of arguments to MakeZeroCrossing)

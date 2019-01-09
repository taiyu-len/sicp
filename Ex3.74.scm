;alyssa P. hacker is designing a system to process signals coming form physical
;snsors. one important feature she wishes to produce is a signal that describes
;zero crossings  of the input signal, that is, the resulting signal should be
;+1  whenever the input signal changes from negative to positive, -1 whenever
;the input signal changesfrom positive to negative, and 0 otherwise. assume that
;the sign of 0 input is positive. forexample a, typical input isngal with its
;associated zero-crossing signal would be
;
;...1  2  1.5  1  0.5  -0.1  -2  -3  -2  -
;0.5  0.2  3  4 ...... 0  0    0  0    0     -
;1  0   0   0     0    1  0  0 ...
;
;in alyssas system, the signal from the sensor is represented as a stream
;sence-data  and the stream  zero-crossings is the corresponding stream of zero
;crossings. alyssa first writes a procedure  sign-change-detector  that takes
;two values as arguments and compares the signs of the values to produce an
;appropriate 0,1, or -1. she then constructs her zero-crossing stream as
;follows:

(define (MakeZeroCrossings InputStream LastValue)
  (cons-stream
    (SignChangeDetector (stream-car InputStream) LastValue)
    (MakeZeroCrossings  (stream-cdr InputStream)
                        (stream-cdr InputStream))))

(define ZeroCrossings (MakeZeroCrossings SenseData 0))

;alyssas boss, evaluator walks by and suggests that this program is
;approximately equivalent to the following one, which uses the generalize
;version of stream-map from exersize 3.50

(define ZeroCrossings
  (stream-map SignChangeDetector SenseData (stream-cdr SenseData)))

;complete the program

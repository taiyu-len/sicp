;ben has been generalizing the query system to provide statistics about the
;company. forexample, to find the total salaries of all the computer programmers
;one will beable to say

(sum ?amount
     (and (job ?x (computer programmer))
          (salary ?x ?amount)))

;in general bens new system allows expressions of the form

'(accumulate-function <variable>
                      <query_pattern>)

;where accumulation-function can be things like sum, average, or maximum. ben
;reasons that it should be a cinch to implement this. he will simply feed the
;query pattern to qeval. this will produce a stream of frames. he will then pass
;this stream through a mapping functioin that extracts the value of the
;designated variables from each frame in the stream and feed the resulting
;stream of values to the accumulation fucntion. just as ben completes the
;implmentation and is about to try it out, cy walks by, when cy shows ben the
;sytsems response, ben groans. " oh no my simple accumulation scheme wont work"
;what has ben just realized? outline a method he can use to salvage the
;situation.

;filter out duplicate names

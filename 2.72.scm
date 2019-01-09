;consider the encoding procedure that you designed in 2.68. what is the order of
;growth in the number of steps needed to encode a symbol? be sure to include the
;number of steps needed to search the symbol list at eash node encoutered. to
;answer this question in general is difficult consider the special case where
;the relative frequencies of the n symbols are as described in 2.71, and give
;the order of growth(as a function of n) of the number of steps needed to encode
;the most frquent ad least frequent symbols in the alphabet

;the finding of the symbol is done
;n/2 + n/4 + n/8 + n/16 ... at most so n)
;the and then there are at least logn steps
;O(n) = n + log(n)

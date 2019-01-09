;suppose that we define unless as shown above and then define factorial in terms
;of unless as

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

;what happens wif we attempt to evaluate (factorial 5)? will our definiton work
;in a normal order language.

;when it hits n=1 it will evaluate both before sending it into the function, and
;would end up continuting forever
;



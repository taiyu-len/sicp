;we cna model electrical circuits using streams to represent the values of
;currents or voltages at a sequence of times. for instance, suppose we hav e an
;rc circuit ocnsitign of a resistor of resitance R and a capacitor of
;capacitance C in the ceries. the voltage response v of the circuit to an
;injected-current i is determined by the forumula in figure 3.33 whose structure
;is shown by the accompanying flow diagram.

;write a procedure RC that models this circuit. RC should take as inputs the
;values of R,C, and dt and should return a procedure that takes as inputs a
;stream representing the current i and an initial value for the cpacaitor
;voltage v_0 and produces as output the stream of voltages v. for example, you
;sould be able to use RC to model an  RC circuit with R=5 ohms, C=1 farad, and a
;0.5-second time step by evaluating 
;(define RC1 (RC 5 1 0.5))
;this defines RC1 as a procedure that takes a stream representing the time
;sequence of current and initial capacitor voltage and produces the output
;stream of voltages.
;


(define (RC R C dt)
  (lambda (i V_0)
    (add-streams
      (integral (scale-stream i (/ 1 C)) V_0 dt)
      (scale-stream i R))))

;a series RLC circuit consits of a resistor, a capacitor, and an inductor
;connected in series as shown in 3.36. if R,L,C are the resistance, inductance,
;and capacitance, then the relations between voltage (v) and current (i) for the
;three components are described by the equations

;v_R = i_R R
;v_L = L(di_L)/(dt)
;i_C = C(dv_C)(dt)

;and the circuit connections dictate the realtions

;i_R = i_L = -i_C
;v_C = v_L + v_R

;combining these equations shows that the state of the circuit (summerized by
;v_C, the voltage across the capacitor, and i_L, the current in inductor) is
;described by the pair of differential equations

;dv_C/dt = -i_L/C
;di_L/dt = v_C/L - Ri_L/L

;the signa-flow diagram representing this system of idifferential equations is
;shown in figure 3.37

;write a procedure RLC that takes as arguments the parameterrs  R,L,C of the
;circuit and the time increment dt. in a manner similar to that of the RC
;procedure of exercise 3.73, RLC should produce a procedure that takes the
;initial values of the state variables, v_C_0  and  i_L_0, and produces a pair
;(using cons) of the stream of states v_C and i_L, using RLC, generate the pair
;of streams that models the behavior of a series RLC circuit with R=1ohm, C=0.2
;farad, L=1henry,dt=0.1s and initial values i_L_0 =0amps and v_C_0 = 10 volts




(define (RLC R L C dt)
  (define (Output input-iL input-vC)
    (define iL (integral (delay diL) input-iL dt))
    (define vC (integral (delay dvC) input-vC dt))
    (define diL (add-streams (scale-stream vC (/ 1 L))
                             (scale-stream iL (/ R L -1))))
    (define dvC (scale-stream iL (/ -1 C)))
    (cons-stream
      (cons (stream-car vC) (stream-car iL))
      (Output (stream-cdr vC) (stream-cdr iL))))
  Output)

;figure 3.27 shows a ripple-carry adder formed by strining together n
;full-adders. this  is the simplest form of parallel adder for adding two n-bit
;binary numbers. the inputs A_1,A_2,A_3,...,A_n and B_1,B_2,B_3,...,B_n are the
;two binary numbers to ab added (each A_k,B_k is a 0 or 1). the circuit
;generates S_1,S_2,S_3,...,S_n, the n bits of the sum, and C, the carry from the
;addition. write a procedure ripple-carry-adder that generates this circuit. the
;procedure should take as arguments three lists of n wires each -- 
;the A_k, the B_k, and S_k, and another wire C. the major draw back of the
;ripple carry adder is hte need to wait for the cary signals to propagate. what
;is the delay needed to obtain the complete output from an n-bit ripple carry
;adder, expessed in terms of delays for and-gates,or-gates and inverters.

;a half adder has a max delay of 2AND+1INVERT,
;in order to get the Carry from a FULLadder. the max delay is 3AND+1INVERT

;meaning N full adders have delay of  (N-1)(3AND+1INVERT) + 4AND+2Invert
;which is the carry for all the first N-1 and the delay to get the actual sum
;from the last one (ignoring the delay to get sum from first N-1 full adders
;cause they dont add any time)



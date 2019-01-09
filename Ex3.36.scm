;suppose we evalute the following sequence of expressions in the global
;environment

;(define a (make-connector))
;(define b (make-connector))
;(set-value! a 10 'user)

;at some time during evaluation of the set-value! the following expression from
;the connectors local procedure is evaluated

;(for-each-except setter inform-about-value constraints)

;draw an environment diagram showing the environment in which the above
;expression is evaluted



;it sets the value to 10, the informant to user
;it then calls the for-each with   informant inform-about-value constraint(which
;is empty)

;make a
;[E1]:value:#f,informant:#f,constraints:'()
;call set-value
;[E2]:connector:a=>E1,new-value:10,informant:user
;call a=>E1
;[E1]=>[E3]:request:'set-value!
;call E1.set-my-value 10 user
;delete E2, dont need the old one anymore
;[E1]=>[E2]:newval:10,setter:user
;sets [E1]:value:10,informant:user
;calls for-each-except user inform-about-value '()
;delete E2,cause not needed anymore
;[E3]:exception:user,proc:infabouval,list:'()
;call [E3.loop]
;[E3]=>[E4]:items:'();
;returns 'done
;delete E4,E3
;
;E1 is left as [Global.a]=>[E1] exists

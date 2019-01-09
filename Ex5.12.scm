;the simulator can be used to help determine the data paths required for
;implementing a machine with a given controller. extend the assembler to store
;the following information in the machine model.

;;;a list of all instructions, with duplicates removed, sorted by instruction
;;;type (assign, goto, and so on)

;;;a list (without duplicates) of registers used to hold entry points (these are
;;;the regesters reference by goto instructions)

;;;a list without duplicates of the registers that are saved or restoreed

;;;for each register, a list (wihout duplicates) of the sources from which it is
;;;assigned. (for example the sources for register cal in the factorial machine
;;;of figure 5.11 are (const 1) and ((op *)(reg n)(reg val)))

;extend the message-passing interface to the machine to provide access to this
;new information. to test your analyzer, define the fibonacci machine from
;figure 5.12 and examine th lists you contructed

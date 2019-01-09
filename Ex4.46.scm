;the evaluators in 4.1 and 4.2 do not determine what order operands are
;evaluated in. we will see that the amb evaluator evaluates from left to
;right.explain why our parsing program woldnt work if the operands were
;evaluated in some other order.
;
;parse-word handles *unparsed* from left to right and so if it is in another
;order it conflicts:

;by giving the query

(lives-near ?person (Hacker Alyssa P))

;alyssa p is able to find people who live near her. with whom she can ride to
;work. on the other hand, when she tries to find all pairs of people who live
;near each other by querying she noticeds people are listed twice.

;why does this happen?
;cause it checks each person and they both return ecahother
;is there a way to find a list of people who live near eachother, in which each
;pair only appears once? explain

;there is, only show those that appear in a certain order, alphanumerically

;lives-near A~~ B~~  this shows
;lives-near B~~ A~~  this doesnt.
;i dont know how to implement it yet though

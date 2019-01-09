;ben bitdiddle,alyssa, and eva are arguing about the desired reuslt of
;evaluating the expression

'(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))
;ben asserts that the result should be obtained using the sequental rule for
;define:b is defined to be 11, then a is defined to be 5, so the reuslt is 16.
;alyssa object that the mutual recursion requires the simultaneous scope rule
;for internal procedure definitions, and that it is unreasonable to treat
;procedure names differently from other names, thus she argues for the
;meachanism implemnted in exercise 4.16. this would lead to a being unassigned
;at the time that the value for b is to be computed. hece in alyssa view the
;procedure should produce an error. eva as a third opinion. she says that if the
;definitions of a and b are truly meant to be simultaneous, then the value 5 for
;a should be used in evaluating b. hence in evas view a should be 5 b 15 and the
;result 20. which if any of these viewpoints do you support? can use devise a
;way to implement internel defintions so that they behave as eva prefers?



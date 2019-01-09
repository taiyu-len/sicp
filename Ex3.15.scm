;draw box-and-pointer diagrams to explain the efft of set-to-wow! on  the
;structures z1 and z2 as described previously


;z1->[_][_]
;     v  v
;x-->[_][_]->[_][/]
;     v       v
;    [a]     [b]
;
;z2--[_][_]->[_][_]->[_][/]
;     \       v       v
;      \     [a]     [b]
;       \     ^       ^
;        \-->[_][_]--[_][/]
;
;set to wow changes the   (caar z) to wow!
;
;z1->[_][_]
;     v  v
;x-->[_][_]->[_][/]
;     v       v
;[a] WOW     [b]
;
;z2--[_][_]->[_][_]->[_][/]
;     \       v       v
;      \     [a]     [b]
;       \             ^
;        \-->[_][_]--[_][/]
;             v
;            WOW
;and as thats how it is
;

;give a scenario where the deadlock-avoidance mechanism described above does not
;work. (Hint:in the exchange problme, ecah process knows in advance which
;accounts it will need to get access to. consider a situatin where a process
;must get access to some shared resource beforeit can know chih additional
;shared resource it will require
;
;
;so a linked lists with shared members. it also needs to maintain the lock on
;prior links since it does shit recursivly

;
;a-b-e-x-d-c
;c-v-b-w-d-a
;
;
;C,A locks early. Both try to access the other late.deadlock

;ben bitdiiddle has missed one meeting too many. fearing that his habit of
;forgetting meetings could cost him his job, he does somethign about it. he adds
;all the weekly meetings of the firm to the microshaft database by asserting the
;following  (SEE DATA BASE SECTION IN 4.4.SCM)

;Each of the above assertions is for a meeting of an entire division. ben also
;adds an entry for the companywide meeting that spans all divisions. all of the
;companies employees attend this meeting  (SEE AGAIN)


;a; on friday morning ben want to query the data base for all meeting that occur
;that day what query should he use

(meeting ?type (Friday . ?details))

;b; alyssa is unimpressed. she thinks it would be much more useful to be able to
;ask for her meetings by specifying her name so she designs a rule that says
;that a persons meetings include all  whole-company meetings plus all meetings
;of that person's divions
;fill in the body of alyssas rule

(rule (meeting-time ?person ?day-and-time)
      (and (job ?person (?dept . ?detail))
           (or (meeting ?dept ?day-and-time)
               (meeting the-whole-company ?day-and-time))))

;c;alyssa arrive at work on wedneesday morning and wonders what meetings she has
;to attend that day. having defined the above rule, what query should she make
;to find out

(and (meeting-time (Hacker Alyssa P) (Wednesday . ?time))
     (meeting ?dept (Wednesday . ?time)))

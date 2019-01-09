;consider the probelm of transferring an amount from one acount to another. ben
;bitdiddle claims that this can be accomplished with the folllowing procedure,
;even if there are multiple people concurrently transferrring money among
;multiple accounts, using any account mechanism that serializes deposit and
;withdrawal transactions, for example, the version of make-account in the text
;above.

(define (transfer from-account to-account amount)
  ((from-account 'withdraw)amount)
  ((to-accound 'deposit)amount))
;louis reasoner claims that there is a problem here, and that we need to use a
;more sophisticated method. such as the one required for dealing with the
;exchange problem. is louis right? if not, what is the essential difference
;between the transfer problem and the exchange problem? (you should assume that
;the balance in from-account is at least amount.)

;;like always non serialized access can mess it up

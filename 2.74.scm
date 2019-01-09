;insatiable enterprises inc is a highly decentralized conglomerate company
;consisting of a large number of independent divisions located all over the
;world. the companys computer facilities have just been interconnected by means
;of a clever network-interfacing scheme that makes the entire network appear to
;any user to be a single computer. insatiables president in her first attempt to
;exploit the ability of the network to extract administrative information from
;division files, is dismayed to discover that, although all the division files
;have been implemented as datastructures in scheme, the particular data
;structure used varies from division to division. a meeting of division managers
;is hastily called to search for a strategy to integrate the files that will
;satisfy headquarters needs while preserving the existing autonomy of the
;divisions.
;show how such a strategy can be implemented wit data-directed programming. as
;an example, suppose the each divisions personnel records consist of a single
;file, which contains a set of records keyed on employees names. the structure
;of the set varies fom division to division. further more, each employees record
;is itself a set. that contains information keyed under identifiers such as
;address and salary. in particualr

;a; implement for headquarters a get-record procedure that retrieves a specified
;employees record from a specified personnel file. the procedure should be
;applicable tpo any divisions files. explain how the indiviual diviisons files
;should be structured. in particular what type information must be supplied.

(define (get-record employee personnel)
  (get (get personnel employee) 'record))
(define (get-salary employee personnel)
  (get (get personnel employee) 'salary))
(define (find-employee-record employee divisions)
  (if (null? divisions)
    '()
    (cons
      (get-record employee (car divisions))
      (find-employee-record (cdr divisions)))))


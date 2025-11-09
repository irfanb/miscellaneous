(defun filter(list predicate)
  (if (null list) '()
    (let (
	  (the-rest (filter (cdr list) predicate))
	  )
      (if (funcall predicate (car list))
	(cons (car list) the-rest)
	the-rest
	)
      )
    )
  )

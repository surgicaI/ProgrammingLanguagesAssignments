;;; Base Case:  L is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;;             any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is a list, then return the sum of the count of the
;;;       numbers in (car L) and the count of the numbers in (cdr L).
;;;       If (car L) is a number, return 1 plus the count of the numbers in
;;;       (cdr L). Otherwise, return the count of the numbers in (cdr L).
(define (count-numbers L)
    (cond ((null? L) 0 )
          (else (cond ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))
                      (else (cond ((number? (car L)) (+ 1 (count-numbers (cdr L))))
                                  (else (count-numbers (cdr L)))))))))


;;; Base Case:  L is empty, return list containing x
;;; Assumption: (insert x M) return a new list where x is inserted at correct 
;;;             location in M, for any list M smaller than L ie cdr L.
;;; Step: if X is smaller than car L insert x in first position of L and return that new list
;;;       if x is greater than car L then call insert x (cdr L).
;;;       then use cons tp combine list returned by "insert x (cdr L)" and "(car L)"
(define (insert x L)
    (if (null? L) (list x)
    (if (> x (car L)) (cons (car L) (insert x (cdr L)))
        (cons x L))))


;;; Base Case:  L is empty, return M
;;; Assumption: (insert-all N M) return a new list where N is inserted properly
;;;             in M, for any list N smaller than L ie cdr L.
;;; Step: use insert to insert (car L) in M at proper location
;;;       then use insert-all to insert (cdr L) with M
(define (insert-all L M)
    (if (null? L) M
        (insert-all (cdr L) (insert (car L) M))))



;;; defined insert function using letrec
;;; Base Case:  L is empty, return L
;;; Assumption: (sort M) works properly on any list M smaller than L
;;;             including (cdr L)
;;; Step: use insert to insert (car L) in already sorted list which have elements
;;;       of (cdr L)
(define (sort L)
    (letrec ((insert (lambda (x L)
                        (if (null? L) (list x)
                            (if (> x (car L)) (cons (car L) (insert x (cdr L)))
                                (cons x L))))))
    (if (null? L) L
    (insert (car L) (sort (cdr L))))))




(define (translate op)
    (cond ((eq? op '+) +)
          ((eq? op '-) -)
          ((eq? op '*) *)
          ((eq? op '/) /)))


;;; Base Case 1:  exp is empty, return exp
;;; Base Case 2:  exp is a number, return that number
;;; Assumption: (postfix-eval M) works properly on any list M which is sub-list of exp
;;;             including (car exp) and (cadr exp)
;;; Step: use (postfix-eval) on (car exp) and (cadr exp) to evaluate them and the evaluate 
;;;       final expression
(define (postfix-eval exp)
    (if (null? exp) exp
    (if (number? exp) exp
        ((translate (caddr exp)) (postfix-eval (car exp)) (postfix-eval (cadr exp))))))


;;; defined insert-everywhere function using letrec
;;; this function assumes that all elements of M will be lists
;;; Base Case:  L is empty, return (list L)
;;; Assumption: (powerset M) works properly on any list M smaller than L
;;;             including (cdr L)
;;; Step: use insert-everywhere to insert (car L) in all locations of powerset of (cdr L)
;;;       then append it with powerset of (cdr L)
(define (powerset L)
    (letrec ((insert-everywhere (lambda (x M)
                                  (if (null? M) M
                                      (cons (cons x (car M)) (insert-everywhere x (cdr M)))))))
      (if (null? L) (list L)
          (append (powerset (cdr L)) (insert-everywhere (car L) (powerset (cdr L)))))))
;;; 1
;;; Base Case: L contains one element, return the first element of L, (car L).
;;; Assumption: find-min works on (cdr L), returning the smallest element
;;; of (cdr L).
;;; Step: Let x be the result of calling (find-min (cdr L)). If (car L) is
;;; less than x, return (car L). Otherwise, return x.


(define (find-min L)
    (cond ((null? (cdr L)) (car L))
          (else (let ((x (find-min (cdr L))))
                  (if (< (car L) x) (car L) x)))))


;;; 2
;;; Base Case: If L has one element, return a list containing (car L) and ’()
;;; Assumption: find-min-rest works on (cdr L), returning a list with the smallest 
;;; element of (cdr L) and the rest of (cdr L)
;;; Step: Let y be the result of calling (find-min-rest (cdr L)). If (car L) is
;;; less than x, return (car L). Otherwise, return x. 

(define (find-min-rest L)
  (cond ((null? (cdr L)) (cons (car L) '(())) )
          (else (let ((x (find-min-rest (cdr L))))  
            (if (< (car L) (car x)) (cons (car L) (cons (cons (car x) (cadr x)) '())) (cons (car x) (cons (cons (car L) (cadr x)) '()))   )))))  


;;; 3
;;; Base Case: If L has one element, return a list containing (car L)
;;; Assumption: sort works on (cdr L), returning a list with the containing 
;;; the elements of (cdr L) in sorted order
;;; Step: Let x be the result of calling (find-min-rest (L)) Return (car x) 
;;; (sort (cdr L))

(define (sort L)
  (cond ((null? (cdr L)) L)
          (else (let ((x (find-min-rest L)))
            (cons (car x) (sort (cadr x))) )) ))  


;;; 4
;;; Base Case: If L has one element, return (car L)
;;; Assumption: sum-List works on (cdr L), returning the sum of all elements of
;;; (cdr L) 
;;; Step: Let x be the result of calling (sum (cdr L)) If (car x) is an element,  
;;; return (x + (sum (cdr L))). Else return ((sum (car L)) + (sum (cdr L)))

(define (sum-list L)
  (cond (((null? L) 0) )
          (else (let ((x (sum-list (cdr L))))  
            ( if (list? (car L)) (+ (sum-list (car L)) x) (+ (car L) x) ))) )) 


         
;;; 5
;;; Base Case: If L1 and L2 have one element, return (f (car L1) (car L2))
;;; Assumption: map2 works on (cdr L), returning a list of consisting
;;; of elements resulting from applying f to corresponding elements of (cdr L1) 
;;; and (cdr L2) 
;;; Step: Let x be the result of calling map2 to (cdr L1) and (cdr L2) Return
;;; ((f (car L1) (car L2)) x)

(define (map2 f L1 L2)
  (cond ((null? (cdr L1)) (cons (f (car L1) (car L2)) '())) 
          (else (cons (f (car L1) (car L2)) (map2 f (cdr L1) (cdr L2)) ))))


         


;;; 6
;;; Base Case: If n = m, return a list with a single element = n
;;; Assumption: nums-from works on n+1 to m, returning a list of consisting of 
;;; integers from n+1 to m
;;; Step: Let x be the result of calling nums-from to n+1 and m Return
;;; (cons n x)

(define (nums-from n m)
  ( if (= n m) (cons n '()) (cons n (nums-from (+ n 1 ) m)) ))
         


;;; 7
;;; Base Case: If L = (), return ()
;;; Assumption: (remove-mults n) works (cdr L), returning a list of consisting of 
;;; elements of (cdr L) that are not multiples of n
;;; Step: Let x be the result of calling (remove-mults n) to on (cdr L) If 
;;; (modulo (car L) n) ==0, return x, else, return (cons (car L) x)


(define (remove-mults n L)
  ( if (null? L) '() 
    ( let ((x (remove-mults n (cdr L))))
      (if (= (modulo (car L) n) 0) x (cons (car L) x) )  )))


         
;;; 8
;;; Base Case: If L = (), return ()
;;; Assumption: sieve works (cdr L), returning a list of consisting of 
;;; elements of (cdr L) that are not multiples of each other
;;; Step: Let x be the result of calling sieve to on (cdr L) Return 
;;; (cons (car L) (remove-mults (car L) (cdr L)))


(define (sieve L)
  ( if (null? L) '() 
    ( cons (car L) (remove-mults (car L) (sieve (cdr L)))  )))



;;; 9
(define (primes n)
  ( if (= n 1) '() 
    ( sieve (nums-from 2 n))  ))
         

;;; 10
;;; recursive function for f x y
;;; Base Case: If x = y, return a function that add x=y to an input a, ie 
;;; (lambda (a) (+ x a))
;;; Assumption: f works for (f x+1 y), returning a list of functions that add (x+1);;; , (x+2), ..., y to an input a
;;; Step: Let t be the result of calling (f (x+1) y) Return 
;;; (cons (lambda (a) (+ x a)) t)


(define (gen-fn-list n)
	(if (< n 1) '() 
    (letrec ((f (lambda (x y) (if (= x y) (cons (lambda (a) (+ x a)) '()) (cons (lambda (a) (+ x a)) (f (+ 1 x) y) ))  )))
      (f 1 n))))





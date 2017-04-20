Control.Print.printDepth := 100;
Control.Print.printLength := 100;

fun revhelp [] to = to
| revhelp (x::xs) to = revhelp xs (x::to)  

fun reverse from = revhelp from []


fun new_reverse from = 
	let fun rev [] to = to
	| rev (x::xs) to = rev xs (x::to)
	in rev from []
	end 


fun reduce_depth [] = []
| reduce_depth (x::xs) = x @ (reduce_depth xs)


infix elt  
fun a elt (b::bs) = a=b orelse a elt bs
| a elt [] = false  

infix ++  
fun [] ++ x = x
| (x::xs) ++ y = if (x elt y) then (xs ++ y) else x::(xs ++ y) 

infix **  
fun [] ** x = []
| (x::xs) ** y = if (x elt y) then x::(xs ** y) else (xs ** y) 

infix -- 
fun [] -- x = []
| (x::xs) -- y = if (x elt y) then (xs -- y) else x::(xs -- y) 


datatype tree = leaf of int | node of int * tree * tree


datatype 'a ptree = pleaf of 'a | pnode of 'a * 'a ptree * 'a ptree 


fun interior (pleaf x) = []
| interior (pnode (x, left, right)) = (interior left) @ (x :: (interior right)) 


fun mapTree f (pleaf x) = (pleaf (f x))
| mapTree f (pnode (x,left, right)) = pnode ( (f x), (mapTree f left), (mapTree f right)) 


fun lexLess (op <) L1 [] = false
| lexLess (op <) [] L2 = true
| lexLess (op <) (x::xs) (y::ys) = if x < y then true else if y < x then false else lexLess (op <) xs ys 


fun ptreeLess (op <) (pleaf x) (pnode (y,left,right)) = true 
| ptreeLess (op <) (pnode (x,left,right)) (pleaf e) = false
| ptreeLess (op <) (pleaf x) (pleaf y) = (x<y)
| ptreeLess (op <) (pnode (x,l1,r1)) (pnode (y,l2,r2)) = if (ptreeLess (op <) l1 l2) then true else 
if (ptreeLess (op <) l2 l1) then false else 
if x<y then true else
if y<x then false else 
if (ptreeLess (op <) r1 r2) then true else false 


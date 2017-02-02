Control.Print.printDepth := 100 ;
Control.Print.printLength := 100 ;

fun merge [] L2 = L2
| merge L1 [] = L1
| merge (x::xs) (y::ys) = if x<y then x:: merge xs (y::ys)
else y:: merge (x::xs) ys

fun split [] = ([],[])
|	split (x::[]) = ([x],[])     
|	split (x1::x2::xs) = let 
	val (L1,L2) = split xs
	in (x1::L1 , x2::L2)
	end

fun mergeSort [] = []
| mergeSort (x::[]) = [x]
| mergeSort L = let 
	val (L1,L2) = split L
	in merge (mergeSort L1) (mergeSort L2) 
	end

fun sort (op <) [] = []
|	sort (op <) (x::[]) = [x]
|	sort (op <) L = let
		fun mySplit [] = ([],[])
	|		mySplit (x::[]) = ([x],[])     
	|		mySplit (x1::x2::xs) =  let 
			val (L1,L2) = mySplit xs
			in (x1::L1 , x2::L2)
			end
	in let 
		fun myMerge [] L2 = L2
	| 		myMerge L1 [] = L1
	| 		myMerge (x::xs) (y::ys) = if x<y then x:: myMerge xs (y::ys)
			else y:: myMerge (x::xs) ys
	in let 
	val (L1,L2) = mySplit L
	in myMerge (sort (op <) L1) (sort (op <) L2)
	end
	end
end

datatype 'a tree = leaf of 'a | node of 'a * 'a tree * 'a tree | empty ;

fun labels empty = []
| labels (leaf n) = [n]
| labels (node (n , leftSubTree, rightSubTree)) = (labels leftSubTree)@(n::(labels rightSubTree))

infix ==
fun replace (op ==) x y empty = empty
|	replace (op ==) x y (leaf n) = if n==x then (leaf y)
		else (leaf n)
|	replace (op ==) x y (node (n, leftSubTree, rightSubTree)) = if n==x 
		then (node (y, replace (op ==) x y leftSubTree, replace (op ==) x y rightSubTree))
		else (node (n, replace (op ==) x y leftSubTree, replace (op ==) x y rightSubTree))

fun replaceEmpty y empty = y
| replaceEmpty y (leaf n) = leaf n
| replaceEmpty y (node (n, leftSubTree, rightSubTree)) = 
	node (n, replaceEmpty y leftSubTree, replaceEmpty y rightSubTree)

fun mapTree f empty = f empty         
| mapTree f (leaf n) = f (leaf n)
| mapTree f (node (n, leftSubtree, rightSubtree)) = 
	f (node (n, mapTree f leftSubtree, mapTree f rightSubtree))

fun sortTree (op <) Tree =  
 	mapTree (fn empty => empty | (leaf L) => (leaf (sort (op <) L)) 
 	| (node (L, left, right))=>node ((sort (op <) L), left,right)) Tree
-- Data.List
import Data.List

-- intersperse takes an element and a list and then puts that element 
-- in between each pair of elements in the list.
is1 = intersperse '.' "MONKEY"  
-- "M.O.N.K.E.Y"  
is2 = intersperse 0 [1,2,3,4,5,6]  
-- [1,0,2,0,3,0,4,0,5,0,6]  


-- intercalate takes a list of lists and a list. 
-- It then inserts that list in between all those lists and then flattens the result.
ic1 =  intercalate " " ["hey","there","guys"]  
-- "hey there guys"  
ic2 =  intercalate [0,0,0] [[1,2,3],[4,5,6],[7,8,9]]  
-- [1,2,3,0,0,0,4,5,6,0,0,0,7,8,9]  


-- transpose transposes a list of lists. If you look at a list of lists as a 2D matrix, 
-- the columns become the rows and vice versa.
tr1 = transpose [[1,2,3],[4,5,6],[7,8,9]]  
-- [[1,4,7],[2,5,8],[3,6,9]]  
tr2 = transpose ["hey","there","guys"]  
-- ["htg","ehu","yey","rs","e"]  


st = map sum $ transpose [[0,3,5,9],[10,0,0,9],[8,5,1,-1]]  
-- [18,8,6,17]  


-- foldl' and foldl1' are stricter versions of their respective lazy incarnations.


-- concat flattens a list of lists into just a list of elements.
cc1 = concat ["foo","bar","car"]  
-- "foobarcar"  
cc2 = concat [[3,4,5],[2,3,4],[2,1,1]]  
-- [3,4,5,2,3,4,2,1,1]  


-- Doing concatMap is the same as first mapping a function to a list and 
-- then concatenating the list with concat.
ccm = concatMap (replicate 4) [1..3]  
-- [1,1,1,1,2,2,2,2,3,3,3,3]  


-- and takes a list of boolean values and returns True only 
-- if all the values in the list are True.
a1 = and $ map (>4) [5,6,7,8]  
-- True  
a2 = and $ map (==4) [4,4,4,3,4]  
-- False  

-- or is like and, only it returns True if any of the boolean values in a list is True.
o1 = or $ map (==4) [2,3,4,5,6,1]  
-- True  
o2 =  or $ map (>4) [1,2,3]  
-- False  


-- any and all take a predicate and then check if any or all the 
-- elements in a list satisfy the predicate, respectively.
aa1 = any (==4) [2,3,5,6,1,4]  
-- True  
aa2 =  all (>4) [6,9,10]  
-- True  
aa3 = all (`elem` ['A'..'Z']) "HEYGUYSwhatsup"  
-- False  
aa4 = any (`elem` ['A'..'Z']) "HEYGUYSwhatsup"  
-- True  


-- iterate takes a function and a starting value. 
it1 = take 10 $ iterate (*2) 1  
-- [1,2,4,8,16,32,64,128,256,512]  
it2 = take 3 $ iterate (++ "haha") "haha"  
-- ["haha","hahahaha","hahahahahaha"]  


-- splitAt takes a number and a list. It then splits the list at that many elements, 
-- returning the resulting two lists in a tuple.
sp1 =  splitAt 3 "heyman"  
-- ("hey","man")  
sp2 = splitAt 100 "heyman"  
-- ("heyman","")  
sp3 = splitAt (-3) "heyman"  
-- ("","heyman")  
sp4 = let (a,b) = splitAt 3 "foobar" in b ++ a  
-- "barfoo"  


-- takeWhile takes elements from a list while the predicate holds and 
-- then when an element is encountered that doesn't satisfy the predicate, it's cut off. 
tw1 = takeWhile (>3) [6,5,4,3,2,1,2,3,4,5,4,3,2,1]  
-- [6,5,4]  
tw2 = takeWhile (/=' ') "This is a sentence"  
-- "This"  
tw3 = sum $ takeWhile (<10000) $ map (^3) [1..]  
-- 53361  


-- dropWhile is similar, only it drops all the elements while the predicate is true. 
-- Once predicate equates to False, it returns the rest of the list.
dw1 = dropWhile (/=' ') "This is a sentence"  
-- " is a sentence"  
dw2 = dropWhile (<3) [1,2,2,2,3,4,5,4,3,2,1]  
-- [3,4,5,4,3,2,1]  
stock = [(994.4,2008,9,1),(995.2,2008,9,2),(999.2,2008,9,3),(1001.4,2008,9,4),(998.3,2008,9,5)]  
dw4 = head (dropWhile (\(val,y,m,d) -> val < 1000) stock)  
-- (1001.4,2008,9,4)  


-- span
spn1 = let (fw, rest) = span (/=' ') "This is a sentence" in "First word:" ++ fw ++ ", the rest:" ++ rest  
-- "First word: This, the rest: is a sentence"  
--break: break p == span (not . p)
b1 = break (==4) [1,2,3,4,5,6,7]  
-- ([1,2,3],[4,5,6,7])  
spn2 = span (/=4) [1,2,3,4,5,6,7]  
-- ([1,2,3],[4,5,6,7])  


-- sort
st1 = sort [8,5,3,2,1,6,4,2]  
-- [1,2,2,3,4,5,6,8]  
st2 = sort "This will be sorted soon"  
-- "    Tbdeehiillnooorssstw"  


-- group takes a list and groups adjacent elements into sublists if they are equal.
g = group [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]  
-- [[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]]  


-- inits and tails are like init and tail, only they recursively apply 
-- that to a list until there's nothing left.
in1 = inits "w00t"  
-- ["","w","w0","w00","w00t"]  
tl1 =  tails "w00t"  
-- ["w00t","00t","0t","t",""]  
intl = let w = "w00t" in zip (inits w) (tails w)  
-- [("","w00t"),("w","00t"),("w0","0t"),("w00","t"),("w00t","")]  


search :: (Eq a) => [a] -> [a] -> Bool  
search needle haystack =   
    let nlen = length needle  
    in  foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)  
-- isIndexOf
iio1 = "cat" `isInfixOf` "im a cat burglar"  
-- True  
iio2 = "Cat" `isInfixOf` "im a cat burglar"  
-- False  
iio3 = "cats" `isInfixOf` "im a cat burglar"  
-- False  
ipo1 = "hey" `isPrefixOf` "hey there!"  
--True  
ipo12 = "hey" `isPrefixOf` "oh hey there!"  
-- False  
iso1 = "there!" `isSuffixOf` "oh hey there!"  
-- True  
iso2 =  "there!" `isSuffixOf` "oh hey there"  
-- False  


-- elem and notElem check if an element is or isn't inside a list.


-- partition takes a list and a predicate and returns a pair of lists. 
p1 = partition (`elem` ['A'..'Z']) "BOBsidneyMORGANeddy"  
-- ("BOBMORGAN","sidneyeddy")  
p2 = partition (>3) [1,3,5,6,3,2,1,0,3,7]  
-- ([5,6,7],[1,3,3,2,1,0,3])  
-- c.f.
spn3 = span (`elem` ['A'..'Z']) "BOBsidneyMORGANeddy"  
-- ("BOB","sidneyMORGANeddy")  


--ghci> :t find  
-- find :: (a -> Bool) -> [a] -> Maybe a  
f1 = find (>4) [1,2,3,4,5,6]  
-- Just 5  
f2 = find (>9) [1,2,3,4,5,6]  
-- Nothing  

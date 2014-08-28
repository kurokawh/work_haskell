-- *Main> :t foldl
-- foldl :: (a -> b -> a) -> a -> [b] -> a

sum' :: (Num a) => [a] -> a  
sum' xs = foldl (\acc x -> acc + x) 0 xs  
-- use fold
sum2 :: (Num a) => [a] -> a  
sum2 = foldl (+) 0  
-- don't use curried func
sum3 :: (Num a) => [a] -> a  
sum3 a = foldl (+) 0 a
-- sum [3,5,2,1]
-- 0 + 3 ... [5,2,1]
-- 3 + 5 ... [2,1]
-- 8 + 2 ... [1]
-- 10 + 1 ... []
-- 11

elem' :: (Eq a) => a -> [a] -> Bool  
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys  



-- foldr
map' :: (a -> b) -> [a] -> [b]  
map' f xs = foldr (\x acc -> f x : acc) [] xs  
-- if use foldl
map'_with_foldl f xs = foldl (\acc x -> acc ++ [f x]) [] xs



-- foldl1 / foldr1
-- They assume the first (or last) element of the list to be the starting value 
-- and then start the fold with the element next to it. 
maximum' :: (Ord a) => [a] -> a  
maximum' = foldr1 (\x acc -> if x > acc then x else acc)  
  
reverse' :: [a] -> [a]  
reverse' = foldl (\acc x -> x : acc) []  
--reverse' = foldl (flip (:)) []
  
product' :: (Num a) => [a] -> a  
product' = foldr1 (*)  
  
filter' :: (a -> Bool) -> [a] -> [a]  
filter' p = foldr (\x acc -> if p x then x : acc else acc) []  
  
head' :: [a] -> a  
head' = foldr1 (\x _ -> x)  
  
last' :: [a] -> a  
last' = foldl1 (\_ x -> x)  



-- scanl / scanr
-- scanl and scanr are like foldl and foldr, 
-- only they report all the intermediate accumulator states in the form of a list.
--
s1 = scanl (+) 0 [3,5,2,1]  
-- [0,3,8,10,11]  
s2 = scanr (+) 0 [3,5,2,1]  
-- [11,8,3,1,0]  
s3 = scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]  
-- [3,4,5,5,7,9,9,9]  
s4 = scanl (flip (:)) [] [3,2,1]  
-- [[],[3],[2,3],[1,2,3]]  



sqrtSums :: Int  
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1  
ret131 = sqrtSums  
-- 131  
r131 = sum (map sqrt [1..131])  
-- 1005.0942035344083  
r130 = sum (map sqrt [1..130])  
-- 993.6486803921487  

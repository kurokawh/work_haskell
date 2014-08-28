applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x)  

ret16 = applyTwice (+3) 10  
-- 16  
retHH = applyTwice (++ " HAHA") "HEY"  
-- "HEY HAHA HAHA"  
retNN =  applyTwice ("HAHA " ++) "HEY"  
-- "HAHA HAHA HEY"  
--ret144 =  applyTwice (multThree 2 2) 9  
-- 144  
retArr = applyTwice (3:) [1]  
-- [3,3,1]  



zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys  

ret_plus =  zipWith' (+) [4,2,5,6] [2,6,2,3]  
-- [6,8,7,9]  
ret_max =  zipWith' max [6,3,2,1] [7,3,1,5]  
-- [7,3,2,5]  
ret_p =  zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]  
-- ["foo fighters","bar hoppers","baz aldrin"]  
ret_multi =  zipWith' (*) (replicate 5 2) [1..]  
-- [2,4,6,8,10]  
ret_zip =  zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]  
-- [[3,4,6],[9,20,30],[10,12,12]]  



flip' :: (a -> b -> c) -> (b -> a -> c)  
flip' f = g  
    where g x y = f y x  

flip'2 :: (a -> b -> c) -> b -> a -> c  
flip'2 f y x = f x y  

retf1 =  flip' zip [1,2,3,4,5] "hello"  
-- [('h',1),('e',2),('l',3),('l',4),('o',5)]  
retf2 =  zipWith (flip' div) [2,2..] [10,8,6,4,2]  
-- [5,4,3,2,1]  

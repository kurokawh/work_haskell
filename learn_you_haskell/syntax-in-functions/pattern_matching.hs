
lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"   


sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5" 


factorial :: (Integral a) => a -> a  
factorial 0 = 1  
factorial n = n * factorial (n - 1)  


charName :: Char -> String  
charName 'a' = "Albert"  
charName 'b' = "Broseph"  
charName 'c' = "Cecil"  



addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)  
addVectors a b = (fst a + fst b, snd a + snd b)  
addVectors2 :: (Num a) => (a, a) -> (a, a) -> (a, a)  
addVectors2 (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)  


-- _ 
first :: (a, b, c) -> a  
first (x, _, _) = x  
second :: (a, b, c) -> b  
second (_, y, _) = y  
third :: (a, b, c) -> c  
third (_, _, z) = z  


-- list comprehension
xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
xss = [a+b | (a,b) <- xs]  
-- [4,7,6,8,11,4]   


-- : 
-- x:y:z:zs
--
-- Note: The x:xs pattern is used a lot, especially with recursive functions. 
-- But patterns that have : in them only match against lists of length 1 or more.
head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"  
head' (x:_) = x  

tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y  

length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs  

sum' :: (Num a) => [a] -> a  
sum' [] = 0  
sum' (x:xs) = x + sum' xs  

-- You do that by putting a name and an "@" in front of a pattern. 
-- For instance, the pattern xs@(x:y:ys). 
-- This pattern will match exactly the same thing as x:y:ys 
-- but you can easily get the whole list via xs instead of repeating 
-- yourself by typing out x:y:ys in the function body again.
capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]  

ret = capital "Dracula"
-- "The first letter of Dracula is D" 

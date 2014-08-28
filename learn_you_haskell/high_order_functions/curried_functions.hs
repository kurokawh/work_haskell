multThree :: (Num a) => a -> a -> a -> a  
multThree x y z = x * y * z  

multTwoWithNine = multThree 9  
-- multTwoWithNine 2 3  
-- 54  
multWithEighteen = multTwoWithNine 2  
-- multWithEighteen 10  
-- 180  



compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred x = compare 100 x  
compareWithHundred' :: (Num a, Ord a) => a -> Ordering  
compareWithHundred' = compare 100  

divideByTen :: (Floating a) => a -> a  
divideByTen = (/10)  



isUpperAlphanum :: Char -> Bool  
isUpperAlphanum = (`elem` ['A'..'Z'])  

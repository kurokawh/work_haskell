-- ($) :: (a -> b) -> a -> b  
-- f $ x = f x  

s1 = sum (map sqrt [1..130])
s2 = sum $ map sqrt [1..130]


x1 = sqrt 3 + 4 + 9
sq1 = sqrt (3 + 4 + 9)
sq2 = sqrt $ 3 + 4 + 9


f1 = sum (filter (> 10) (map (*2) [2..10]))
f2 = sum $ filter (> 10) $ map (*2) [2..10]



rr = map ($ 3) [(4+), (10*), (^2), sqrt]  
-- [7.0,30.0,9.0,1.7320508075688772]  
rrr = ($ 3) (4 +)
-- 7




--
-- (.) :: (b -> c) -> (a -> b) -> a -> c  
-- f . g = \x -> f (g x)  
--

n1 = map (\x -> negate (abs x)) [5,-3,-6,7,-3,2,-19,24]  
-- [-5,-3,-6,-7,-3,-2,-19,-24]  
n1' = map (negate . abs) [5,-3,-6,7,-3,2,-19,24]  
-- [-5,-3,-6,-7,-3,-2,-19,-24]  

n2 = map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]]  
-- [-14,-15,-27]  
n2' = map (negate . sum . tail) [[1..5],[3..6],[1..7]]  
-- [-14,-15,-27]  


-- point free / pointless
fn x = ceiling (negate (tan (cos (max 50 x))))  
fn' = ceiling . negate . tan . cos . max 50  


oddSquareSum :: Integer  
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))     
oddSquareSum' :: Integer  
oddSquareSum' = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]  
oddSquareSum'' :: Integer  
oddSquareSum'' =   
    let oddSquares = filter odd $ map (^2) [1..]  
        belowLimit = takeWhile (<10000) oddSquares  
    in  sum belowLimit  

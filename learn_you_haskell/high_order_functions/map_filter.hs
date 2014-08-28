map' :: (a -> b) -> [a] -> [b]  
map' _ [] = []  
map' f (x:xs) = f x : map f xs  

m1 = map (+3) [1,5,3,1,6]  
-- [4,8,6,4,9]  
m2 =  map (++ "!") ["BIFF", "BANG", "POW"]  
-- ["BIFF!","BANG!","POW!"]  
m3 = map (replicate 3) [3..6]  
-- [[3,3,3],[4,4,4],[5,5,5],[6,6,6]]  
m4 =  map (map (^2)) [[1,2],[3,4,5,6],[7,8]]  
-- [[1,4],[9,16,25,36],[49,64]]  
m5 =  map fst [(1,2),(3,5),(6,3),(2,6),(2,5)]  
-- [1,3,6,2,2]  



filter' :: (a -> Bool) -> [a] -> [a]  
filter' _ [] = []  
filter' p (x:xs)   
    | p x       = x : filter p xs  
    | otherwise = filter p xs  

f1 = filter (>3) [1,5,3,2,1,6,4,3,2,1]  
-- [5,6,4]  
f2 = filter (==3) [1,2,3,4,5]  
-- [3]  
f3 = filter even [1..10]  
-- [2,4,6,8,10]  
f4 = let notNull x = not (null x) in filter notNull [[1,2,3],[],[3,4,5],[2,2],[],[],[]]  
-- [[1,2,3],[3,4,5],[2,2]]  
f5 = filter (`elem` ['a'..'z']) "u LaUgH aT mE BeCaUsE I aM diFfeRent"  
-- "uagameasadifeent"  
f6 = filter (`elem` ['A'..'Z']) "i lauGh At You BecAuse u r aLL the Same"  
-- "GAYBALLS"  



quicksort2 :: (Ord a) => [a] -> [a]    
quicksort2 [] = []    
quicksort2 (x:xs) =     
    let smallerSorted = quicksort2 (filter (<=x) xs)  
        biggerSorted = quicksort2 (filter (>x) xs)   
    in  smallerSorted ++ [x] ++ biggerSorted  


largestDivisible :: (Integral a) => a  
largestDivisible = head (filter p [100000,99999..])  
    where p x = x `mod` 3829 == 0  


-- takeWhile
t1 = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))  
-- 166650  
t2 = sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])  
-- 166650



-- for all starting numbers between 1 and 100, how many chains have a length greater than 15?
chain :: (Integral a) => a -> [a]  
chain 1 = [1]  
chain n  
    | even n =  n:chain (n `div` 2)  
    | odd n  =  n:chain (n*3 + 1)  

c10 =  chain 10  
-- [10,5,16,8,4,2,1]  
c1 = chain 1  
-- [1]  
c30 =  chain 30  
-- [30,15,46,23,70,35,106,53,160,80,40,20,10,5,16,8,4,2,1]  

numLongChains :: Int  
numLongChains = length (filter isLong (map chain [1..100]))  
    where isLong xs = length xs > 15  

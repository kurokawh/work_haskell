maximum' :: (Ord a) => [a] -> a  
maximum' [] = error "maximum of empty list"  
maximum' [x] = x  
maximum' (x:xs)   
    | x > maxTail = x  
    | otherwise = maxTail  
    where maxTail = maximum' xs  


maximum2' :: (Ord a) => [a] -> a  
maximum2' [] = error "maximum of empty list"  
maximum2' [x] = x  
maximum2' (x:xs) = max x (maximum' xs)  

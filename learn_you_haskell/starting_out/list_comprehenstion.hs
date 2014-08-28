doubled = [x*2 | x <- [1..10]]  
-- [2,4,6,8,10,12,14,16,18,20]  

doubled_with_condition = [x*2 | x <- [1..10], x*2 >= 12]  
-- [12,14,16,18,20]  

from50to100 =  [ x | x <- [50..100], x `mod` 7 == 3]  
-- [52,59,66,73,80,87,94]   


boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]


not13_15_19 = [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]  
-- [10,11,12,14,16,17,18,20]  


xy = [ x*y | x <- [2,5,10], y <- [8,10,11]]  
-- [16,20,22,40,50,55,80,100,110]   



length' xs = sum [1 | _ <- xs]
-- _ means that we don't care what we'll draw from the list anyway so instead of writing a variable name that we'll never use, we just write _. This function replaces every element of a list with 1 and then sums that up. This means that the resulting sum will be the length of our list.


removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   

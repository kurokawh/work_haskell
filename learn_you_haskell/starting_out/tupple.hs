
f8 = fst (8,11)  
-- 8  
fWow =  fst ("Wow", False)  
-- "Wow"  

s11 = snd (8,11)  
-- 11  
sFalse = snd ("Wow", False)  
-- False  



zip1 = zip [1,2,3,4,5] [5,5,5,5,5]  
-- [(1,5),(2,5),(3,5),(4,5),(5,5)]  
zip2 =  zip [1 .. 5] ["one", "two", "three", "four", "five"]  
-- [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]  

zip_different_num = zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"]  
-- [(5,"im"),(3,"a"),(2,"turtle")]  
zip_cut = zip [1..] ["apple", "orange", "cherry", "mango"]  
-- [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]  



triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10] ]   
rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]  
rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]-- ghci> rightTriangles'  
-- [(6,8,10)]  

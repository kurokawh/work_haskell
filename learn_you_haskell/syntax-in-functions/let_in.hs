i42 = 4 * (let a = 9 in a + 1) + 2
local_scope = [let square x = x * x in (square 5, square 3, square 2)]
columns = (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)



calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]  

calcBmis_onlyfat :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis_onlyfat xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]  


zoot x y z = x * y + z  
-- zoot 3 9 2  
-- 29  
-- let boot x y z = x * y + z in boot 3 4 2
-- 14  

put_together = [1,2,3,4] ++ [9,10,11,12]
--putStrLn put_together

added = 1:[2,3,4]
-- [1,2,3,4]

h = head [5,4,3,2,1]
-- 5

t = tail [5,4,3,2,1]
-- [4,3,2,1]

l = tail [5,4,3,2,1]
-- 1

i = init [5,4,3,2,1]
-- [5,4,3,2]

len = length [5,4,3,2,1]
-- 5

notNull = null [1,2,3]
-- False
n = null []
-- True

r = reverse [5,4,3,2,1]
-- [1,2,3,4,5]

t2 = take 2 [5,4,3,2,1]
-- [5,4]
d2 = drop 2 [5,4,3,2,1]
-- [3,2,1]


-- maximum, minimum, sum, product
mmm = sum [5,4,3,2,1]

has3 = 3 `elem` [5,4,3,2,1]
-- True

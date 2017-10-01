
xs = [0..10]
p x = even x
--ys = [0,2..]

mkYs :: Integer -> [Integer]
mkYs x
  | odd x     = [1..]
  | otherwise = [0]

-- stop at 10
l1 = [(x,y) | x <- xs, p x, y <- mkYs x]
-- infinit loop
l2 = [(x,y) | x <- xs, y <- mkYs x, p x]



ll1 = [(x,y) | x <- [1..3], const False x, y <- [1..]]
-- infinit loop!
ll2 = [(x,y) | x <- [1..3], y <- [1..], const False x]

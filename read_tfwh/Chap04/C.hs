
-- ascend list -> ascend list -> is there shared value ?
disjoint :: (Ord a) => [a] -> [a] -> Bool
disjoint [] _ = False
disjoint _ [] = False
disjoint (x:xs) (y:ys)
  | x == y = True
  | x > y  = disjoint xs (y:ys)
  | x < y  = disjoint (x:xs) ys
  | otherwise = False


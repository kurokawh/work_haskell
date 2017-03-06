-- xx :: ((->) [Int]) Int 
-- is same as
-- xx ::  [Int] -> Int

countOdd :: ((->) [Int]) Int
countOdd = length . filter odd

countEven :: ((->) [Int]) Int
countEven = length . filter even

countAll :: ((->) [Int]) Int
countAll = do
  odds  <- countOdd
  evens <- countEven
  return (odds + evens)


-- imple without monad
countAllX :: [Int] -> Int
countAllX xs = countOdd xs + countEven xs

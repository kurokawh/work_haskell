import Control.Monad

-- polymorphism of context.
-- define action with abstracting which monado to use.
-- then decide it when actually action is applyed.
-- e.g. list all resut by List Monad or obtain only first result by Maybe Monad


filterPrimeM :: MonadPlus m => Integer -> m Integer
filterPrimeM n
  | n < 2 = mzero
  | and [ n `mod` x /= 0 | x <- [2..n-1] ] = return n
  | otherwise = mzero


searchPrime :: MonadPlus m => [Integer] -> m Integer
searchPrime = foldr (mplus . filterPrimeM) mzero

--
-- *Main> searchPrime [1..99] :: [Integer]
-- [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
--
-- *Main> searchPrime [1..99] :: Maybe Integer
-- Just 2
--

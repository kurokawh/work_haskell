import Control.Monad
import Debug.Trace

--sqrt2 :: (Floating a, Ord a) => a -> a
sqrt2 :: Float -> Float
sqrt2 x = until goodEnough improve 1
  where
--    goodEnough y = abs (y^^(2::Int) - x) <= eps * x
    goodEnough y = abs ((join traceShow y)^^(2::Int) - x) <= eps * x
    improve y = (y + x / y) / 2
    eps = 10^^(-6)


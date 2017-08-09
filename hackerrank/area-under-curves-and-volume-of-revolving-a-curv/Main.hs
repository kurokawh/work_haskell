-- https://www.hackerrank.com/challenges/area-under-curves-and-volume-of-revolving-a-curv
{-
NOTE: runtime error occurs with (^) if b is not Integral.
Prelude> :t (^)
(^) :: (Integral b, Num a) => a -> b -> a
Prelude> :t (^^)
(^^) :: (Fractional a, Integral b) => a -> b -> a
Prelude> :t (**)
(**) :: Floating a => a -> a -> a
Prelude> :i Double
-}


import Text.Printf (printf)

diff :: Double
diff = 0.001

fwrap :: [(Int, Int)] -> (Double, Double) -> Double -> (Double, Double)
fwrap array accum x = ((fst accum) + (y * diff), (snd accum) + (pi * y ** 2) * diff)
  where
    y = (f array x)

f :: [(Int, Int)] -> Double -> Double
f (s:xs) x = (fromIntegral $ fst s) * (x ** (fromIntegral $ snd s)) + (f xs x)
f [] _ = 0

range :: Int -> Int -> [Double]
range l r = [x | x <-[dl, (dl + diff) .. dr]]
    where
        dl = fromIntegral l
        dr = fromIntegral r

ab :: [Int] -> [Int] -> [(Int, Int)]
ab (a:ax) (b:bx) = (a,b) : (ab ax bx)
ab [] _ = []

-- This function should return a list [area, volume].
solve :: Int -> Int -> [Int] -> [Int] -> [Double]
solve l r a b = fst tpl : snd tpl : []
  where
    tpl = foldl  (fwrap (ab a b)) (0.0,0.0) (range l r)

--Input/Output.
main :: IO ()
main = getContents >>= mapM_ (printf "%.1f\n"). (\[a, b, [l, r]] -> solve l r a b). map (map read. words). lines

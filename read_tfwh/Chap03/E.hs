isqrt :: Float -> Integer
isqrt x = fst (until unit (shrink x) (bound x))
  where
    unit (m, n) = m + 1 == n
--    unit (m, n) = fromInteger(m * m) <= x && fromInteger(n * n) < x --XXX


type Interval = (Integer, Integer)

shrink :: Float -> Interval -> Interval
shrink x (m, n) = if (fromInteger (p*p)) <= x then (p, n) else (m, p)
  where
    p = choose (m, n)

choose :: Interval -> Integer
choose (m, n) = (m + n) `div` 2

bound :: Float -> Interval
--bound x = (1, floor x) --- XXX
bound x = (0, until above (* 2) 1)
  where
    above n = x < fromInteger (n * n)
    


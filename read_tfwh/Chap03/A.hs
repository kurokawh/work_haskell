
xx :: (Fractional a, Integral b) => a -> b -> a
xx x y
  | y >= 0 = 1
  | y < 0 = x


xxx :: (Fractional a, Integral b) => a -> b -> a
xxx m n
  | n == 0 = 1
  | n < 0 = (m ^^ (n + 1)) / m
  | otherwise = m * (m ^^ (n - 1))


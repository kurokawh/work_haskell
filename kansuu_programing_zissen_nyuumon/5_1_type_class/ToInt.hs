data A = A
data B = B

class ToInt a where
  toInt :: a -> Int



instance ToInt A where
  toInt _ = 1

instance ToInt B where
  toInt _ = 2


add :: ToInt a => a -> a -> Int
add x y = toInt x + toInt y


add2 :: (ToInt a, ToInt b) => a -> b -> Int
add2 x y = toInt x + toInt y


a1 = A
a2 = A
b1 = B
b2 = B

ok1 = add a1 a1
ok2 = add b1 b1
--ng1 = add a1 b1 -- NG
ok3 = add2 a1 b1 -- OK!

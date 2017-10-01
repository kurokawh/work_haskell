div2 :: Integral a => a -> a -> a
div2 x y = floor (fromIntegral x / fromIntegral y)


-- ok if RadFrac
div3 :: (Integral b, RealFrac a) => a -> a -> b
div3 x y = floor (x / y)

--xy :: Integral a => a -> a -> a
--xy x y = x / y


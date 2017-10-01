floor2 :: Float -> Integer
floor2 = read . takeWhile (/= '.') . show

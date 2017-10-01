type CIN = String

getDigit :: Char -> Int
getDigit c = read [c]

addSum :: CIN -> CIN
addSum cin = cin ++ show (n `div` 10) ++ show (n `mod` 10)
  where
    n = sum (map getDigit cin)

valid :: CIN -> Bool
valid cin = cin == addSum (take 8 cin)

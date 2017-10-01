
rama :: [(Integer, Integer, Integer, Integer, Integer)]
rama = [(a,b,c,d,r)
       | e <- [28 ..],
         a <- takeWhile ((< e).(^3)) [3 :: Integer .. ],
         c <- [2 .. a-1],
         d <- [2 .. c],
         b <- [1 .. d-1],
         a^3+b^3 == c^3+d^3,
         let r = a^3+b^3]

--- SLOW
rama2 :: [(Integer, Integer, Integer, Integer, Integer)]
rama2 = [(a,b,c,d,e)
       | e <- [28 ..],
         a <- takeWhile ((< e).(^3)) [3 :: Integer .. ],
         c <- [2 .. a-1],
         d <- [2 .. c],
         b <- [1 .. d-1],
         e == a^3+b^3  && e == c^3+d^3]

-- answer in book
rama3 :: Integer -> [(Integer, Integer, Integer, Integer, Integer)]
rama3 n = [(a,b,c,d, r)
       | a <- [1 .. n],
         b <- [a+1 .. n],
         c <- [a+1 .. n],
         d <- [c .. n],
         a^3+b^3 == c^3+d^3,
         let r = a^3+b^3]


rama4 :: [(Integer, Integer, Integer, Integer, Integer)]
rama4 = [(a,b,c,d, r)
       | n <- [1 .. ],
         a <- [1 .. n],
         b <- [a+1 .. n],
         c <- [a+1 .. n],
         d <- [c .. n],
         a^3+b^3 == c^3+d^3,
         let r = a^3+b^3]

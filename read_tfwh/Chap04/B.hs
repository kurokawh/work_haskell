allPairs = [(x,y) | x <- [0..], y <- [0..]]
-- x is always 0 because y is unlimitted.
-- this is wrong.


-- correct version:
-- cap with sum
allPairs2 = [(x,y) | z <- [0..], x <- [0..z], let y = z - x]

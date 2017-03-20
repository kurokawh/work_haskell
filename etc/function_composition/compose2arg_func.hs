{--
http://qiita.com/etoilevi/items/abd6c0063eae11a43237

*Main> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c

*Main> :t (++)
(++) :: [a] -> [a] -> [a]
*Main> :t reverse
reverse :: [a] -> [a]


-- OK
*Main> :t (reverse .) . (++)
(reverse .) . (++) :: [a] -> [a] -> [a]


-- NG
*Main> :t reverse . (++)

<interactive>:1:11: error:
    • Couldn't match type ‘[a1] -> [a1]’ with ‘[a]’
      Expected type: [a1] -> [a]
        Actual type: [a1] -> [a1] -> [a1]
    • Probable cause: ‘(++)’ is applied to too few arguments
      In the second argument of ‘(.)’, namely ‘(++)’
      In the expression: reverse . (++)

--}

composed :: [a] -> [a] -> [a]
composed x y = reverse $ (++) x y



data X = X
data Y = Y
data Z = Z
data A = A
data B = B

g1 :: A -> X
g1 = undefined

h :: X -> Y
h = undefined

f :: A -> Y
f = h.g1

-- 2 args =>
g2 :: A -> B -> X
g2 = undefined

f2 :: A -> B -> Y
f2 = (h.).g2

--f2err = h.g2
{--
note this is error !!!
    Couldn't match type ‘B -> X’ with ‘X’
    Expected type: A -> X
      Actual type: A -> B -> X
    Probable cause: ‘g2’ is applied to too few arguments
    In the second argument of ‘(.)’, namely ‘g2’
    In the expression: h . g2
--}


hdot :: (a -> X) -> a -> Y
hdot = (h.)

f2' :: A -> B -> Y
f2' = hdot.g2
-- (.) hdot g2
-- (.) ((a -> X) -> a -> Y) (A -> B -> X)  -- hdot & g2


-- (.) (((A -> B) -> X) -> ((A -> B) -> Y)) (A -> B -> X)  -- replace "a" with (A->B)
-- (.) (((A -> B) -> X) -> ((A -> B) -> Y)) ((A -> B) -> X)  -- regard g2 as a -> X
-- (((A -> B) -> X) -> ((A -> B) -> Y)) -> ((A -> B) -> X) -> (A -> B)

-- (.) :: (b -> c) -> (a -> b) -> a -> c

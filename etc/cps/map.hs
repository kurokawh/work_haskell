-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps
-- おまけ(3)

-- オリジナル
my_map _ [] = []
my_map f (x:xs) = (f x) : (map f xs)

-- let
my_map2 _ [] = []
my_map2 f (x:xs) = 
    let y = f x
        ys = my_map2 f xs
    in y:ys

-- CPS
--cps_map :: (a -> b) -> [a] -> ([b] -> [b]) -> [b]
cps_map _ [] cont = cont []
cps_map f (x:xs) cont =
--    let y = f x
--    in cps_map f xs (cont (\ys -> (y : ys)))
--    cps_map f xs (cont (\ys -> ((f x) : ys)))
    cont (cps_map f xs (\ys -> ((f x) : ys)))

{- ???
> cps_map ((+) 1) [1,2,3] id
> cps_map ((+) 1) [2,3] (id (\fs -> 2 : ys))
-}

-- another answer:
-- http://stackoverflow.com/questions/16682704/haskell-cps-how-to-implement-map-and-filter-functions-using-cont-monad
cpsMap :: (a -> b) -> [a] -> ([b] -> r) -> r
cpsMap f (a:as) c = cpsMap f as (c.(f a:))
cpsMap  _ []    c = c []

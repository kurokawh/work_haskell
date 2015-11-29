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

-- CPS (for map)
--cps_map :: (a -> b) -> [a] -> ([b] -> [b]) -> [b]
cps_map _ [] cont = cont []
cps_map f (x:xs) cont =
    cps_map f xs (cont . (\ys -> ((f x) : ys)))
-- NOTE: following impl does not work (compile error). need "." operator.
--    cps_map f xs (cont (\ys -> ((f x) : ys)))

-- another answer:
-- http://stackoverflow.com/questions/16682704/haskell-cps-how-to-implement-map-and-filter-functions-using-cont-monad
cpsMap :: (a -> b) -> [a] -> ([b] -> r) -> r
cpsMap f (a:as) c = cpsMap f as (c.(f a:))
cpsMap  _ []    c = c []



-- CPS for f (not work???)
cps_map2 _ [] cont = cont []
cps_map2 f (x:xs) cont =
    f x (\y -> cps_map2 f xs (cont . (\ys -> y:ys)))

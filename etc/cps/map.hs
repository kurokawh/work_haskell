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
cps_map _ [] cont = cont []
cps_map f (x:xs) cont = 
    -- let y = f x
    -- in cps_map f xs (\ys -> (y : ys))
    cps_map f xs (\ys -> (f x) : ys)

{- ???
> cps_map ((+) 1) [1,2] id
[3]
-}

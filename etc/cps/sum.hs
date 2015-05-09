-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps
-- おまけ

-- オリジナル
my_sum [] = 0
my_sum (x:xs) = x + (my_sum xs)

-- letで書き換え
my_sum2 [] = 0
my_sum2 (x:xs) = 
    let pre = my_sum xs
    in x + pre

-- CPS!
cps_sum [] cont = cont 0 -- NOTE "cont" is needed
cps_sum (x:xs) cont = cps_sum xs (\y -> cont (x + y))

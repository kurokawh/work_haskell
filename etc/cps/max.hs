-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps
-- おまけ(2)

-- オリジナル
my_max [x] = x
my_max (x:xs) =
    let pre = my_max xs
    in if pre < x
       then
           x
       else
           pre

-- CPS!
cps_max [x] cont = cont x
cps_max (x:xs) cont = 
    cps_max xs (\pre ->
                if pre < x
                then
                    cont x
                else
                    cont pre)
                             

-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps
-- おまけ(3)

-- オリジナル
my_find _ [] = error "not found"
my_find pred (x:xs) = 
    if pred x
    then
        x
    else
        my_find pred xs

-- letで書き換え
my_find2 _ [] = error "not found"
my_find2 pred (x:xs) = 
    if pred x
    then
        x
    else
        let res = my_find2 pred xs
        in res

-- CPS
cps_find _ [] cont = error "not found"
cps_find pred (x:xs) cont = 
    if pred x
    then
        cont x
    else
        -- cps_find pred xs (\res -> res)
        cps_find pred xs cont -- (\res -> res) is same as cont

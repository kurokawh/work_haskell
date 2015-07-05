-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps
-- おまけ: フィボナッチ関数をCPS変換

my_fib n
    | n == 0 = 1
    | n == 1 = 1
    | otherwise = my_fib (n - 1) + my_fib (n - 2)

-- letで書き換え
my_fib2 0 = 1
my_fib2 1 = 1
my_fib2 n =
    let pre1 = my_fib2 (n - 1)
        pre2 = my_fib2 (n - 2)
    in pre1 + pre2

-- my_fib 5
-- = (my_fib 4) + (my_fib 3)
-- = ((my_fib 3) + (my_fib 2)) + ((my_fib 2) + (my_fib 1))
-- = (((my_fib 2) + (my_fib 1)) + ((my_fib 1) + (my_fib 0)))
--   + (((my_fib 1) + (my_fib 0)) + (1))
-- = ((((my_fib 1) + (my_fib 0)) + (1)) + (1 + 1))
--   + ((1 + 1) + 1)


-- my_fib 3
-- = (my_fib 2) + (my_fib 1)
-- = ((my_fib 1) + (my_fib 0)) + (1)

-- my_fib 2
-- = (my_fib 1) + (my_fib 0)
-- = 1 + 1

-- CPS!
-- e.g. > cps_fib 5 id
cps_fib 0 cont = cont 1
cps_fib 1 cont = cont 1
cps_fib n cont = --undefined
    cps_fib (n - 1) (\pre1 -> cps_fib (n - 2) (\pre2 -> cont (pre2 + pre1)))

-- C.F.
-- http://jutememo.blogspot.jp/2011/05/haskell-cps.html


-- cps_fib 2 id
-- = (cps_fib 1 id) + (cps_fib 0 id)
-- = (id 1) + (id 0)

-- cps_fib 5 id
-- = (cps_fib 4 id) + (cps_fib 3 id)
-- = (cps_fib 4 id) + (cps_fib 3 id)

-- 再帰関数のスタックオーバーフローを倒す話 その1
-- http://bleis-tift.hatenablog.com/entry/cps

-- 末尾再帰ではないfactの定義
fact n
    | n == 0 = 1
    | otherwise = n * (fact (n - 1))

-- letを使った形にするとCPS変換しやすくなるので、慣れないうちは
-- まずはletを使った形に変形するところから始めるといいでしょう。
-- 変換途中 --
fact2 n {-cont-} = 
    if n == 0
    then 
        1
    else
        let pre = fact2 (n -1)
        in n * pre

-- contは継続なので、fact'の処理の結果を渡してあげることでfact'の後ろの処理を実行します。
-- CPS変換された関数から値を取り出すには、継続に渡された結果をそのまま返せばいいということになります。
-- これは、継続としてid関数を渡せばいい、ということですね。
-- fact_cps 10 (\x -> x)
-- OR 
-- fact_cps 10 id
fact_cps n cont =
    if n == 0
    then 
        cont 1
    else
        fact_cps (n - 1) (\x -> cont (n * x))

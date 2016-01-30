{- Printf.hs -}
module Printf where

-- printfの枠組。論文より。
-- 使うモジュールとは別の場所で定義されていなければなら
-- ない。

-- Template Haskellの構文をインポートする
import Language.Haskell.TH

-- 書式文字列を記述する
data Format = D | S | L String

-- 書式文字列をパースする。ここでの目的は我々の最初の
-- Template Haskellのプログラムを組み上げることであり、
-- printfを組むことではないので、大部分未実装のまま残し
-- てある。
parse :: String -> [Format]
parse s   = [ L s ]

-- パースされた書式文字列の表現からHaskellのソースコー
-- ドを生成する。生成されたコードは、「pr」を呼んだモジ
-- ュールにコンパイル時に接合される。
gen :: [Format] -> Q Exp
gen [D]   = [| \n -> show n |]
gen [S]   = [| \s -> s |]
gen [L s] = stringE s

-- 入力の書式文字列から、接合するHaskellコードを生成する。
pr :: String -> Q Exp
pr s = gen (parse s)

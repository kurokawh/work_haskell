{- Main.hs -}
module Main where

-- 後で定義する「pr」というテンプレートをインポートする。
import Printf ( pr )

-- 接合演算子$は、prによってコンパイル時に生成された
-- Haskellのソースコードをとり、これをputStrLnの引数とし
-- て接合する。
main = putStrLn ( $(pr "Hello") )

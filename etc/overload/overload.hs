-- Haskellで関数のオーバーロード
-- http://qiita.com/7shi/items/17a1567a635af17fc83f

{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE IncoherentInstances  #-}

class Foo a where
    foo :: a -> String

instance (Num a, Eq a) => Foo a where
    foo 1 = "bar"
    foo _ = "?"

instance Foo String where
    foo "1" = "baz"
    foo _   = "?"

main = do
    putStrLn $ foo 1
    putStrLn $ foo "1"

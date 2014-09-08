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


{-
/**
 * overload sample of C++
 */
#include <iostream>
#include <string>

using namespace std;

string foo(int i) {
    if (i == 1) return "bar";
    return "?";
}

string foo(const string &s) {
    if (s == "1") return "baz";
    return "?";
}

int main() {
    cout << foo(1) << endl;
    cout << foo("1") << endl;
}
-}

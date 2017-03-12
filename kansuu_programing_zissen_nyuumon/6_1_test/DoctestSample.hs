module DoctestSample where

-- | count the number of spaces in a string.
--
-- >>> countSpace ""
-- 0
-- >>> countSpace "abcdefg"
-- 0
-- >>> countSpace "Hello, World!"
-- 1
-- >>> countSpace "    "
-- 4
--
-- xxx: prop> countSpace s == sum [ 1 | c <- s, c == ' ' ]
-- xxx: QuickCheck condition: not work on windows ?
-- 
countSpace :: String -> Int
countSpace = length . filter (' ' ==)

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
countSpace :: String -> Int
countSpace = length . filter (' ' ==)

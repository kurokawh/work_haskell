import Data.Char


filter' :: String -> String
filter' s = filter isAlpha s

palindrome :: String -> String
palindrome = reverse . map toLower . filter'
-- following is NG! (add param)
-- palindrome str = reverse . map toLower . filter' str
-- need parenthis
palindrome2 str = (reverse . map toLower . filter') str

isPalindrome :: String -> Bool
isPalindrome s = map toLower s == palindrome s

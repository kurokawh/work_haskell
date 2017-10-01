import Data.Char (toLower)
import Data.List (sort,sortBy,group)
import Data.Ord (comparing)
import Prelude hiding (Word)

-- |
-- テキストの型
--
type Text = [Char]
-- |
-- 単語の型
--
type Word = [Char]


-- commonWords n = unlines      -- 連結する
--               . map showRun  -- 単語と出現回数をを表示する文字列を生成する
--               . take n       -- 上位 n 個を取り出す
--               . sortRuns     -- 出現回数順でソートする
--               . countRuns    -- 出現回数を数えて単語と出現回数を対にする
--               . sortWords    -- 単語をソートする
--               . words        -- テキストを単語に分解
--               . map toLower  -- テキストの文字をすべて小文字にする

-- anagram (sorted word)
type Anagram = [Char]

--type Run = (Int, Anagram, [Word])

anagrams :: Int -> [Word] -> String
anagrams n = showAnagrams -- String
           . countAnagram -- [(Anagram, [Word])
           . sortByAnagram --  [(Anagram, Word)]
           . (map convertToAnagram) -- [(Anagram, Word)]
           . filterByWordLength n -- filter by word length

{-
anagramsNG = showAnagrams -- String
           . countAnagram -- [(Anagram, [Word])
           . sortByAnagram --  [(Anagram, Word)]
           . (map convertToAnagram) -- [(Anagram, Word)]
           . filterByWordLength -- filter by word length

*Main> :t showAnagrams.countAnagram.sortByAnagram.(map convertToAnagram)
showAnagrams.countAnagram.sortByAnagram.(map convertToAnagram) :: [Word] -> String

*Main> :t filterByWordLength
filterByWordLength :: Int -> [Word] -> [Word]

*Main> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c

*Main> :t ((showAnagrams.countAnagram.sortByAnagram.(map convertToAnagram)).).filterByWordLength
((showAnagrams.countAnagram.sortByAnagram.(map convertToAnagram)).).filterByWordLength
  :: Int -> [Word] -> String

-}

filterByWordLength :: Int -> [Word] -> [Word]
filterByWordLength = undefined

convertToAnagram :: Word -> (Anagram, Word)
convertToAnagram = undefined

sortByAnagram :: [(Anagram, Word)] -> [(Anagram, Word)]
sortByAnagram = undefined

countAnagram :: [(Anagram, Word)] -> [(Anagram, [Word])]
countAnagram = undefined

showAnagrams :: [(Anagram, [Word])] -> String
showAnagrams = undefined

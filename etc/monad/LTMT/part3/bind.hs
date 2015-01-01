{-
LTMT Part 3: The Monad Cookbook
http://softwaresimply.blogspot.jp/2014/12/ltmt-part-3-monad-cookbook.html
-}

import System.Environment
main :: IO ()
main = do
    [from,to] <- getArgs
    writeFile to =<< readFile from

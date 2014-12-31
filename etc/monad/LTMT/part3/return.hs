{-
LTMT Part 3: The Monad Cookbook
http://softwaresimply.blogspot.jp/2014/12/ltmt-part-3-monad-cookbook.html
-}
import Control.Monad
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    output <- case args of
                [] -> "cat: must specify some files"
                fs -> liftM concat (mapM readFile fs)
    putStrLn output

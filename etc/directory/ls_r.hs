import System.Environment   
import System.Directory
--import Data.List

-- iterate all entries in given dir
-- if file, show info
-- if dir, call iterate_dir recursively.
iterate_dir dir = do
  putStrLn ("[d]: " ++ dir)
  entries <- getDirectoryContents dir
  putStrLn $ show entries
  -- XXX: not implemented yet.
  return ()
  
--main :: IO ()
main = do
    putStrLn "start"
    (dir:xs) <- getArgs
    iterate_dir dir

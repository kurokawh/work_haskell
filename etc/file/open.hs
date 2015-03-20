import System.Environment   
import System.IO

import qualified Data.Vector as V

test_open :: String -> IO (V.Vector a)
test_open file = do
  putStrLn "test_open"
  handle <- openFile file ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle
  error ""

-- following error returns as explected if file is not existed.
-- open.hs xxx: openFile: does not exist (No such file or directory)
main = do
  (file:xs) <- getArgs
  test_open file
  putStrLn "main"
  handle <- openFile file ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

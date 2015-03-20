import System.Environment   
import System.IO

-- following error returns as explected if file is not existed.
-- open.hs xxx: openFile: does not exist (No such file or directory)
main = do
  (file:xs) <- getArgs
  handle <- openFile file ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

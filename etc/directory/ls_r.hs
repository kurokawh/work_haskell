import System.Environment   
import System.Directory
--import Data.List

import System.FilePath

{-
#ifdef mingw32_HOST_OS
import System.FilePath.Windows
#else
import System.FilePath.Posix
#endif
-}

-- iterate all entries in given dir
-- if file, show info
-- if dir, call iterate_dir recursively.
iterate_dir :: [Char] -> IO ()
iterate_dir dir = do
  putStrLn ("[d]: " ++ dir)
  entries <- getDirectoryContents dir
  putStrLn $ show entries
  -- XXX: not implemented yet.
  return ()


gives :: [Char]
gives = "/root/directory/xxx.file.ext"

sample = do
    -- sample of FilePath usage --
    putStrLn ("gives: " ++ gives)
    putStrLn ("takeFileName gives: " ++ (takeFileName gives))
    putStrLn ("takeDirectory gives: " ++ (takeDirectory gives))
    putStrLn ("takeDirectory $ takeFileName gives: " ++ (takeDirectory $ takeFileName gives))
    putStrLn ("takeExtension gives: " ++ (takeExtension gives))
    putStrLn ("dropExtension gives: " ++ (dropExtension gives))
    putStrLn ("takeBaseName gives: " ++ (takeBaseName gives))
    putStrLn ("pathSeparator: " ++ (pathSeparator:[]))
    putStrLn ("pathSeparators: " ++ (show pathSeparators))
    putStrLn ("searchPathSeparator: " ++ (searchPathSeparator:[]))
    
--main :: IO ()
main = do
    putStrLn "start"
    sample
    (dir:xs) <- getArgs
    iterate_dir dir
    

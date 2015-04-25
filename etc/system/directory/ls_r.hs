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
-- if dir, call operate_dir recursively.
operate_dir :: FilePath -> IO ([String])
operate_dir dir = do
  putStrLn $ "operate_dir dir: " ++ dir
  if (takeFileName dir) == ".." then do
    putStrLn "\tskip"
    return [] -- skip parent dir
  else do
    putStrLn ("[d]: " ++ dir)
    entries <- getDirectoryContents dir
    putStrLn $ "\toperate_dir: entries: " ++ (show entries)
    filell <- mapM (operate_abspath.((</>) dir))  entries
    putStrLn $ "\toperate_dir: fll: " ++ show filell
    return $ concat filell

operate_file :: FilePath -> IO ([String])
operate_file file = do
  putStrLn $ "operate_file file: " ++ file
  if (takeFileName file) == "." then do
    putStrLn "\tskip"
    return [] -- skip current dir
  else do
    putStrLn ("[f]: " ++ file)
    return [file]

operate_file_or_dir :: FilePath -> IO ([String])
operate_file_or_dir entry = do
  isdir <- doesDirectoryExist entry
  if isdir then
    operate_dir entry
  else
    operate_file entry
      

operate_abspath :: FilePath -> IO ([String])
operate_abspath abspath
  | entry == ".." = return []
  | entry == "." = return []
  | otherwise = operate_file_or_dir abspath
  where
    entry = takeFileName abspath

-- def for sample --
gives :: FilePath
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
    operate_dir dir
    

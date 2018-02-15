import System.Directory
import System.FilePath

main = do
  putStrLn "start"
  path <- getHomeDirectory
  putStrLn path
  let file = path ++ (pathSeparator:[]) ++ ".emacs"
  putStrLn file

import System.Environment

main :: IO ()
main = do
  args <- getArgs
  putStrLn $ "num of args: " ++ (show $ length args)
  print args

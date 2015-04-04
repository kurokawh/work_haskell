import System.Environment
import Numeric

main = do
  (arg:xs) <- getArgs
  let i = read arg :: Int -- convert decimal string to int. Note "::Int" is needed
  let [(x,_)] = readHex arg -- convert from hex string to int
  putStrLn ("readInt: " ++ (show i))
  putStrLn ("readHex: " ++ (show x))
  return ()


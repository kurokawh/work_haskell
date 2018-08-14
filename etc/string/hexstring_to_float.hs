import System.Environment
import Numeric
import Unsafe.Coerce (unsafeCoerce)

hexToInt :: String -> Int
hexToInt str = x
  where [(x,_)] = readHex str


-- NG: 1.1347558e9 is returned for "43a30000" though 326 is expected.
hexToFloat :: String -> Float
hexToFloat str = x
  where [(x,_)] = readHex str


-- http://hackage.haskell.org/package/base-4.11.1.0/docs/Unsafe-Coerce.html
-- https://stackoverflow.com/questions/22847740/use-of-unsafecoerce
-- https://stackoverflow.com/questions/2269745/hex-representation-of-floats-in-haskell   <= compile error
-- OK: 326.0 is returned for "43a30000".
hexToFloat2 :: String -> Float
hexToFloat2 str = unsafeCoerce $ hexToInt str

main :: IO ()
main = do
  (arg:_) <- getArgs
  putStrLn ("input str: " ++ arg)
  putStrLn ("Int from Hex: " ++ (show $ hexToInt arg))
  putStrLn ("Float from Hex: " ++ (show $ hexToFloat arg))
  putStrLn ("Float from Hex (2): " ++ (show $ hexToFloat2 arg))
  return ()


{-# LANGUAGE FlexibleContexts #-}
import Data.Word (Word32, Word64)
import Data.Array.ST (newArray, readArray, MArray, STUArray)
import Data.Array.Unsafe (castSTUArray)
import GHC.ST (runST, ST)

import System.Environment (getArgs)
import Numeric (readHex)


wordToFloat :: Word32 -> Float
wordToFloat x = runST (cast x)

floatToWord :: Float -> Word32
floatToWord x = runST (cast x)

wordToDouble :: Word64 -> Double
wordToDouble x = runST (cast x)

doubleToWord :: Double -> Word64
doubleToWord x = runST (cast x)

{-# INLINE cast #-}
cast :: (MArray (STUArray s) a (ST s),
         MArray (STUArray s) b (ST s)) => a -> ST s b
cast x = newArray (0 :: Int, 0) x >>= castSTUArray >>= flip readArray 0

-- https://stackoverflow.com/questions/6976684/converting-ieee-754-floating-point-in-haskell-word32-64-to-and-from-haskell-float



--------- added by me
toWord32 :: String -> Word32
toWord32 string = fromIntegral (fst ((readHex string) !! 0))

main :: IO ()
main = do
  (arg:_) <- getArgs
  putStrLn ("input str: " ++ arg)
  putStrLn ("Word32: " ++ (show $ toWord32 arg))
  putStrLn ("wordToFloat: " ++ (show $ wordToFloat $ toWord32 arg))

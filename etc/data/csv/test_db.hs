{-# LANGUAGE ScopedTypeVariables #-}

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

data Salary = Salary {
      name :: String
    , salary :: Int
}     deriving Show


to_sal (x, y) = Salary x y

v2v v = V.map to_sal v

main :: IO ()
main = do
    csvData <- BL.readFile "no_header.csv"
    case decode NoHeader csvData of
        Left err -> putStrLn err
--        Right v -> putStrLn $ show ((V.!) (v2v v) 0) -- OK
        Right v -> putStrLn $ show (v2v v)

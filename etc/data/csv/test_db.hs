{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

data Salary = Salary {
      name :: String
    , salary :: Int
}     deriving Show


--to_sal :: (String, Int) -> Salary
to_sal (x, y) = Salary x y

v2v v = V.map to_sal v

main :: IO ()
main = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
--          V.mapM_ (putStrLn.show) (v2v v)
--          V.mapM_ (putStrLn.show) (v :: (V.Vector (String, Int)))
          V.mapM_ (putStrLn.show) (v :: (V.Vector (String, String)))
          putStrLn ""

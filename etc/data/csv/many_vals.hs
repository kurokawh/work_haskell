{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

--import Data.Csv.Incremental ( Parser(..) )
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)

data Salary = Salary {
      name :: String
    , salary :: Int
}     deriving Show

type Row20 = (String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String)

type Row9  = (String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String)

type Row11 = (String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String,
              String)
--              Record)
--              Parser v)

instance (FromField a, FromField b, FromField c, FromField d, FromField e,
          FromField f, FromField g, FromField h, FromField i, FromField j,
          FromField v) =>
--          Record v) =>
         FromRecord (a, b, c, d, e, f, g, h, i, j, v) where
    parseRecord v
        | n >= 10  = (,,,,,,,,,,) <$> unsafeIndex v 0
                                 <*> unsafeIndex v 1
                                 <*> unsafeIndex v 2
                                 <*> unsafeIndex v 3
                                 <*> unsafeIndex v 4
                                 <*> unsafeIndex v 5
                                 <*> unsafeIndex v 6
                                 <*> unsafeIndex v 7
                                 <*> unsafeIndex v 8
                                 <*> unsafeIndex v 9
                                 <*> unsafeIndex v 0
--                                 <*> v
--        | otherwise = lengthMismatch 10 v
--        | otherwise = (Fail "a" "b") --Done [Left "x"] 
          where
            n = V.length v

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
--          V.mapM_ (putStrLn.show) (v :: (V.Vector (String, String)))
          V.mapM_ (putStrLn.show) (v :: (V.Vector Row11))
--          V.mapM_ (putStrLn.show) (v :: (V.Vector Row9))
          putStrLn ""

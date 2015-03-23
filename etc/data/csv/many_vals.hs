{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

--import Data.Csv.Incremental ( Parser(..) )
import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)

-- return index val or return "" if index is too big.
--getval_or_empty :: Record -> Int -> String
getval_or_empty v i
    | i < V.length v = v .! i
    | otherwise      = return ""

data Salary = Salary {
      s1 :: String
    , s2 :: String
    , s3 :: String
    , s4 :: String
    , s5 :: String
    , s6 :: String
    , s7 :: String
    , s8 :: String
    , s9 :: String
    , s10 :: String
    , s11 :: String
    , s12 :: String
    , s13 :: String
    , s14 :: String
    , s15 :: String
}     deriving Show
instance FromRecord Salary where
    parseRecord v
--        | n <= 14 = return (Salary "" "" "" "" "" "" "" "" "" "" "" "" "" "" (getval_or_empty v 9))
        | n >= 15 = Salary <$>
--                          v .! 0 <*>
                          (getval_or_empty v 1) <*>  -- (v .! 1) for 100.
--                          (getval_or_empty v 100) <*>  -- "" for 100.
                          v .! 1 <*>
                          v .! 2 <*>
                          v .! 3 <*>
                          v .! 4 <*>
                          v .! 5 <*>
                          v .! 6 <*>
                          v .! 7 <*>
                          v .! 8 <*>
                          v .! 9 <*>
                          v .! 10 <*>
                          v .! 11 <*>
                          v .! 12 <*>
                          v .! 13 <*>
                          v .! 14
        | otherwise     = mzero
          where
            n = V.length v


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
          FromField k) =>
--          Record k) =>
         FromRecord (a, b, c, d, e, f, g, h, i, j, k) where
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
--                                 <*> k
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
--          V.mapM_ (putStrLn.show) (v :: (V.Vector Row11))
          V.mapM_ (putStrLn.show) (v :: (V.Vector Salary))
          putStrLn ""

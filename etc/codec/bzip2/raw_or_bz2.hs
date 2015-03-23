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



-- copied from etc/data/csv/many_vals.hs to parse raw csv or bzip2
main :: IO ()
main = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
          V.mapM_ (putStrLn.show) (v :: (V.Vector Salary))
          putStrLn ""

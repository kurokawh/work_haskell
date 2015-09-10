{-# LANGUAGE ScopedTypeVariables #-}

import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)
import qualified Data.ByteString.Lazy as BL
import System.Environment (getArgs)
import Data.Csv
import qualified Data.Vector as V


data Person = Person { 
      name :: !String, age :: !Int 
}  deriving (Eq, Ord, Show)

instance FromRecord Person where
    parseRecord v
        | V.length v == 2 = Person <$>
                          v .! 0 <*>
                          v .! 1
        | V.length v == 10 = Person <$>
                          v .! 0 <*>
                          v .! 1
        | V.length v == 20 = Person <$>
                          v .! 18 <*>
                          v .! 19
        | otherwise     = mzero

-- this program runs with:
-- > runghc person.hs no_header.csv
-- > runghc person.hs 10.csv
-- > runghc person.hs 20.csv
main :: IO ()
main = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
          V.mapM_ (putStrLn.show) (v :: (V.Vector Person))
          putStrLn ""

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
        | otherwise     = mzero

main :: IO ()
main = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
          V.mapM_ (putStrLn.show) (v :: (V.Vector Person))
          putStrLn ""

{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

--import Data.Csv.Incremental ( Parser(..) )
import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)

import Database.Persist
import Database.Persist.Sqlite
import Control.Monad.IO.Class (liftIO)
import YesodPerson
    

instance FromRecord Person where
    parseRecord v
        | n == 10 = Person <$>
                          v .! 0 <*>
                          v .! 1
        | n >= 11 = Person <$>
                          v .! 9 <*>
                          v .! 10
        | otherwise     = mzero
          where
            n = V.length v

file_to_vec :: String -> IO (V.Vector Person)
file_to_vec filename = do
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> return V.empty
        Right v -> return v
                
-- multiple argument (csv files) are supported
-- % runghc test_db.hs 10.csv x.csv y.csv ..
main :: IO ()
main = do
  args <- getArgs
  vlist <- mapM file_to_vec args
  runSqlite "x.db" $ do
         runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
         ids <- mapM (V.mapM insert) vlist
         liftIO $ print ids

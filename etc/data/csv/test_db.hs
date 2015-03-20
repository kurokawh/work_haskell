{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

--import Data.Csv.Incremental ( Parser(..) )
--import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)

import Database.Persist
import Database.Persist.Sqlite
import Control.Monad.IO.Class (liftIO)
import YesodPerson

import System.IO


file_to_vec :: String -> IO (V.Vector Person)
file_to_vec filename = do
    putStrLn "call openFile"
    h <- openFile filename ReadMode
    putStrLn "ret openFile"
    hClose h
    --putStrLn "ret hGetContents"
    putStrLn ("call ReadFile" ++ filename)
    csvData <- BL.readFile filename
    putStrLn "ret ReadFile"
    case decode NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return v
                
-- multiple argument (csv files) are supported
-- % runghc test_db.hs 10.csv x.csv y.csv ..
main :: IO ()
main = do
  putStrLn "start"
  args <- getArgs
  vlist <- mapM file_to_vec args
  runSqlite "x.db" $ do
         runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
         ids <- mapM (V.mapM insert) vlist
         liftIO $ print ids

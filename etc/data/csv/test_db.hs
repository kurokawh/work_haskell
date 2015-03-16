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


-- currently only following command is supported:
-- % runghc test_db.hs 10.csv
main1 :: IO ()
main1 = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> main2 v
--          V.mapM_ (putStrLn.show) (v :: (V.Vector Person))
--          putStrLn ""

-- copied from YesodPerson.hs.
main2 :: V.Vector Person -> IO ()
main2 v = runSqlite "test.db" $ do
    -- this line added: that's it!
    runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
    ids <- V.mapM insert v
    liftIO $ print ids


main :: IO ()
main = main1

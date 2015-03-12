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
    
data Salary = Salary {
      name :: String
    , salary :: Int
}     deriving Show


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

--to_sal :: (String, Int) -> Person
to_sal (x, y) = Person x y

v2v v = V.map to_sal v

-- currently only following command is supported:
-- % runghc test_db.hs 10.csv
main1 :: IO ()
main1 = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
          V.mapM_ (putStrLn.show) (v :: (V.Vector Person))
          putStrLn ""

-- copied from YesodPerson.hs.
main2 :: IO ()
main2 = runSqlite ":memory:" $ do
    -- this line added: that's it!
    runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
    michaelId <- insert $ Person "Michael" 26
    michael <- get michaelId
    liftIO $ print michael


main :: IO ()
main = main1

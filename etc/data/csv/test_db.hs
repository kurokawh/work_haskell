{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

--import Data.Csv.Incremental ( Parser(..) )
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

type Row10 = (String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String, 
              String)

{-                
instance (FromField a, FromField b, FromField c, FromField d, FromField e,
          FromField f, FromField g, FromField h, FromField i, FromField j) =>
         FromRecord (a, b, c, d, e, f, g, h, i, j) where
    parseRecord v
        | n == 10  = (,,,,,,,,,) <$> unsafeIndex v 0
                                 <*> unsafeIndex v 1
                                 <*> unsafeIndex v 2
                                 <*> unsafeIndex v 3
                                 <*> unsafeIndex v 4
                                 <*> unsafeIndex v 5
                                 <*> unsafeIndex v 6
                                 <*> unsafeIndex v 7
                                 <*> unsafeIndex v 8
                                 <*> unsafeIndex v 9
-}
instance FromRecord Salary where
    parseRecord v
        | V.length v == 10 = Salary <$>
                          v .! 0 <*>
                          v .! 1

--        | otherwise = lengthMismatch 10 v
--        | otherwise = (Fail "a" "b") --Done [Left "x"] 
          where
            n = V.length v

--to_sal :: (String, Int) -> Salary
to_sal (x, y) = Salary x y

v2v v = V.map to_sal v

-- currently only following command is supported:
-- % runghc test_db.hs 10.csv
main2 :: IO ()
main2 = do
    (filename:args) <- getArgs  
    csvData <- BL.readFile filename
    case decode NoHeader csvData of
        Left err -> putStrLn err
        Right v -> do
--          V.mapM_ (putStrLn.show) (v2v v)
--          V.mapM_ (putStrLn.show) (v :: (V.Vector (String, Int)))
--          V.mapM_ (putStrLn.show) (v :: (V.Vector (String, String)))
--          V.mapM_ (putStrLn.show) (v :: (V.Vector Row10))
          V.mapM_ (putStrLn.show) (v :: (V.Vector Salary))
--          V.mapM_ (putStrLn.show) (v :: (V.Vector Row9))
          putStrLn ""

-- copied from YesodPerson.hs.
main :: IO ()
main = runSqlite ":memory:" $ do
    -- this line added: that's it!
    runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
    michaelId <- insert $ Person "Michael" 26
    michael <- get michaelId
    liftIO $ print michael

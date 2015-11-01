{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE FlexibleInstances               #-}
{-# LANGUAGE TypeSynonymInstances            #-}
module YesodPerson
( Person(..)
, entityDefs
, entityKey
, entityDB
, parseRecord
) where
-- module yesod_person -- ERROR!!! module name must start with capital.

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.IO.Class (liftIO)
import Data.Time
    
import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)
import qualified Data.Vector as V
import Data.Csv

share [mkPersist sqlSettings, mkSave "entityDefs"] [persistLowerCase|
Person
    name String
    age Int
    deriving Show
|]

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
  
main :: IO ()
main = runSqlite ":memory:" $ do
    -- this line added: that's it!
    runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
    michaelId <- insert $ Person "Michael" 26
    michael <- get michaelId
    liftIO $ print michael
    Just just_michael <- get michaelId
    liftIO $ putStrLn ("personName: " ++ (personName just_michael))

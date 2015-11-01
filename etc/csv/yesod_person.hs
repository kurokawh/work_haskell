{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
module yesod_person -- ERROR!!! need to be YesodPerson
( Person
) where

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.IO.Class (liftIO)
import Data.Time

share [mkPersist sqlSettings, mkSave "entityDefs"] [persistLowerCase|
Person
    name String
    age Int
    deriving Show
|]

main :: IO ()
main = runSqlite ":memory:" $ do
    -- this line added: that's it!
    runMigration $ migrate entityDefs $ entityDef (Nothing :: Maybe Person)
    michaelId <- insert $ Person "Michael" 26
    michael <- get michaelId
    liftIO $ print michael

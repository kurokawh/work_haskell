{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import           Control.Monad.IO.Class  (liftIO)
import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH

import           Control.Monad.Logger (NoLoggingT)
import           Control.Monad.Trans.Resource.Internal (ResourceT)

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    firstName String
    lastName String
    age Int
    PersonName firstName lastName
    deriving Show
|]

fechingById :: SqlPersistT 
               (Control.Monad.Logger.NoLoggingT
                (Control.Monad.Trans.Resource.Internal.ResourceT IO))
               ()
fechingById = do
    personId <- insert $ Person "Michael2" "Snoyman2" 26
    maybePerson <- get personId
    case maybePerson of
      Nothing -> liftIO $ putStrLn "Just kidding, not really there"
      Just person -> liftIO $ print person

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    personId <- insert $ Person "Michael" "Snoyman" 26
    maybePerson <- get personId
    case maybePerson of
      Nothing -> liftIO $ putStrLn "Just kidding, not really there"
      Just person -> liftIO $ print person

    x <- fechingById
    return x

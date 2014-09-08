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

import           Control.Monad.Logger
import           Control.Monad.Trans.Resource.Internal

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    firstName String
    lastName String
    age Int
    UniqueName firstName lastName
    deriving Show
|]


{-
    case maybePerson of
      Nothing -> liftIO $ putStrLn "Just kidding, not really there"
      Just person -> liftIO $ print person
-}
printPerson :: Show a => Maybe a -> SqlPersistT 
               (Control.Monad.Logger.NoLoggingT
                           (Control.Monad.Trans.Resource.Internal.ResourceT IO))
               ()
printPerson Nothing = liftIO $ putStrLn "Just kidding, not really there"
printPerson (Just person) = liftIO $ print person

{-
    case maybePerson of
        Nothing -> liftIO $ putStrLn "Just kidding, not really there"
        Just (Entity personId person) -> liftIO $ print person
-}
printPersonE :: Show a => (Maybe (Entity a)) -> SqlPersistT 
                (Control.Monad.Logger.NoLoggingT
                            (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                ()
printPersonE Nothing = printPerson (Nothing :: Maybe (PersonGeneric SqlBackend))
printPersonE (Just (Entity _ person)) = liftIO $ print person


fetchingById :: SqlPersistT 
                (Control.Monad.Logger.NoLoggingT
                 (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                ()
fetchingById = do
    personId <- insert $ Person "Michael2" "Snoyman2" 26
    maybePerson <- get personId
    printPerson maybePerson

fetchingByUniqueConstraint :: SqlPersistT 
                              (Control.Monad.Logger.NoLoggingT
                               (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                              ()
fetchingByUniqueConstraint = do
    personId <- insert $ Person "Michael" "Snoyman" 26
    -- OK case
    maybePerson <- getBy $ UniqueName "Michael" "Snoyman"
    printPersonE maybePerson
    -- test Nothing
    notFoundPerson <- getBy $ UniqueName "Not-Found" "Name"
    printPersonE notFoundPerson

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    fetchingById
    fetchingByUniqueConstraint

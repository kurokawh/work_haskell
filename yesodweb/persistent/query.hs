{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE FlexibleInstances    #-}
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
class PersonPrinter a where
    printPerson :: (SqlPersistT 
                    (Control.Monad.Logger.NoLoggingT 
                     (Control.Monad.Trans.Resource.Internal.ResourceT IO)) b) => a -> b
-}
class PersonString a where
    printPerson :: a -> IO ()

{-
    case maybePerson of
      Nothing -> liftIO $ putStrLn "Just kidding, not really there"
      Just person -> liftIO $ print person
instance (Show a) => PersonPrinter (Maybe a) where
    printPerson Nothing = liftIO $ putStrLn "Just kidding, not really there"
    printPerson (Just person) = liftIO $ print person
-}
--instance (Show a) => PersonString (Maybe a) where
instance PersonString (Maybe (PersonGeneric SqlBackend)) where
    printPerson Nothing = putStrLn "Just kidding, not really there"
    printPerson (Just person) = print person
    

{-
    case maybePerson of
        Nothing -> liftIO $ putStrLn "Just kidding, not really there"
        Just (Entity personId person) -> liftIO $ print person
instance (Show a) => PersonPrinter (Maybe (Entity a)) where
    printPerson Nothing = printPerson (Nothing :: Maybe (PersonGeneric SqlBackend))
    printPerson (Just (Entity _ person)) = liftIO $ print person
-}
instance (Show a) => PersonString (Maybe (Entity a)) where
    printPerson Nothing = printPerson (Nothing :: Maybe (PersonGeneric SqlBackend))
    printPerson (Just (Entity _ person)) = print person

fetchingById :: SqlPersistT 
                (Control.Monad.Logger.NoLoggingT
                 (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                ()
fetchingById = do
    personId <- insert $ Person "Michael2" "Snoyman2" 26
    maybePerson <- get personId
    liftIO $ printPerson maybePerson

fetchingByUniqueConstraint :: SqlPersistT 
                              (Control.Monad.Logger.NoLoggingT
                               (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                              ()
fetchingByUniqueConstraint = do
    personId <- insert $ Person "Michael" "Snoyman" 26
    -- OK case
    maybePerson <- getBy $ UniqueName "Michael" "Snoyman"
    liftIO $ printPerson maybePerson
    -- test Nothing
    notFoundPerson <- getBy $ UniqueName "Not-Found" "Name"
    liftIO $ printPerson notFoundPerson

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    fetchingById
    fetchingByUniqueConstraint

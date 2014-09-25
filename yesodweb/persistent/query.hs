{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE FlexibleInstances #-}
import           Control.Monad.IO.Class  (liftIO)
import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH


share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    firstName String
    lastName String
    age Int
    UniqueName firstName lastName
    deriving Show
|]

-- type class to overload printPerson()
class PersonString a where
    printPerson :: a -> IO ()

-- printPerson() for get()
--instance (Show a) => PersonString (Maybe a) where  // error : cannot distinguish
instance PersonString (Maybe (PersonGeneric SqlBackend)) where
    printPerson Nothing = putStrLn "Just kidding, not really there"
    printPerson (Just person) = print person
    
-- printPerson() for getBy()
instance (Show a) => PersonString (Maybe (Entity a)) where
    printPerson Nothing = printPerson (Nothing :: Maybe (PersonGeneric SqlBackend))
    printPerson (Just (Entity _ person)) = print person

{-
fetchingById :: SqlPersistT 
                (Control.Monad.Logger.NoLoggingT
                 (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                ()
-}
fetchingById = do
    personId <- insert $ Person "Michael2" "Snoyman2" 27
    maybePerson <- get personId
    liftIO $ printPerson maybePerson

{-
fetchingByUniqueConstraint :: SqlPersistT 
                              (Control.Monad.Logger.NoLoggingT
                               (Control.Monad.Trans.Resource.Internal.ResourceT IO))
                              ()
-}
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

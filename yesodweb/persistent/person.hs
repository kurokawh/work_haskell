{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import Control.Monad.IO.Class  (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Gender

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int
    gender Gender -- Genderカラム（VARCHAR: Male or Female）
    Name name     -- nameカラムにUnique制約を付与
    deriving Show
|]

person_list = [(Person "Michael" 26 Male),
               (Person "Mark" 27 Male),
               (Person "Jhon" 55 Male),
               (Person "Cyndy" 25 Female),
               (Person "Amy" 30 Female),
               (Person "Linda" 19 Female),
               (Person "Steve" 41 Male),
               (Person "Dorothy" 37 Female),
               (Person "Robert" 40 Male),
               (Person "George" 15 Male)]

main_get = do
  -- success to refer Michael
  michael <- get (Key (PersistInt64 1) :: Key (PersonGeneric SqlBackend))
  liftIO $ print michael
  -- fail to get with id. Nothing is returned
  noone <- get (Key (PersistInt64 100) :: Key (PersonGeneric SqlBackend))
  liftIO $ print noone

--print_entity :: x -> IO ()
print_entity Nothing = do
  liftIO $ print "failed to obtain value..."
print_entity (Just (Entity key person)) = do
  liftIO $ print key
  liftIO $ print person

main_getBy = do
  -- success to refer Cyndy
  cyndy <- getBy $ Name "Cyndy"
  liftIO $ print cyndy
  print_entity cyndy
  -- fail to get with Name. Nothing is returned
  noone <- getBy $ Name "NotFoundName"
  liftIO $ print noone
  print_entity noone

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll
    ids <- mapM insert person_list
    liftIO $ print ids

    main_get
    main_getBy
    return ()

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

main :: IO ()
main = runSqlite "person.db" $ do
    runMigration migrateAll

    ids <- mapM insert person_list
    liftIO $ print ids
    michael <- get (ids !! 0)
    liftIO $ print michael
    return ()

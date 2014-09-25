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

--person_list = [1,2,3]
person_list = [(Person "Michael" 26 Male),
               (Person "Mark" 26 Male),
               (Person "Cyndy" 25 Female),
               (Person "Amy" 30 Female),
               (Person "Robert" 40 Male),
               (Person "George" 15 Male)]


main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    --michaelId <- insert $ Person "Michael" 26 Male
    michaelId <- insert $ (person_list !! 0)
    michael <- get michaelId
    liftIO $ print michael

    --let id_list = fmap insert person_list::[Person]
    --michael <- get (id_list !! 0)
    --liftIO $ print michael
    return ()

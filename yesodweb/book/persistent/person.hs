{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
import Control.Monad.IO.Class  (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Data.Conduit
import qualified Data.Conduit.List as CL
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
               (Person "Steve" 42 Male),
               (Person "Dorothy" 37 Female),
               (Person "Robert" 40 Male),
               (Person "George" 15 Male)]

main_get = do
  -- success to refer Michael
  michael <- get (PersonKey 1)
  liftIO $ print michael
  -- fail to get with id. Nothing is returned
  none <- get (PersonKey 100)
  liftIO $ print none

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


main_select = do
  -- 厄年（男性：25 or 52 or 62, 女性：19 or 33, 37）の人を検索し名前順で取得
  found <- selectList
           ( [PersonGender ==. Male, PersonAge <-. [25, 42, 61]]
             ||. [PersonGender ==. Female, PersonAge <-. [19, 33, 37]] )
           [ Asc PersonName ]
  -- 結果として得た Entity のリストを順に表示
  liftIO $ mapM print found

main_rawQuery = do
  -- 名前が"y"で終端するPersonを検索
  let sql = "SELECT name FROM Person WHERE name LIKE '%y'"
  rawQuery sql [] $$ CL.mapM_ (liftIO . print)
  return ()

{-
main_rawsql = do
  -- 名前が"y"で終端するPersonを検索
  let sql = "SELECT name FROM Person WHERE name LIKE '%y'"
  rawSql sql [] $$ CL.mapM_ (liftIO . print)
-}

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll
    ids <- mapM insert person_list
    liftIO $ print ids

    liftIO $ putStrLn "*** call main_get ***"
    main_get
    liftIO $ putStrLn "*** call main_getBy ***"
    main_getBy
    liftIO $ putStrLn "*** call main_selectt ***"
    main_select
    liftIO $ putStrLn "*** call main_rawQuery ***"
    main_rawQuery
--    liftIO $ putStrLn "*** call main_rawsql ***"
--    main_rawsql
    return ()

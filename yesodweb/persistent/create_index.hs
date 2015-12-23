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
import Database.Persist         -- persistentパッケージ
import Database.Persist.Sqlite  -- persistent-sqliteパッケージ
import Database.Persist.TH      -- persistent-templateパッケージ

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int Maybe
    deriving Show
|]

main :: IO ()
main = runSqlite "test.db" $ do
    -- personテーブル生成
    runMigration migrateAll
    -- nameカラムにindexを生成する。placeholderがないため第2引数は[]でよい。
    -- 2回目以降、すでにインデックスが存在している場合のためにIF NOE EXISTSが必要。
    rawExecute "CREATE INDEX IF NOT EXISTS idx_name_on_person ON person(name);" [] -- here!

    michaelId <- insert $ Person "Michael" $ Just 26
    michael <- get michaelId
    liftIO $ print michael

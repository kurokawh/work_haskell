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

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int Maybe
    address String  -- addressカラム（VARCHAR）を新たに追加
    Address address -- addressカラムをUNIQUE制約に（大文字はUNIQUE制約を意味する）
    deriving Show
|]

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    -- addressも引数に追加。bobのデータも登録してみる。
    michaelId <- insert $ Person "Michael" (Just 26) "1-2 xx Tokyo"
    bobId <- insert $ Person "Bob" (Just 29) "2-20 yyy Hokkaido"

    michael <- get michaelId
    liftIO $ print michael

    -- UNIQUE制約フィールドは getBy で SELECTがかけられる
    bob <- getBy $ Address "2-20 yyy Hokkaido"
    -- bog　の情報を表示。
    liftIO $ print bob

    -- UNIQUE制約に違反するレコード（Michaelと重複）を登録しようとするとエラーになる
    markId <- insert $ Person "Mark" (Just 29) "1-2 xx Tokyo"
    -- エラー出力：
    -- uniqueness: user error (SQLite3 returned ErrorConstraint while attempting to perform step.)
    mark <- get markId
    liftIO $ print mark

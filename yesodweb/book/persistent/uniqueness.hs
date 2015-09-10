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
    firstName String -- nameをfistNameと
    lastName String  -- lastNameに分解
    age Int Maybe
    address String  -- addressカラム（VARCHAR）を新たに追加
    Address address -- addressカラムをUNIQUE制約に（大文字はUNIQUE制約を意味する）
    PersonName firstName lastName -- firstName, lastNameの組合せをUNIQUE制約に
    deriving Show
|]

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll

    -- addressも引数に追加。bobのデータも登録してみる。
    let michaelAddress = "1-2 xx Tokyo"
    michaelId <- insert $ Person "Michael" "Snoyman" (Just 26) michaelAddress
    bobId <- insert $ Person "Bob" "Marley" (Just 29) "2-20 yyy Hokkaido"

    -- UNIQUE制約フィールドは getBy で SELECTがかけられる
    bob <- getBy $ Address "2-20 yyy Hokkaido"
    -- bog　の情報を表示。
    liftIO $ print bob

    -- PersonNameでもSELECTが可能。fistName, lastNameを渡してインスタンスを生成
    michael <- getBy $ PersonName "Michael" "Snoyman"
    liftIO $ print michael

    -- 登録されていないAddressでSELECTするとNothingが返される
    fail <- getBy $ Address "123-456 Fukuoka"
    liftIO $ print fail

    -- UNIQUE制約に違反するレコード（Michaelと重複）を登録しようとするとエラーになる
    markId <- insert $ Person "Mark" "Twain" (Just 29) michaelAddress
    -- エラー出力：
    -- uniqueness: user error (SQLite3 returned ErrorConstraint while attempting to perform step.)
    mark <- get markId
    liftIO $ print mark

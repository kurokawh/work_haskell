{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import Control.Monad.IO.Class  (liftIO)
import Database.Persist         -- persistentパッケージ
import Database.Persist.Sqlite  -- persistent-sqliteパッケージ
import Database.Persist.TH      -- persistent-templateパッケージ

-- mkPersist
--   mkPersist :: MkPersistSettings -> [EntityDef SqlType] -> Q [Dec]
--   データ型、PersistentEntityインスタンスを生成
-- sqlSettings
--   mkPersistの挙動を変える設定値
-- mkMigrate "migrateAll"
--   マイグレーション処理を定義
-- QuansiQuotes [xx|..|] でスキーマ定義。
--   persistentLowaCaseはテーブル名・フィールド名に、"_"区切り小文字を
--   利用することを指示している。
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person             -- personテーブル。プライマリキーとして"id"カラム自動生成。
    name String    -- nameカラム（VARCHAR, NOT NULL制約）
    age Int Maybe  -- ageカラム（INTEGER, MaybeはNULLを許容することを意味する）
    address String  -- addressカラム
    Address address -- addressカラムをUNIQUE制約に（大文字はUNIQUE制約を意味する）
    deriving Show
|]

main :: IO ()
main = runSqlite ":memory:" $ do -- DBオープン時の引数。メモリDB利用。"test.db"等の
                                 -- ファイル名を渡すとファイルDBがオープンされる。
    -- personテーブル生成
    runMigration migrateAll

    -- name: "Michael", age: 26 のレコードを INSERT
    -- id（プライマリキー）が返値として返される。
    michaelId <- insert $ Person "Michael" (Just 26) "1-2 xx Tokyo"
    bobId <- insert $ Person "Bob" (Just 29) "2-20 yyy Hokkaido"
    -- id でレコードを SELECT。該当レコードが返される。
    michael <- get michaelId
    -- 返されたレコード（Personインスタンス）を表示。
    liftIO $ print michael

    -- UNIQUE制約フィールドは getBy で SELECTがかけられる
    bob <- getBy $ Address "2-20 yyy Hokkaido"
    liftIO $ print bob

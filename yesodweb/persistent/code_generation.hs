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
Person             -- personテーブル
    name String    -- nameカラム（VARCHAR, NOT NULL制約）
    age Int Maybe  -- ageカラム（INTEGER, NULLあり）
    deriving Show
|]

main :: IO ()
main = runSqlite ":memory:" $ do -- DBオープン時の引数。メモリDB利用。"test.db"等の
                                 -- ファイル名を渡すとファイルDBがオープンされる。
    -- name: "Michael", age: 26 のレコードを INSERT
    -- id（row-id）が返値として返される。
    michaelId <- insert $ Person "Michael" $ Just 26
    -- row-id でレコードを SELECT。該当レコードが返される。
    michael <- get michaelId
    -- 返されたレコードを表示。
    liftIO $ print michael

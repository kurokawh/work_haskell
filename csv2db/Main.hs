{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import MyArgs

{-
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int
    gender Gender -- Genderカラム（VARCHAR: Male or Female）
    Name name     -- nameカラムにUnique制約を付与
    deriving Show
| ]
-}
mkPersist sqlSettings [persistLowerCase|
  Parent
      name  String maxlen=20
      name2 String maxlen=20
      age Int
      Primary name name2 age
      deriving Show Eq
  Child
      name  String maxlen=20
      name2 String maxlen=20
      age Int
      Foreign Parent fkparent name name2 age
      deriving Show Eq
|]


dispatch :: [(String, MyArgs -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]

to_sqlite args = do
  return ()

main = do
  args <- cmdArgs config
  let (Just register) = lookup (dbopt　args) dispatch
  -- print args
  register args

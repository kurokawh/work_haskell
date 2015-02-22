{-# LANGUAGE GADTs             #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.Console.CmdArgs
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Data.Text (pack)
import MyArgs

{-
 removed LANGUAGE opt:
   FlexibleContexts 
   OverloadedStrings 
   DeriveDataTypeable 
   EmptyDataDecls   
-}
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    serverTime String -- Int?
    consoleType Int
    systemVer Int
    productCode Int
    productSubCode Int
    idu Bool
    logConfVer String
    timestamp String -- Int?
    clockType Int
    ps4UniqueId String
    p1 String
    p2 String
    p3 String
    p4 String
    p5 String
    p6 String
    p7 String
    p8 String
    p9 String
    p10 String
    deriving Show
|]

dispatch :: [(String, MyArgs -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]

to_sqlite args = runSqlite (pack $ targetdb args) $ do
  runMigration migrateAll
  return ()

main = do
  args <- cmdArgs config
  let (Just register) = lookup (dbopt　args) dispatch
  -- print args
  register args

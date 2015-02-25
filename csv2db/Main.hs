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
Record
    serverTime String -- Int?
    consoleType Int
    systemVer Int
    productCode Int
    productSubCode Int
    idu Bool
    logConfVer String
    timestamp String -- Int?
    clockType Int
    uniqueId String
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
    Primary serverTime
    deriving Show Eq
|]

dispatch :: [(String, MyArgs -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]


files_to_records :: [String] -> [Record]
files_to_records csvfiles = 
    [
     Record "20150213103400" 1 2501030 385 16 False "20150109-01" "2015021310290298" 2 "097a7e482eec53225e524ddfa2c4b5b755b7eceaa507e1ac3c089ca816686ceb" "" "" "" "" "" "" "" "" "" ""
    ]



to_sqlite args = runSqlite (pack $ targetdb args) $ do
  runMigration migrateAll
  mapM insert (files_to_records (csvfiles args))
  return ()

main = do
  args <- cmdArgs config
  let (Just register) = lookup (dbopt　args) dispatch
  -- print args
  register args

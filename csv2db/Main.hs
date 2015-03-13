{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.Console.CmdArgs
import Database.Persist
import Database.Persist.Sqlite
import Data.Text (pack)
import MyArgs
import Telemetry


dispatch :: [(String, MyArgs -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]


files_to_telemetries :: [String] -> [Telemetry]
files_to_telemetries csvfiles = 
    [
     Telemetry "20150213103400" 1 2501030 385 16 False "20150109-01" "2015021310290298" 2 "097a7e482eec53225e524ddfa2c4b5b755b7eceaa507e1ac3c089ca816686ceb" "" "" "" "" "" "" "" "" "" ""
    ]



to_sqlite args = runSqlite (pack $ targetdb args) $ do
  runMigration migrateAll
  mapM insert (files_to_telemetries (csvfiles args))
  return ()

main = do
  args <- cmdArgs config
  let (Just register) = lookup (dbopt　args) dispatch
  -- print args
  register args

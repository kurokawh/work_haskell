{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.Console.CmdArgs
import qualified Data.ByteString.Lazy as BL
import Data.Text (pack)
import qualified Data.Vector as V
import qualified Data.Csv as C
import Database.Persist
import Database.Persist.Sqlite

import MyArgs
import Telemetry


--dispatch :: [(String, MyArgs -> IO ())] -- ToDo: remove 2nd argument (vlist).
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]



-- ToDo remove 2nd argument (vlist).
to_sqlite args vlist = runSqlite (pack $ targetdb args) $ do
  runMigration migrateAll
--  mapM insert (files_to_telemetries (csvfiles args))
  ids <- mapM (V.mapM insert) vlist
--  liftIO $ print ids
  return ()




file_to_vec :: String -> IO (V.Vector Telemetry)
file_to_vec filename = do
    putStrLn ("parsing : " ++ filename)
    csvData <- BL.readFile filename
    case C.decode C.NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return v

arg_to_vlist :: MyArgs -> IO [V.Vector Telemetry]
arg_to_vlist args = do
  vlist <- mapM file_to_vec (csvfiles args)
  return vlist

main = do
  args <- cmdArgs config
  let (Just to_db) = lookup (dbopt　args) dispatch
  vlist <- arg_to_vlist args
  -- print args
  to_db args vlist

{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.FilePath as FP
import System.Console.CmdArgs
import qualified Data.ByteString.Lazy as BL
import Data.Text (pack)
import qualified Data.Vector as V
import qualified Data.Csv as C
import Data.Char (ord)
import Database.Persist
import Database.Persist.Sqlite
import qualified Codec.Compression.BZip as BZ

import MyArgs
import Telemetry

-- ToDo: remove 2nd argument (vlist).
dispatch :: [([Char], MyArgs -> [V.Vector Telemetry] -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]



-- ToDo remove 2nd argument (vlist).
to_sqlite :: MyArgs -> [V.Vector Telemetry] -> IO ()
to_sqlite myargs vlist = runSqlite (pack $ targetdb myargs) $ 
  case schema myargs of
    "d12" -> do
      runMigration migrateAll_d12
      let cvlist =  map (V.map to_d12) vlist
      mapM_ (V.mapM insert) cvlist
      return ()
    "d13" -> do
      runMigration migrateAll_d13
      let cvlist =  map (V.map to_d13) vlist
      mapM_ (V.mapM insert) cvlist
      return ()
    "d29" -> do
      runMigration migrateAll_d29
      let cvlist =  map (V.map to_d29) vlist
      mapM_ (V.mapM insert) cvlist
      return ()
    "normal" -> do
      runMigration migrateAll
      mapM_ (V.mapM insert) vlist
      return ()
    _ -> error "unknown SCHEMA_INDEX."

decodeOpt :: C.DecodeOptions
decodeOpt = C.defaultDecodeOptions {
              C.decDelimiter = fromIntegral (ord '\t')
            }

-- if given file is bz2 then decompress, otherwise returan raw data
file_to_bs :: String -> IO BL.ByteString
file_to_bs filename =
    if (FP.takeExtension filename) == ".bz2"
    then do
      bzData <- BL.readFile filename
      return (BZ.decompress bzData)
    else do
      BL.readFile filename

file_to_vec :: C.FromRecord a => String -> IO (V.Vector a)
file_to_vec filename = do
    putStrLn ("parsing : " ++ filename)
    csvData <- file_to_bs filename
    case C.decodeWith decodeOpt C.NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return v

arg_to_vlist :: C.FromRecord a => MyArgs -> IO [V.Vector a]
arg_to_vlist myargs = do
  flist <- mapM file_to_vec (csvfiles myargs)
  rfiles <- recursive_files myargs
  rlist <- mapM file_to_vec rfiles
  return (flist ++ rlist)

main :: IO ()
main = do
  myargs <- cmdArgs config
  let (Just to_db) = lookup (dbopt　myargs) dispatch
  vlist <- arg_to_vlist myargs
  if length vlist == 0 
  then
      print myargs
  else
      to_db myargs (vlist :: [V.Vector Telemetry])

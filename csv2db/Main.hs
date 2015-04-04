{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.FilePath as FP
import System.Console.CmdArgs
import qualified Data.ByteString.Lazy as BL
import Data.Text (pack)
import qualified Data.Vector as V
import qualified Data.Csv as C
import qualified Data.List as L
import Data.Char (ord)
import Database.Persist
import Database.Persist.Sqlite
import qualified Codec.Compression.BZip as BZ

import MyArgs
import Telemetry


--dispatch :: [(String, MyArgs -> IO ())] -- ToDo: remove 2nd argument (vlist).
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]



-- ToDo remove 2nd argument (vlist).
to_sqlite args vlist = runSqlite (pack $ targetdb args) $ 
  case schema args of
    "d12" -> do
      runMigration migrateAll_d12
      let cvlist =  map (V.map to_d12) vlist
      mapM (V.mapM insert) cvlist
      return ()
--    "d13" -> mapM (V.mapM insert) vlist
--    "d29" -> mapM (V.mapM insert) vlist
    otherwise -> do
      runMigration migrateAll
      mapM (V.mapM insert) vlist
      return ()


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
arg_to_vlist args = do
  flist <- mapM file_to_vec (csvfiles args)
  rfiles <- recursive_files args
  rlist <- mapM file_to_vec rfiles
  return (flist ++ rlist)

main = do
  args <- cmdArgs config
  let (Just to_db) = lookup (dbopt　args) dispatch
  vlist <- arg_to_vlist args
  if length vlist == 0 
  then
      print args
  else
      to_db args (vlist :: [V.Vector Telemetry])

{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import System.FilePath as FP
import System.Console.CmdArgs
import qualified Data.ByteString.Lazy as BL
import Data.Text (pack)
import qualified Data.Vector as V
import qualified Data.Csv as C
import Data.Char (ord)
import Database.Persist.Sqlite
import qualified Codec.Compression.BZip as BZ
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Trans.Reader (ReaderT)
import MyArgs
import DbRecord



type FileDbRecord = (FilePath, V.Vector DbRecord)
    
-- ToDo: remove 2nd argument (vlist).
dispatch :: [(DbOpt, MyArgs -> [FileDbRecord] -> IO ())]
dispatch =  [ (SQLite, to_sqlite)
--            , (PostgreSQL, to_postgresql)
--            , (MySQL, to_mysql)
            ]


convert_and_insert :: Control.Monad.IO.Class.MonadIO m =>
                      [a]
                      -> Migration
                      -> (a -> Control.Monad.Trans.Reader.ReaderT SqlBackend m b)
                      -> Control.Monad.Trans.Reader.ReaderT SqlBackend m ()
convert_and_insert vlist migration insertion = do
      runMigration migration
      mapM_ insertion vlist

-- ToDo remove 2nd argument (vlist).
to_sqlite :: MyArgs -> [FileDbRecord] -> IO ()
to_sqlite myargs vlist = runSqlite (pack $ targetdb myargs) $ 
  case schema myargs of
    "s2" -> convert_and_insert vlist migrateAll_s2 insert_s2
    "s3" -> convert_and_insert vlist migrateAll_s3 insert_s3
    "normal" -> convert_and_insert vlist migrateAll insert_rec
    _ -> error "unknown SCHEMA_INDEX."

decodeOpt :: C.DecodeOptions
decodeOpt = C.defaultDecodeOptions {
              C.decDelimiter = fromIntegral (ord '\t')
            }

-- if given file is bz2 then decompress, otherwise returan raw data
file_to_bs :: FilePath -> IO BL.ByteString
file_to_bs file =
    if (FP.takeExtension file) == ".bz2"
    then do
      bzData <- BL.readFile file
      return (BZ.decompress bzData)
    else do
      BL.readFile file

file_to_vec :: C.FromRecord a => FilePath -> IO (FilePath, V.Vector a)
file_to_vec file = do
    putStrLn ("parsing : " ++ file)
    csvData <- file_to_bs file
    case C.decodeWith decodeOpt C.NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return (file_to_filename file, v)

-- extract a filename from a (relative) file path.
-- if extension is ".bz2", remove it.
file_to_filename :: FilePath -> FilePath
file_to_filename file =
    if (FP.takeExtension file) == ".bz2"
    then
      FP.takeBaseName file
    else
      FP.takeFileName file


arg_to_vlist :: C.FromRecord a => MyArgs -> IO [(FilePath, V.Vector a)]
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
      to_db myargs (vlist :: [FileDbRecord])

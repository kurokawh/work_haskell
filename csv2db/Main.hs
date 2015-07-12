{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import System.Console.CmdArgs
import Data.Text (pack)
import Database.Persist.Sqlite
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Trans.Reader (ReaderT)
import MyArgs
import DbRecord



   
-- ToDo: remove 2nd argument (vlist).
dispatch :: [(DbOpt, MyArgs -> [FilePath] -> IO ())]
dispatch =  [ (SQLite, to_sqlite)
--            , (PostgreSQL, to_postgresql)
--            , (MySQL, to_mysql)
            ]


convert_and_insert :: Control.Monad.IO.Class.MonadIO m =>
                      [a]
                      -> Migration
                      -> (a -> Control.Monad.Trans.Reader.ReaderT SqlBackend m b)
                      -> Control.Monad.Trans.Reader.ReaderT SqlBackend m ()
convert_and_insert flist migration insertion = do
      runMigration migration
      mapM_ insertion flist

-- ToDo remove 2nd argument (vlist).
to_sqlite :: MyArgs -> [FilePath] -> IO ()
to_sqlite myargs flist = runSqlite (pack $ targetdb myargs) $ 
  case schema myargs of
    "s2" -> convert_and_insert flist migrateAll_s2 insert_s2
    "s3" -> convert_and_insert flist migrateAll_s3 insert_s3
    "normal" -> convert_and_insert flist migrateAll insert_rec
    _ -> error "unknown SCHEMA_INDEX."


-- return filelist which is given as arguments or
-- is searched recursively with -r option.
arg_to_flist :: MyArgs -> IO [FilePath]
arg_to_flist myargs = do
  let flist = csvfiles myargs
  rfiles <- recursive_files myargs
  return (flist ++ rfiles)

main :: IO ()
main = do
  myargs <- cmdArgs config
  let (Just to_db) = lookup (dbopt　myargs) dispatch
  flist <- arg_to_flist myargs
  if length flist == 0 
  then
      print myargs
  else
      to_db myargs flist

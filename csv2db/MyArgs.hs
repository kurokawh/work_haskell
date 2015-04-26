{-# LANGUAGE DeriveDataTypeable #-}

module MyArgs 
( MyArgs
, config
, dbopt
, schema
, targetdb
, csvfiles
, recursive_files
, DbOpt(..)
) where

import System.Directory
import System.FilePath
import System.Console.CmdArgs

data DbOpt = SQLite 
           | PostgreSQL 
           | MySQL 
             deriving (Data, Typeable, Eq, Show, Read)
data MyArgs = MyArgs {
      dbopt    :: DbOpt
    , schema   :: String
    , recursive :: String
    , targetdb :: String
    , csvfiles :: [String]
    } deriving (Data,Typeable,Show)

help_dbopt = "specify DB type. default DB is 'sqlite'.\n"
             ++ "'postgresql', 'mysql' & etc. may be supported in the future."
help_schema = "specify table name.\n"
              ++ "specify predefined schema index such as 'd12', 'd13', etc.\n"
              ++ "default is 'normal' which stores all values as string.\n"
help_recursive = "specify directory to iterate all files in it recursively."
help_targetdb = "specify DB file for sqlite."
help_csvfiles = "specify one ore more csv files.\n"
	        ++ "one file must be specified at the minimum."
help_program = "parse CSV files and store all data into DB.\n"
               ++ "TARGET_DB is the mandatory argument."

config = MyArgs {
      dbopt   = SQLite &= typ "TARGET_DB_TYPE" &= help help_dbopt
    , schema  = "normal" &= typ "SCHEMA_INDEX" &= help help_schema
    , recursive = "" &= typ "RECURSIVE_DIR" &= help help_recursive
    , targetdb  = def &= typ "TARGET_DB" &= argPos 0 -- &= help help_targetdb
    , csvfiles = def &= typ "CSV_FILES" &= args -- &= help help_csvfiles
} &= program "csv2db" &= help help_program


-- Debug Print: default off
putStrLnDbg :: String -> IO ()
--putStrLnDbg s = putStrLn s
putStrLnDbg s = return ()

recursive_files :: MyArgs -> IO [String]
recursive_files args
  | dir == "" = return [] -- recursive option is not set
  | otherwise = operate_dir dir
  where
    dir = recursive args

operate_dir :: FilePath -> IO ([String])
operate_dir dir = do
  putStrLnDbg $ "operate_dir dir: " ++ dir
  if (takeFileName dir) == ".." then do
    putStrLnDbg "\tskip"
    return [] -- skip parent dir
  else do
    putStrLnDbg ("[d]: " ++ dir)
    entries <- getDirectoryContents dir
    putStrLnDbg $ "\toperate_dir: entries: " ++ (show entries)
    filell <- mapM (operate_abspath.((</>) dir))  entries
    putStrLnDbg $ "\toperate_dir: fll: " ++ show filell
    return $ concat filell

operate_file :: FilePath -> IO ([String])
operate_file file = do
  putStrLnDbg $ "operate_file file: " ++ file
  if (takeFileName file) == "." then do
    putStrLnDbg "\tskip"
    return [] -- skip current dir
  else do
    putStrLnDbg ("[f]: " ++ file)
    return [file]

operate_file_or_dir :: FilePath -> IO ([String])
operate_file_or_dir entry = do
  isdir <- doesDirectoryExist entry
  if isdir then
    operate_dir entry
  else
    operate_file entry

operate_abspath :: FilePath -> IO ([String])
operate_abspath abspath
  | entry == ".." = return []
  | entry == "." = return []
  | otherwise = operate_file_or_dir abspath
  where
    entry = takeFileName abspath

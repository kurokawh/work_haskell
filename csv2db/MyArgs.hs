{-# LANGUAGE DeriveDataTypeable #-}

module MyArgs 
( MyArgs
, config
, dbopt
, schema
, targetdb
, csvfiles
, recursive_files
) where

import System.Directory
import System.FilePath
import System.Console.CmdArgs

data MyArgs = MyArgs {
      dbopt    :: String
    , schema   :: String
    , recursive :: String
    , targetdb :: String
    , csvfiles :: [String]
    } deriving (Data,Typeable,Show)

help_dbopt = "specify db type. default db is 'sqlite'.\n"
             ++ "'postgresql', 'mysql' & etc. will be supported in the future."
help_schema = "specify table name.\n"
              ++ "specify field name & field type for each column.\n"
              ++ "- default filed name: c1, c2, ...\n"
              ++ "- default field type: VARCHAR."
help_recursive = "specify directory to iterate all files recursively."
help_targetdb = "specify DB file for sqlite."
help_csvfiles = "specify one ore more csv files.\n"
	        ++ "one file must be specified at the minimum."
help_program = "parse CSV files and store all data into DB."

config = MyArgs {
      dbopt   = "sqlite" &= typ "TARGET_DB_TYPE" &= help help_dbopt
    , schema  = "" &= typ "SCHEMA_DEF_FILE" &= help help_schema
    , recursive = "" &= typ "RECURSIVE_DIR" &= help help_recursive
    , targetdb  = def &= typ "TARGET_DB" &= argPos 0 -- &= help help_targetdb
    , csvfiles = def &= typ "CSV_FILES" &= args -- &= help help_csvfiles
} &= program "csv2db" &= help help_program



recursive_files :: MyArgs -> IO [String]
recursive_files args
  | dir == "" = return [] -- recursive option is not set
  | otherwise = operate_dir dir
  where
    dir = recursive args

operate_dir :: FilePath -> IO ([String])
operate_dir dir = do
  putStrLn $ "operate_dir dir: " ++ dir
  if (takeFileName dir) == ".." then do
    putStrLn "\tskip"
    return [] -- skip parent dir
  else do
    putStrLn ("[d]: " ++ dir)
    entries <- getDirectoryContents dir
    putStrLn $ "\toperate_dir: entries: " ++ (show entries)
    filell <- mapM (operate_abspath.((</>) dir))  entries
    putStrLn $ "\toperate_dir: fll: " ++ show filell
    return $ concat filell

operate_file :: FilePath -> IO ([String])
operate_file file = do
  putStrLn $ "operate_file file: " ++ file
  if (takeFileName file) == "." then do
    putStrLn "\tskip"
    return [] -- skip current dir
  else do
    putStrLn ("[f]: " ++ file)
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

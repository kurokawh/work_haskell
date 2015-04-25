{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs

data DbOpt = SQLite | PostgreSQL | MySQL deriving (Data, Typeable, Eq, Show, Read)

data MyArgs = MyArgs {
      dbopt    :: DbOpt
    , schema   :: String
    , recursive :: String
    , targetdb :: String
    , csvfiles :: [String]
    } deriving (Data,Typeable,Show)

help_dbopt = "specify DB type. default DB is 'sqlite'.\n"
             ++ "'postgresql', 'mysql' & etc. may be supported in the future."
help_schema = "specify table type.\n"
              ++ "specify predefined schema index such as 'd12', 'd13', etc.\n"
              ++ "default is 'normal' which stores all values as string.\n"
help_recursive = "specify directory to iterate all files in it recursively."
help_targetdb = "specify DB file/connection name."
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

main = print =<< cmdArgs config

{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs

data MyArgs = MyArgs {
      dbopt    :: String
    , schema   :: String
    , targetdb   :: String
    , csvfiles :: [String]
    } deriving (Data,Typeable,Show)

help_dbopt = "specify db type. default db is sqlite.\n"
             ++ "PostgreSQL, MySQL, etc. will be supported in the future."
help_schema = "specify table name.\n"
              ++ "specify field name & field type for each column.\n"
              ++ "- default filed name: c1, c2, ...\n"
              ++ "- default field type: VARCHAR."
help_targetdb = "specify DB file for sqlite."
help_csvfiles = "specify one ore more csv files.\n"
	        ++ "one file must be specified at the minimum."
help_program = "parse CSV files and store all data into DB."

config = MyArgs {
      dbopt   = "sqlite" &= typ "TARGET_DB_TYPE" &= help help_dbopt
    , schema  = "" &= typ "SCHEMA_DEF_FILE" &= help help_schema
    , targetdb  = def &= typ "TARGET_DB" &= argPos 0 -- &= help help_targetdb
    , csvfiles = def &= typ "CSV_FILES" &= args -- &= help help_csvfiles
} &= program "csv2db" &= help help_program

dispatch :: [(String, MyArgs -> IO ())]
dispatch =  [ ("sqlite", to_sqlite)
--            , ("postgresql", to_postgresql)
--            , ("mysql", to_mysql)
            ]

to_sqlite args = do
  return ()

main = do
  args <- cmdArgs config
  let (Just register) = lookup (dbopt　args) dispatch
  -- print args
  register args

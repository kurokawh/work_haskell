{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import System.Console.CmdArgs
import MyArgs
import DbRecord



-- dispacher for each DB.
-- currently only SQLite is supported.
dispatch :: [(DbOpt, MyArgs -> IO ())]
dispatch =  [ (SQLite, to_sqlite)
--            , (PostgreSQL, to_postgresql)
--            , (MySQL, to_mysql)
            ]



main :: IO ()
main = do
  myargs <- cmdArgs config
  let (Just to_db) = lookup (dbopt　myargs) dispatch
  to_db myargs

{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import System.Console.CmdArgs
import MyArgs
import DbRecord



   
-- ToDo: remove 2nd argument (vlist).
dispatch :: [(DbOpt, MyArgs -> [FilePath] -> IO ())]
dispatch =  [ (SQLite, to_sqlite)
--            , (PostgreSQL, to_postgresql)
--            , (MySQL, to_mysql)
            ]



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

import Control.Monad.Reader

data Config = Config { verbose :: Int -- detailed level (from 1 to 10)
                     , debug :: Bool  -- debug mode flag.
                     }

-- obtain detailed level from Config data value.
-- return 10 if debug mode flag is true.
-- otherwise, return detailed level value in Config data.
configToLevel :: Config -> Int
configToLevel config
  | debug config = 10
  | otherwise    = verbose config


outputLevel :: Reader Config [Int]
outputLevel = do
  config <- ask
  return [ 1 .. configToLevel config ]

-- a monad action.
-- parameters are:
-- - Int: detailed level
-- - String: a string to show
-- check if a given detailed level is equel to/less than
-- a detailed level from environmental setting,
-- then return string with Just x. otherwise return Nothing.
output :: Int -> String -> Reader Config (Maybe String)
output level str = do
  ls <- outputLevel
  return (if level `elem` ls then Just str else Nothing)
  -- elem: check if element is contained in a list.

{- ghci
*Main> runReader (output 1 "test output:1 on env:1.") (Config 1 False)
Just "test output with level 1 on env:1."
*Main> runReader (output 2 "test output:2 on env:1.") (Config 1 False)
Nothing
*Main> runReader (output 2 "test output:2 on env:2.") (Config 2 False)
Just "test output with level 2 on env:2."
*Main> runReader (output 2 "test output:2 on env:1(debug).") (Config 2 True)
Just "test output with level 2 on env:1(debug)."
-}

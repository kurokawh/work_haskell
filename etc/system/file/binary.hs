{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import System.IO

import qualified Data.ByteString as BS
import qualified Data.Word as W

    

-- following error returns as explected if file is not existed.
-- open.hs xxx: openFile: does not exist (No such file or directory)
main = do
  (from:to:xs) <- getArgs
  putStrLn ("from: " ++ from)
  putStrLn ("to: " ++ to)
  contents <- BS.readFile from
  print (BS.unpack contents)
  let x = BS.unpack contents
--  BS.writeFile to ((take 8 (drop 73 contents)) ++ (take 8 (drop 51 contents)))
  BS.writeFile to (BS.pack ((take 8 (drop 73 x)) ++ (take 8 (drop 51 x))))

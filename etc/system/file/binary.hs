{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment   
import System.IO

import qualified Data.ByteString as BS
import qualified Data.Word as W

    
-- binary file operation sample.
-- returns error if 2 files are not given.
-- % binary from to
--   from: file to read.
--     to: file to write (2 8-byte blocks are read from 'from' file).
main = do
  (from:to:xs) <- getArgs
  putStrLn ("from: " ++ from)
  putStrLn ("to: " ++ to)
  contents <- BS.readFile from -- BS.readFile :: FilePath -> IO BS.ByteString
  print (BS.unpack contents)
  let x = BS.unpack contents   -- BS.unpack :: BS.ByteString -> [W.Word8]
  BS.writeFile to (BS.pack ((take 8 (drop 73 x)) ++ (take 8 (drop 51 x))))


-- NOTE:
--  BS.readFile is different from readFile.
--    readFile :: FilePath -> IO String
--    BS.readFile :: FilePath -> IO BS.ByteString

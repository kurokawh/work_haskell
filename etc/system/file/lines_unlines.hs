{-# LANGUAGE OverloadedStrings          #-}

import System.Environment   
import System.IO

import qualified Data.ByteString.Char8 as BSC
import Data.ByteString.Base64 (decodeLenient)


main = do
  (from:to:xs) <- getArgs
  putStrLn ("from: " ++ from)
  putStrLn ("to: " ++ to)
  contents <- BSC.readFile from -- BSC.readFile :: FilePath -> IO BSC.ByteString

  let inList = BSC.lines contents  
  let outList = map convertFunc inList
  print $ BSC.unlines outList

  putStrLn "DONE."


convertFunc:: BSC.ByteString -> BSC.ByteString
convertFunc = (BSC.map replaceChar) . decodeLenient

replaceChar :: Char -> Char
replaceChar '\r' = '_'
replaceChar '\n' = '_'
replaceChar c = c


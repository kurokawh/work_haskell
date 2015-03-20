import System.Environment   
import System.IO

import qualified Data.Vector as V
import Data.Csv
import qualified Data.ByteString.Lazy as BL
import Control.Applicative (Alternative, Applicative, (<*>), (<$>), (<|>),
                            (<*), (*>), empty, pure)

data Person = Person { 
      name :: !String, age :: !Int 
}  deriving (Eq, Ord, Show)
instance FromRecord Person where
    parseRecord v
        | V.length v == 2 = Person <$>
                          v .! 0 <*>
                          v .! 1
        | V.length v == 10 = Person <$>
                          v .! 0 <*>
                          v .! 1
        | V.length v == 20 = Person <$>
                          v .! 18 <*>
                          v .! 19
    
test_open :: String -> IO (V.Vector Person)
test_open file = do
  putStrLn "test_open"
  handle <- openFile file ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle
  --error ""
  putStrLn ("call ReadFile" ++ file)
  csvData <- BL.readFile file
  --csvData <- readFile file
  putStrLn "ret ReadFile"
  case decode NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return v

-- following error returns as explected if file is not existed.
-- open.hs xxx: openFile: does not exist (No such file or directory)
main = do
  (file:xs) <- getArgs
  test_open file
  putStrLn "main"
  handle <- openFile file ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

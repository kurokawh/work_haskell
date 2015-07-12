module FileToVec
    ( file_to_vec
    , file_to_filename
    ) where


import System.FilePath as FP
import Data.Char (ord)
import qualified Data.Csv as C
import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as BL
import qualified Codec.Compression.BZip as BZ



decodeOpt :: C.DecodeOptions
decodeOpt = C.defaultDecodeOptions {
              C.decDelimiter = fromIntegral (ord '\t')
            }

-- if given file is bz2 then decompress, otherwise returan raw data
file_to_bs :: FilePath -> IO BL.ByteString
file_to_bs file =
    if (FP.takeExtension file) == ".bz2"
    then do
      bzData <- BL.readFile file
      return (BZ.decompress bzData)
    else do
      BL.readFile file

-- parse given file and return CSV/TSV vector.
file_to_vec :: C.FromRecord a => FilePath -> IO (V.Vector a)
file_to_vec file = do
    putStrLn ("parsing : " ++ file)
    csvData <- file_to_bs file
    case C.decodeWith decodeOpt C.NoHeader csvData of
        Left err -> do
          putStrLn err
          error err
        Right v -> do
          --putStrLn "OK!"
          return v

-- extract a filename from a (relative) file path.
-- if extension is ".bz2", remove it.
file_to_filename :: FilePath -> FilePath
file_to_filename file =
    if (FP.takeExtension file) == ".bz2"
    then
      FP.takeBaseName file
    else
      FP.takeFileName file


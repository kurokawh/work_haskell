import System.Environment
import Data.ByteString.Char8 (pack, unpack)
import Network.HTTP.Types.URI (urlDecode)

url_decode :: String -> String
url_decode = unpack.(urlDecode False).pack

main = do
  (arg:_) <- getArgs
  let dec = url_decode arg
  putStrLn  ("org: " ++ arg)
  putStrLn  ("out: " ++ dec)

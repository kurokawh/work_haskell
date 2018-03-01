{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Control.Exception (try)


createRequest :: String -> IO Request
createRequest uri = do
  eRequest <- try $ parseRequest uri
  case eRequest of
    Left e -> do
         print (e :: HttpException)
         parseRequest "http://unknown-host:80/" -- valid url but not exists
    Right request -> return $ request


main :: IO ()
main = do
  manager <- newManager defaultManagerSettings
  request <- createRequest "///xxx//invalid uri/" -- invalid url

  eResponse <- try $ httpLbs request manager
  case eResponse of
    Left e -> print (e :: HttpException)
    Right response -> do
       putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
       print $ responseBody response


{--
--import qualified Data.ByteString.Lazy.Char8 as L8main :: IO ()
main = do
    manager <- newManager defaultManagerSettings
    eresponse <- try $ httpLbs "http://does-not-exist" manager

    case eresponse of
        Left e -> print (e :: HttpException)
        Right response -> L8.putStrLn $ responseBody response

-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md
--}

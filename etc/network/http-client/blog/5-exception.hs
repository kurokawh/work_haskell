{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Control.Exception (try)
import qualified Data.ByteString.Lazy.Char8 as L8

{--
main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request <- parseRequest "http://httpbin.org/get"
  eResponse <- try $ httpLbs request manager

  case eResponse of
    Left e -> print (e :: HttpException)
    Right response -> do
       putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
       print $ responseBody response
--}

main :: IO ()
main = do
    manager <- newManager defaultManagerSettings
    eresponse <- try $ httpLbs "http://does-not-exist" manager

    case eresponse of
        Left e -> print (e :: HttpException)
        Right response -> L8.putStrLn $ responseBody response

-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md


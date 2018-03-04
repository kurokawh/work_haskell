{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Control.Exception (try)
import System.Environment (getArgs)


createRequest :: [String] -> IO Request
createRequest [] = do
  putStrLn "NOTE: no argument is given. so use not existing url."
  parseRequest "http://unknown-host:80/" -- valid but not exists
createRequest args = do
  let url = head args
  eRequest <- try $ parseRequest url
  case eRequest of
    Left e -> do
      print (e :: HttpException)
      putStrLn $ "given url (1st argument) is invalid: " ++ url
      error "error!"
    Right request -> return $ request


main :: IO ()
main = do
  args <- getArgs
  manager <- newManager defaultManagerSettings
  request <- createRequest args

  eResponse <- try $ httpLbs request manager
  case eResponse of
    Left e -> do
      print (e :: HttpException)
      putStrLn $ "cannot reach server with given url: " ++ (head args)
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

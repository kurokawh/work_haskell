{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request <- parseRequest "http://httpbin.org/get"
--  response <- httpLbs request manager
--  response <- withResponse request manager receiveResponse
  withResponse request manager receiveResponse
--  response <- withResponse request manager res

{--
  putStrLn $ "response version: " ++ (show $ responseVersion response)
  putStrLn $ "status code: " ++ (show $ statusCode $ responseStatus response)
  putStrLn $ "response header: " ++ (show $ responseHeaders response)
  putStrLn $ "response body: " ++ (show $ responseBody response)
--}
--  return ()

--receiveResponse :: Response BodyReader -> IO Data.ByteString.Internal.ByteString
receiveResponse response = do
  putStrLn $ "response version: " ++ (show $ responseVersion response)
  putStrLn $ "status code: " ++ (show $ statusCode $ responseStatus response)
  putStrLn $ "response header: " ++ (show $ responseHeaders response)
--  putStrLn $ "response body: " ++ (show $ responseBody response)
  bs <- brRead $ responseBody response
  putStrLn $ "response body: " ++ (show bs)
  return ()

--res x = undefined


-- https://stackoverflow.com/questions/36733472/how-to-store-a-functions-return-argument-in-haskell

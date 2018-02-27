{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request <- parseRequest "http://httpbin.org/get"
--  response <- httpLbs request manager
  response <- withResponse request manager receiveResponse
--  response <- withResponse request manager brRead

  putStrLn $ "response version: " ++ (show $ responseVersion response)
  putStrLn $ "status code: " ++ (show $ statusCode $ responseStatus response)
  putStrLn $ "response header: " ++ (show $ responseHeaders response)
  putStrLn $ "response body: " ++ (show $ responseBody response)


receiveResponse (Response br) = do
  return $ brRead br

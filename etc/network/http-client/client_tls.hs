#!/usr/bin/env stack
-- stack script --resolver lts-8.22
import Network.HTTP.Client
import Network.HTTP.Client.TLS   (tlsManagerSettings)
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
    manager <- newManager tlsManagerSettings

--    request <- parseRequest "http://httpbin.org/get"
    request <- parseRequest "https://www.google.co.jp/"
    response <- httpLbs request manager

    putStrLn $ "The status code was: " ++
               show (statusCode $ responseStatus response)
    print $ responseBody response

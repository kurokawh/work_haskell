{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Network.HTTP.Client.TLS (tlsManagerSettings)

import Network.HTTP.Client.Internal
mySettings = tlsManagerSettings { managerResponseTimeout = responseTimeoutMicro 60000000 }
--mySettings = tlsManagerSettings { managerResponseTimeout = responseTimeoutMicro 5000000 }

main :: IO ()
main = do
--  manager <- newManager tlsManagerSettings
  
--  manager <- newManager $ managerSetProxy noProxy mySettings
--  manager <- newManager $ managerSetProxy defaultProxy mySettings
  manager <- newManager $ managerSetProxy (useProxy $ Proxy "127.0.0.2" 8080) mySettings
--  manager <- newManager mySettings
    
  request <- parseRequest "https://httpbin.org/get"
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
  print $ responseBody response

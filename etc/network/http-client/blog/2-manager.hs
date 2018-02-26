{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Network.HTTP.Client.TLS (tlsManagerSettings)

import Network.HTTP.Client.Internal
--mySettings = ManagerSettings { managerResponseTimeout = responseTimeoutMicro 60000000 }
mySettings = tlsManagerSettings { managerResponseTimeout = responseTimeoutMicro 60000000 }

main :: IO ()
main = do
--  manager <- newManager tlsManagerSettings
--  manager <- newManager $ managerSetProxy (proxyEnvironment Nothing) tlsManagerSettings
  manager <- newManager mySettings
--  let manager = managerTls { managerResponseTimeout = 60000000 }
--  manager <- newManager  tlsManagerSettings { managerResponseTimeout = 60000000 }
    
  request <- parseRequest "https://httpbin.org/get"
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
  print $ responseBody response

{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Network.HTTP.Client.TLS (tlsManagerSettings) -- 新たにimport文を追加


import Network.HTTP.Client.Internal
-- tlsManagerSettingsをベースにmanagerResponseTimeoutをデフォルトの30秒から5秒に変更
mySettings :: ManagerSettings
mySettings = tlsManagerSettings { managerResponseTimeout = responseTimeoutMicro 5000000 } 


main :: IO ()
main = do
  -- manageSetProxyでデフォルトのプロキシ設定を上書く。
  -- tlsManagerSettingsを利用するとこでhttps通信が可能になる。
  manager <- newManager $ managerSetProxy (useProxy $ Proxy "127.0.0.1" 8080) tlsManagerSettings


--  manager <- newManager tlsManagerSettings
--  manager <- newManager $ managerSetProxy noProxy tlsManagerSettings
--  manager <- newManager $ managerSetProxy defaultProxy tlsManagerSettings
--  manager <- newManager mySettings


  request <- parseRequest "https://httpbin.org/get" -- https通信に変更
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
  print $ responseBody response



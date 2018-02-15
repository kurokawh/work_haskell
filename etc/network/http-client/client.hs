{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client

main :: IO ()
main = do
    let settings = managerSetProxy
            (proxyEnvironment Nothing)
            defaultManagerSettings
    man <- newManager settings
    let req = "http://httpbin.org"
            -- Note that the following settings will be completely ignored.
--            { proxy = Just $ Proxy "localhost" 1234
--            }
    httpLbs req man >>= print

      
-- https://hackage.haskell.org/package/http-client

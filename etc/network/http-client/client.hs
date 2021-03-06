{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client

main :: IO ()
main = do
    let settings = managerSetProxy -- refer environment variable: http_proxy
            (proxyEnvironment Nothing)
            defaultManagerSettings
    man <- newManager settings
    let req = "http://httpbin.org"
--    let req = "https://www.google.co.jp/" -- TlsNotSupported Exception

            -- Note that the following settings will be completely ignored.
--            { proxy = Just $ Proxy "localhost" 1234
--            }
    httpLbs req man >>= print

      
-- https://hackage.haskell.org/package/http-client
-- Caveats
{--
By default, http-client will respect the http_proxy and https_proxy environment variables. See the proxy examples below for information on how to bypass this.
--}

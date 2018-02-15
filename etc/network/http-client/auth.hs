#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import           Network.HTTP.Types.Status  (statusCode)

main :: IO ()
main = do
    manager <- newManager $ managerSetProxy (proxyEnvironment Nothing) tlsManagerSettings -- this refers https_proxy.

    response <- httpLbs (applyBasicAuth "user" "pass" "https://github.com/") manager

    putStrLn $ "The status code was: "
            ++ show (statusCode $ responseStatus response)
    L8.putStrLn $ responseBody response


-- http://hackage.haskell.org/package/http-client-0.5.10/docs/Network-HTTP-Client.html
-- applyBasicAuth :: ByteString -> ByteString -> Request -> Request

#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import           Network.HTTP.Types.Status  (statusCode)

main :: IO ()
main = do
--    manager <- newManager $ managerSetProxy noProxy tlsManagerSettings -- this does not refer https_proxy.
    manager <- newManager $ managerSetProxy (proxyEnvironment Nothing) tlsManagerSettings -- this refers https_proxy.

--    response <- httpLbs "http://httpbin.org/get" manager
    response <- httpLbs "https://www.google.co.jp/" manager

    putStrLn $ "The status code was: "
            ++ show (statusCode $ responseStatus response)
    L8.putStrLn $ responseBody response

-- https://hackage.haskell.org/package/http-client
-- Porxy settings

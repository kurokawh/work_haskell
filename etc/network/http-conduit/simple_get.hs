#!/usr/bin/env runghc


{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Simple
import qualified Data.ByteString.Char8 as B8

{--
main :: IO ()
main = httpBS "https://example.com" >>= B8.putStrLn . getResponseBody
--}
main :: IO ()
main = do
    res <- httpLBS "https://example.com"
    print (getResponseBody res)



-- need {-# LANGUAGE FlexibleContexts  #-} to http-client-0.5.10/Network/HTTP/Proxy.hs to compile on ghc-7.10.2.
--
-- cabal exec ghci
-- Prelude > main

#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
--import qualified Data.Yaml             as Yaml
import           Network.HTTP.Simple

main :: IO ()
main = do
    response <- httpJSON "POST http://httpbin.org/post"

    putStrLn $ "The status code was: " ++
               show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
--    S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
    print $ (getResponseBody response :: Value)


-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md

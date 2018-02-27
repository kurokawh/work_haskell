{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

--  initialRequest <- parseRequest "http://httpbin.org/headers"
  initialRequest <- parseRequest "http://httpbin.org/anything?foo=bar&xxx=yyy"
  let request = initialRequest
          { method = "POST"
          , requestBody = "body string."
          , requestHeaders =
              [ ("User-Agent", "New Agent!")
              , ("Content-Type", "text/plain")
              , ("Added-Header", "hoge")
              ]
          }
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
  print $ responseBody response


{--
#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import           Data.Aeson                 (encode, object, (.=))
import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import           Network.HTTP.Types.Status  (statusCode)

main :: IO ()
main = do
    manager <- newManager tlsManagerSettings

    -- Create the request
    let requestObject = object
            [ "name" .= ("Alice" :: String)
            , "age"  .= (35 :: Int)
            ]
    initialRequest <- parseRequest "http://httpbin.org/post"
    let request = initialRequest
            { method = "POST"
            , requestBody = RequestBodyLBS $ encode requestObject
            , requestHeaders =
                [ ("Content-Type", "application/json; charset=utf-8")
                ]
            }

    response <- httpLbs request manager
    putStrLn $ "The status code was: "
            ++ show (statusCode $ responseStatus response)
    L8.putStrLn $ responseBody response
    
--}

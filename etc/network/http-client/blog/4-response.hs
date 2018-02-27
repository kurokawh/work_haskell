{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  initialRequest <- parseRequest "http://httpbin.org/anything"
  let request = initialRequest
          { method = "POST"   -- "GET", "PUT", "DELETE"などのメソッドを指定
          , queryString = "foo=bar&xxx=yyy" -- parseRequestのuriに記述してもよい
          , requestHeaders =  -- ヘッダはタプル（名前、値）のリストで指定
              [ ("User-Agent", "New Agent!")
              , ("Content-Type", "text/plain")
              , ("Added-Header", "hoge")
              ]
          , requestBody = "body string."
          }
  let authRequest = applyBasicAuth "user" "pass" request -- ベーシック認証情報付与
  response <- httpLbs authRequest manager

  putStrLn $ "response version: " ++ (show $ responseVersion response)
  putStrLn $ "status code: " ++ (show $ statusCode $ responseStatus response)
  putStrLn $ "response header: " ++ (show $ responseHeaders response)
  putStrLn $ "response body: " ++ (show $ responseBody response)


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

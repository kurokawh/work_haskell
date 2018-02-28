{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import qualified Data.ByteString as B

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request <- parseRequest "http://httpbin.org/get"
--  response <- httpLbs request manager
  withResponse request manager receiveResponse


receiveResponse :: Response BodyReader -> IO ()
receiveResponse response = do
  putStrLn $ "response version: " ++ (show $ responseVersion response)
  putStrLn $ "status code: " ++ (show $ statusCode $ responseStatus response)
  putStrLn $ "response header: " ++ (show $ responseHeaders response)

  -- receive body data block by block
  let loop = do
        bs <- brRead $ responseBody response
        if B.null bs
          then putStrLn "\nFinished response body"
          else do
            --B.hPut stdout bs
            print bs
            loop
  loop


-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md
-- https://stackoverflow.com/questions/36733472/how-to-store-a-functions-return-argument-in-haskell
